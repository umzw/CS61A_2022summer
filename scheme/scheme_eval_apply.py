import sys

from pair import *
from scheme_utils import *
from ucb import main, trace

import scheme_forms

##############
# Eval/Apply #
##############


def scheme_eval(expr, env, _=None):  # Optional third argument is ignored
    """Evaluate Scheme expression EXPR in Frame ENV.

    >>> expr = read_line('(+ 2 2)')
    >>> expr
    Pair('+', Pair(2, Pair(2, nil)))
    >>> scheme_eval(expr, create_global_frame())
    4
    """
    # Evaluate atoms
    if scheme_symbolp(expr):
        return env.lookup(expr)
    elif self_evaluating(expr):
        return expr

    # All non-atomic expressions are lists (combinations)
    if not scheme_listp(expr):
        raise SchemeError('malformed list: {0}'.format(repl_str(expr)))
    first, rest = expr.first, expr.rest
    if scheme_symbolp(first) and first in scheme_forms.SPECIAL_FORMS:
        return scheme_forms.SPECIAL_FORMS[first](rest, env)
    else:
        # BEGIN PROBLEM 3
        "*** YOUR CODE HERE ***"
        procedure = scheme_eval(first, env)
        args = rest.map(lambda x:scheme_eval(x, env))#Pair.map(lambda x:scheme_eval(x, env), rest)
        return scheme_apply(procedure, args, env)
        # END PROBLEM 3
        # bymyself BEGIN PROBLEM EC
        # procedure = scheme_eval(first, env)
        # if not isinstance(procedure, apply_macroProcedure):
        #     args = rest.map(lambda x:scheme_eval(x, env))#Pair.map(lambda x:scheme_eval(x, env), rest)
        #     return scheme_apply(procedure, args, env)
        # return scheme_eval(procedure.apply_macro(rest, env), env)


# class apply_macroProcedure(LambdaProcedure):
#     def apply_macro(self, operands, env):
#         return complete_apply(self, operands, env)

def scheme_apply(procedure, args, env):
    """Apply Scheme PROCEDURE to argument values ARGS (a Scheme list) in
    Frame ENV, the current environment."""
    validate_procedure(procedure)
    if not isinstance(env, Frame):
       assert False, "Not a Frame: {}".format(env)
    if isinstance(procedure, BuiltinProcedure):
        # BEGIN PROBLEM 2
        "*** YOUR CODE HERE ***"
        lst =[]
        while args:
            lst += [args.first]
            args = args.rest
        if procedure.need_env:
            lst += [env]
        # END PROBLEM 2
        try:
            # BEGIN PROBLEM 2
            "*** YOUR CODE HERE ***"
            return procedure.py_func(*lst)
            # END PROBLEM 2
        except TypeError as err:
            raise SchemeError('incorrect number of arguments: {0}'.format(procedure))
    elif isinstance(procedure, LambdaProcedure):
        # BEGIN PROBLEM 9
        "*** YOUR CODE HERE ***"
        new_child_frame = procedure.env.make_child_frame(procedure.formals, args)
        return eval_all(procedure.body, new_child_frame)
        # END PROBLEM 9
    elif isinstance(procedure, MuProcedure):
        # BEGIN PROBLEM 11
        "*** YOUR CODE HERE ***"
        new_child_frame = env.make_child_frame(procedure.formals, args)
        return eval_all(procedure.body, new_child_frame)
        # END PROBLEM 11
    else:
        assert False, "Unexpected procedure: {}".format(procedure)


def eval_all(expressions, env):
    """Evaluate each expression in the Scheme list EXPRESSIONS in
    Frame ENV (the current environment) and return the value of the last.

    >>> eval_all(read_line("(1)"), create_global_frame())
    1
    >>> eval_all(read_line("(1 2)"), create_global_frame())
    2
    >>> x = eval_all(read_line("((print 1) 2)"), create_global_frame())
    1
    >>> x
    2
    >>> eval_all(read_line("((define x 2) x)"), create_global_frame())
    2
    """
    # # BEGIN PROBLEM 6
    # if expressions is nil:
    #     return
    # while expressions.rest:
    #     scheme_eval(expressions.first, env)
    #     expressions = expressions.rest
    # return scheme_eval(expressions.first, env)
    # # return scheme_eval(expressions.first, env)  # replace this with lines of your own code
    # # END PROBLEM 6

    #EC
    val = None
    while expressions:
        if expressions.rest:
            val = scheme_eval(expressions.first, env)
        else:
            val =scheme_eval(expressions.first, env, True)
        expressions = expressions.rest
    return val

##################
# Tail Recursion #
##################

class Unevaluated:
    """An expression and an environment in which it is to be evaluated."""

    def __init__(self, expr, env):
        """Expression EXPR to be evaluated in Frame ENV."""
        self.expr = expr
        self.env = env


def complete_apply(procedure, args, env):
    """Apply procedure to args in env; ensure the result is not an Unevaluated."""
    validate_procedure(procedure)
    val = scheme_apply(procedure, args, env)
    if isinstance(val, Unevaluated):
        return scheme_eval(val.expr, val.env)
    else:
        return val


def optimize_tail_calls(unoptimized_scheme_eval):
    """Return a properly tail recursive version of an eval function."""
    def optimized_eval(expr, env, tail=False):
        """Evaluate Scheme expression EXPR in Frame ENV. If TAIL,
        return an Unevaluated containing an expression for further evaluation.
        """
        if tail and not scheme_symbolp(expr) and not self_evaluating(expr):
            return Unevaluated(expr, env)

        result = Unevaluated(expr, env)
        # BEGIN PROBLEM EC
        "*** YOUR CODE HERE ***"
        while isinstance(result, Unevaluated):
            result = unoptimized_scheme_eval(result.expr, result.env)
        return result

        # def trampoline(f, *args):   
        #     v = f(*args)   
        #     while callable(v):   
        #         v = v() 
        #     return v
        # # def fact_k_thunked(n, k):   
        # #     if n == 0:     
        # #         return k   
        # #     return lambda: fact_k_thunked(n - 1, n * k)
        # # trampoline(fact_k_thunked, 3, 1)

        # while isinstance(result, Unevaluated):
        #     # result = trampoline(unoptimized_scheme_eval, result.expr, result.env)
        #     result = unoptimized_scheme_eval(result.expr, result.env)
        # return result
        # def trampoline(f, *args):   
        #     v = f(*args)   
        #     while callable(v):   
        #         v = v() 
        #     return v 
        # # The function needs to be thunk-returning. 
        # def fact_k_thunked(n, k):   
        #     if n == 0:     
        #         return k   
        #     return lambda: fact_k_thunked(n - 1, n * k)
        # trampoline(fact_k_thunked, 3, 1)
        # END PROBLEM EC
    return optimized_eval


################################################################
# Uncomment the following line to apply tail call optimization #
################################################################
scheme_eval = optimize_tail_calls(scheme_eval)

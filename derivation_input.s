%----START HERE!
%----Derivation
cnf(t1,plain, q(b) | ~s(sK1),
    inference(start,[status(thm),path([0:0])],[c1]) ).

cnf(t2,plain, ~q(b) | ~p(c) | ~r,
    inference(extension,[status(thm),path([t1:1,0:0])],[c2]) ).

cnf(t3,plain, $false,
    inference(connection,[status(thm),path([t2:1,t1:1,0:0])],[t2:1,t1:1]) ).

cnf(t4,plain, p(c) | ~q(c),
    inference(extension,[status(thm),path([t2:2,t1:1,0:0])],[c3]) ).

cnf(t5,plain, $false,
    inference(connection,[status(thm),path([t4:1,t2:2,t1:1,0:0])],[t4:1,t2:2]) ).

cnf(t6,plain, q(c) | ~q(b),
    inference(extension,[status(thm),path([t2:2,t1:1,0:0])],[c5]) ).

cnf(t7,plain, $false,
    inference(connection,[status(thm),path([t6:1,t4:2,t2:2,t1:1,0:0])],[t6:1,t4:2]) ).

cnf(t8,plain, $false,
    inference(reduction,[status(thm),path([t6:2,t4:2,t2:2,t1:1,0:0])],[t6:2,t1:1]) ).

cnf(l1,plain, p(c),
    inference(lemma,[status(cth),path([t2:2,t1:1,0:0]),below(t1:1)],[t2:2]) ).

cnf(t9,plain, r | ~p(c),
    inference(extension,[status(thm),path([t2:3,t1:1,0:0])],[c6]) ).

cnf(t10,plain,              $false,
    inference(connection,[status(thm),path([t9:1,t2:3,t1:1,0:0])],[t9:1,t2:3]) ).

cnf(t11,plain,              $false,
    inference(lemma_extension,[status(thm),path([l1:1,t9:2,t2:3,t1:1,0:0])],[l1:1,t9:2]) ).

cnf(l2,plain, ~q(b),
    inference(lemma,[status(cth),path([t1:1,0:0]),below(0:0)],[t1:1]) ).

cnf(t12,plain,              s(sK1) | q(b) | ~p(c),
    inference(extension,[status(thm),path([t1:2,0:0])],[c7]) ).

cnf(t13,plain,              $false,
    inference(connection,[status(thm),path([t12:1,t1:2,0:0])],[t12:1,t1:2]) ).

cnf(t14,plain,              $false,
    inference(lemma_extension,[status(thm),path([l2:1,t12:2,t1:2,0:0])],[l2:1,t12:2]) ).

cnf(t15,plain,              p(c) | q(b),
    inference(extension,[status(thm),path([t12:3,t1:2,0:0])],[c4]) ).

cnf(t16,plain,              $false,
    inference(connection,[status(thm),path([t15:1,t12:3,t1:2,0:0])],[t15:1,t2:3]) ).

cnf(t17,plain,              $false,
    inference(lemma_extension,[status(thm),path([l2:1,t15:2,t12:3,t1:2,0:0])],[l2:1,t15:2]) ).
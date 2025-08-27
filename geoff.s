fof(a1,axiom,
    ~ ( ~ q(b)
      & ? [X] : s(X) ),
    file('PaperFOF.p',a1) ).

fof(a2,axiom,
    ( ( r
      & q(b) )
   => ! [X] : ~ p(X) ),
    file('PaperFOF.p',a2) ).

fof(a3,axiom,
    ( p(c)
    | ! [Y] :
        ( ~ q(c)
        & q(Y) ) ),
    file('PaperFOF.p',a3) ).

fof(a4,axiom,
    ( q(c)
    | ~ q(b) ),
    file('PaperFOF.p',a4) ).

fof(a5,axiom,
    ( ~ p(c)
    | r ),
    file('PaperFOF.p',a5) ).

fof(prove,conjecture,
    ! [X] :
      ( ~ s(X)
      & ~ q(b)
      & p(c) ),
    file('PaperFOF.p',prove) ).

fof(nc1,negated_conjecture,
    ~ ! [X] :
        ( ~ s(X)
        & ~ q(b)
        & p(c) ),
    inference(negate,[status(cth)],[prove]) ).

fof(nc2,negated_conjecture,
    ? [X] :
      ~ ( ~ s(X)
        & ~ q(b)
        & p(c) ),
    inference(negate,[status(thm)],[nc1]) ).

fof(nc3,negated_conjecture,
    ~ ( ~ s(sK1)
      & ~ q(b)
      & p(c) ),
    inference(skolemize,[status(esa),new_symbols(skolem,[sK1]),skolemized(X)],[nc2]) ).

cnf(c1,plain,
    ( q(b)
    | ~ s(X) ),
    inference(clausify,[status(thm)],[a1]) ).

cnf(c2,plain,
    ( ~ q(b)
    | ~ p(X)
    | ~ r ),
    inference(clausify,[status(thm)],[a2]) ).

cnf(c3,plain,
    ( p(c)
    | ~ q(c) ),
    inference(clausify,[status(thm)],[a3]) ).

cnf(c4,plain,
    ( p(c)
    | q(Y) ),
    inference(clausify,[status(thm)],[a3]) ).

cnf(c5,plain,
    ( q(c)
    | ~ q(b) ),
    inference(clausify,[status(thm)],[a4]) ).

cnf(c6,plain,
    ( r
    | ~ p(c) ),
    inference(clausify,[status(thm)],[a5]) ).

cnf(c7,negated_conjecture,
    ( s(sK1)
    | q(b)
    | ~ p(c) ),
    inference(clausify,[status(thm)],[nc3]) ).

%------------------------------------------------------------------------------
cnf(t1,plain,
    ( q(b)
    | ~ s(sK1) ),
    inference(start,[status(thm),parent(0:0)],[c1]) ).

cnf(t2,plain,
    ( ~ q(b)
    | ~ p(c)
    | ~ r ),
    inference(extension,[status(thm),parent(t1:1)],[c2]) ).

cnf(t3,plain,
    $false,
    inference(connection,[status(thm),parent(t2:1)],[t2:1,t1:1]) ).

cnf(t4,plain,
    ( p(c)
    | ~ q(c) ),
    inference(extension,[status(thm),parent(t2:2)],[c3]) ).

cnf(t5,plain,
    $false,
    inference(connection,[status(thm),parent(t4:1)],[t4:1,t2:2]) ).

cnf(t6,plain,
    ( q(c)
    | ~ q(b) ),
    inference(extension,[status(thm),parent(t4:2)],[c5]) ).

cnf(t7,plain,
    $false,
    inference(connection,[status(thm),parent(t6:1)],[t6:1,t4:2]) ).

cnf(t8,plain,
    $false,
    inference(reduction,[status(thm),parent(t6:2)],[t6:2,t1:1]) ).

cnf(l1,lemma,
    p(c),
    inference(lemma,[status(cth),parent(t2:2),below(t1:1)],[t2:2]) ).

cnf(t9,plain,
    ( r
    | ~ p(c) ),
    inference(extension,[status(thm),parent(t2:3)],[c6]) ).

cnf(t10,plain,
    $false,
    inference(connection,[status(thm),parent(t9:1)],[t9:1,t2:3]) ).

cnf(t11,plain,
    p(c),
    inference(lemma_extension,[status(thm),parent(t9:2)],[l1:1]) ).

cnf(t12,plain,
    $false,
    inference(connection,[status(thm),parent(t11:1)],[t9:2,t11:1]) ).

cnf(l2,lemma,
    ~ q(b),
    inference(lemma,[status(cth),parent(t1:1),below(0:0)],[t1:1]) ).

cnf(t13,plain,
    ( s(sK1)
    | q(b)
    | ~ p(c) ),
    inference(extension,[status(thm),parent(t1:2)],[c7]) ).

cnf(t14,plain,
    $false,
    inference(connection,[status(thm),parent(t13:1)],[t13:1,t1:2]) ).

cnf(t15,plain,
    ~ q(b),
    inference(lemma_extension,[status(thm),parent(t13:2)],[l2:1]) ).

cnf(t16,plain,
    $false,
    inference(connection,[status(thm),parent(t15:1)],[t15:1,t13:2]) ).

cnf(t17,plain,
    ( p(c)
    | q(b) ),
    inference(extension,[status(thm),parent(t13:3)],[c4]) ).

cnf(t18,plain,
    $false,
    inference(connection,[status(thm),parent(t17:1)],[t17:1,t13:3]) ).

cnf(t19,plain,
    ~ q(b),
    inference(lemma_extension,[status(thm),parent(t17:2)],[l2:1]) ).

cnf(t20,plain,
    $false,
    inference(connection,[status(thm),parent(t19:1)],[t19:1,t17:2]) ).
%------------------------------------------------------------------------------

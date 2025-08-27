fof(a1,axiom,~ ( ~ q(b)& ? [X] : s(X) ),file('PaperFOF.p',a1) ).
fof(a2,axiom,( ( r& q(b) )=> ! [X] : ~ p(X) ),file('PaperFOF.p',a2) ).
fof(a3,axiom,( p(c)| ! [Y] :( ~ q(c)& q(Y) ) ),file('PaperFOF.p',a3) ).
fof(a4,axiom,( q(c)| ~ q(b) ),file('PaperFOF.p',a4) ).
fof(a5,axiom,( ~ p(c)| r ),file('PaperFOF.p',a5) ).
fof(prove,conjecture,! [X] :( ~ s(X)& ~ q(b)& p(c) ),file('PaperFOF.p',prove) ).
fof(nc1,negated_conjecture,~ ! [X] :( ~ s(X)& ~ q(b)& p(c) ),inference(negate,[status(cth)],[prove]) ).
fof(nc2,negated_conjecture,? [X] :~ ( ~ s(X)& ~ q(b)& p(c) ),inference(negate,[status(thm)],[nc1]) ).
fof(nc3,negated_conjecture,~ ( ~ s(sK1)& ~ q(b)& p(c) ),inference(skolemize,[status(esa),new_symbols(skolem,[sK1]),skolemized(X)],[nc2]) ).
cnf(c1,plain,( q(b)| ~ s(X) ),inference(clausify,[status(thm)],[a1]) ).
cnf(c2,plain,( ~ q(b)| ~ p(X)| ~ r ),inference(clausify,[status(thm)],[a2]) ).
cnf(c3,plain,( p(c)| ~ q(c) ),inference(clausify,[status(thm)],[a3]) ).
cnf(c4,plain,( p(c)| q(Y) ),inference(clausify,[status(thm)],[a3]) ).
cnf(c5,plain,( q(c)| ~ q(b) ),inference(clausify,[status(thm)],[a4]) ).
cnf(c6,plain,( r| ~ p(c) ),inference(clausify,[status(thm)],[a5]) ).
cnf(c7,negated_conjecture,( s(sK1)| q(b)| ~ p(c) ),inference(clausify,[status(thm)],[nc3]) ).
%----Derivation
tcf('0:0',conjecture, 
    $true, 
    introduced(language,[level(0)],[]),
    [] ).

fof('t1:1',plain, 
    q(b),
    inference(start,[level(1),hoverParent("c1")],['0:0']), 
    [] ).
                    
fof('t1:2',plain, 
    ~s(sK1),
    inference(start,[level(1),hoverParent("c1")],['0:0']), 
    [] ).
                    
fof('t2:1',plain,
    ~q(b),
    inference(extension,[level(2),hoverParent("c2"),nextTo('t2:2')],['t1:1']), 
    [] ).
                    
fof('t2:2',plain,
    ~p(c),
    inference(extension,[level(2),hoverParent("c2"),nextTo('t2:3')],['t1:1']), 
    [] ).
                    
fof('t2:3',plain, 
    ~r,
    inference(extension,[level(2),hoverParent("c2")],['t1:1']), 
    [] ).
                    
tcf(t3,conjecture,
    $false,
    inference(connection,[level(3)],['t2:1']),
    [] ).
                
fof('t4:1',plain, 
    p(c),
    inference(extension,[level(3),hoverParent("c3")],['t2:2']), 
    [] ).
                    
fof('t4:2',plain, 
    ~q(c),
    inference(extension,[level(3),hoverParent("c3")],['t2:2']), 
    [] ).
                    
tcf(t5,conjecture,
    $false,
    inference(connection,[level(4)],['t4:1']),
    [] ).
                
fof('t6:1',plain, 
    q(c),
    inference(extension,[level(4),hoverParent("c5")],['t4:2']), 
    [] ).
                    
fof('t6:2',plain, 
    ~q(b),
    inference(extension,[level(4),hoverParent("c5")],['t4:2']), 
    [] ).
                    
tcf(t7,conjecture,
    $false,
    inference(connection,[level(5)],['t6:1']),
    [] ).
                
tcf(t8,conjecture, 
    $false, 
    inference(reduction,[level(5),hoverNode('t1:1')],['t6:2']), 
    [] ).
                
thf('l1:1',axiom, 
    p(c), 
    inference(lemma,[level(2),nextTo('t2:2')],['t2:2']), 
    [] ).
            
fof('t9:1',plain, 
    r,
    inference(extension,[level(3),hoverParent("c6")],['t2:3']), 
    [] ).
                    
fof('t9:2',plain, 
    ~p(c),
    inference(extension,[level(3),hoverParent("c6")],['t2:3']), 
    [] ).
                    
tcf(t10,conjecture,
    $false,
    inference(connection,[level(4)],['t9:1']),
    [] ).
                
fof('t11:1',plain,
    p(c),
    inference(lemma_extension,[level(4),hoverNode('l1:1')],['t9:2']), 
    [] ).
                
tcf(t12,conjecture,
    $false,
    inference(connection,[level(5)],['t11:1']),
    [] ).
                
thf('l2:1',axiom, 
    ~q(b), 
    inference(lemma,[level(1),nextTo('t1:1')],['t1:1']), 
    [] ).
            
fof('t13:1',plain,
    s(sK1),
    inference(extension,[level(2),hoverParent("c7"),nextTo('t13:2')],['t1:2']), 
    [] ).
                    
fof('t13:2',plain,
    q(b),
    inference(extension,[level(2),hoverParent("c7"),nextTo('t13:3')],['t1:2']), 
    [] ).
                    
fof('t13:3',plain, 
    ~p(c),
    inference(extension,[level(2),hoverParent("c7")],['t1:2']), 
    [] ).
                    
tcf(t14,conjecture,
    $false,
    inference(connection,[level(3)],['t13:1']),
    [] ).
                
fof('t15:1',plain,
    ~q(b),
    inference(lemma_extension,[level(3),hoverNode('l2:1')],['t13:2']), 
    [] ).
                
tcf(t16,conjecture,
    $false,
    inference(connection,[level(4)],['t15:1']),
    [] ).
                
fof('t17:1',plain, 
    p(c),
    inference(extension,[level(3),hoverParent("c4")],['t13:3']), 
    [] ).
                    
fof('t17:2',plain, 
    q(b),
    inference(extension,[level(3),hoverParent("c4")],['t13:3']), 
    [] ).
                    
tcf(t18,conjecture,
    $false,
    inference(connection,[level(4)],['t17:1']),
    [] ).
                
fof('t19:1',plain,
    ~q(b),
    inference(lemma_extension,[level(4),hoverNode('l2:1')],['t17:2']), 
    [] ).
                
tcf(t20,conjecture,
    $false,
    inference(connection,[level(5)],['t19:1']),
    [] ).
                
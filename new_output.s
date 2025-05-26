tcf('0:0',conjecture, 
    $true, 
    introduced(language,[level(0)],[]),
    [] ).

fof('t1:1',plain, 
    q(b),
    inference(start,[level(1)],['0:0']), 
    [] ).
                
fof('t1:2',plain, 
    ~s(sK1),
    inference(start,[level(1)],['0:0']), 
    [] ).
                
fof('t2:1',plain, 
    ~q(b),
    inference(extension,[level(2)],['t1:1']), 
    [] ).
                
fof('t2:2',plain, 
    ~p(c),
    inference(extension,[level(2)],['t1:1']), 
    [] ).
                
fof('t2:3',plain, 
    ~r,
    inference(extension,[level(2)],['t1:1']), 
    [] ).
                
tcf(t3,conjecture,
    $false,
    inference(connection,[level(3)],['t2:1']),
    [] ).
                
fof('t4:1',plain, 
    p(c),
    inference(extension,[level(3)],['t2:2']), 
    [] ).
                
fof('t4:2',plain, 
    ~q(c),
    inference(extension,[level(3)],['t2:2']), 
    [] ).
                
tcf(t5,conjecture,
    $false,
    inference(connection,[level(4)],['t4:1']),
    [] ).
                
fof('t6:1',plain, 
    q(c),
    inference(extension,[level(4)],['t4:2']), 
    [] ).
                
fof('t6:2',plain, 
    ~q(b),
    inference(extension,[level(4)],['t4:2']), 
    [] ).
                
tcf(t7,conjecture,
    $false,
    inference(connection,[level(5)],['t6:1']),
    [] ).
                
tcf(t8,conjecture, 
    $false, 
    inference(reduction,[level(5)],['t6:2']), 
    [] ).
                
thf('l1:1',axiom, 
    p(c), 
    inference(lemma,[level(2)],['t2:2'], nextTo('t2:2')), 
    [] ).
            
fof('t9:1',plain, 
    r,
    inference(extension,[level(3)],['t2:3']), 
    [] ).
                
fof('t9:2',plain, 
    ~p(c),
    inference(extension,[level(3)],['t2:3']), 
    [] ).
                
tcf(t10,conjecture,
    $false,
    inference(connection,[level(4)],['t9:1']),
    [] ).
                
fof('t11:1',plain,
    p(c),
    inference(lemma_extension,[level(4)],['t9:2']), 
    [] ).
                
tcf(t12,conjecture,
    $false,
    inference(connection,[level(5)],['t11:1']),
    [] ).
                
thf('l2:1',axiom, 
    ~q(b), 
    inference(lemma,[level(1)],['t1:1'], nextTo('t1:1')), 
    [] ).
            
fof('t13:1',plain, 
    s(sK1),
    inference(extension,[level(2)],['t1:2']), 
    [] ).
                
fof('t13:2',plain, 
    q(b),
    inference(extension,[level(2)],['t1:2']), 
    [] ).
                
fof('t13:3',plain, 
    ~p(c),
    inference(extension,[level(2)],['t1:2']), 
    [] ).
                
tcf(t14,conjecture,
    $false,
    inference(connection,[level(3)],['t13:1']),
    [] ).
                
fof('t15:1',plain,
    ~q(b),
    inference(lemma_extension,[level(3)],['t13:2']), 
    [] ).
                
tcf(t16,conjecture,
    $false,
    inference(connection,[level(4)],['t15:1']),
    [] ).
                
fof('t17:1',plain, 
    p(c),
    inference(extension,[level(3)],['t13:3']), 
    [] ).
                
fof('t17:2',plain, 
    q(b),
    inference(extension,[level(3)],['t13:3']), 
    [] ).
                
tcf(t18,conjecture,
    $false,
    inference(connection,[level(4)],['t17:1']),
    [] ).
                
fof('t19:1',plain,
    ~q(b),
    inference(lemma_extension,[level(4)],['t17:2']), 
    [] ).
                
tcf(t20,conjecture,
    $false,
    inference(lemma_extension,[level(5)],['t19:1']),
    [] ).
                
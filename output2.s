cnf(from_mars_or_venus,axiom,( from_mars(X)| from_venus(X) ),file('PUZ001-0.ax',from_mars_or_venus) ).
cnf(not_from_mars_and_venus,axiom,( ~ from_mars(X)| ~ from_venus(X) ),file('PUZ001-0.ax',not_from_mars_and_venus) ).
cnf(male_or_female,axiom,( male(X)| female(X) ),file('PUZ001-0.ax',male_or_female) ).
cnf(people_say_their_statements,axiom,( ~ says(X,Y)| Y = statement_by(X) ),file('PUZ001-0.ax',people_say_their_statements) ).
cnf(venusian_female_are_truthtellers,axiom,( ~ from_venus(X)| ~ female(X)| truthteller(X) ),file('PUZ001-0.ax',venusian_female_are_truthtellers) ).
cnf(marsian_females_are_liars,axiom,( ~ from_mars(X)| ~ female(X)| liar(X) ),file('PUZ001-0.ax',marsian_females_are_liars) ).
cnf(truthtellers_make_true_statements,axiom,( ~ truthteller(X)| ~ says(X,Y)| a_truth(Y) ),file('PUZ001-0.ax',truthtellers_make_true_statements) ).
cnf(liars_make_false_statements,axiom,( ~ liar(X)| ~ says(X,Y)| ~ a_truth(Y) ),file('PUZ001-0.ax',liars_make_false_statements) ).
cnf(a_says_hes_from_mars,hypothesis,says(a,a_from_mars),file('PUZ007-1.p',a_says_hes_from_mars) ).
cnf(b_says_a_lies,hypothesis,says(b,a_has_lied),file('PUZ007-1.p',b_says_a_lies) ).
cnf(a_from_mars1,hypothesis,( ~ from_mars(a)| a_truth(a_from_mars) ),file('PUZ007-1.p',a_from_mars1) ).
cnf(a_from_mars2,hypothesis,( from_mars(a)| ~ a_truth(a_from_mars) ),file('PUZ007-1.p',a_from_mars2) ).
cnf(a_from_mars3,hypothesis,( ~ a_truth(a_from_mars)| ~ a_truth(statement_by(b)) ),file('PUZ007-1.p',a_from_mars3) ).
cnf(truth_of_bs_statement,hypothesis,( a_truth(a_from_mars)| a_truth(statement_by(b)) ),file('PUZ007-1.p',truth_of_bs_statement) ).
cnf(different_sex2,hypothesis,( ~ male(a)| female(b) ),file('PUZ007-1.p',different_sex2) ).
cnf(one_from_mars,negated_conjecture,( from_mars(b)| from_mars(a) ),file('PUZ007-1.p',one_from_mars) ).
cnf(one_from_venus,negated_conjecture,( from_venus(a)| from_venus(b) ),file('PUZ007-1.p',one_from_venus) ).
cnf(equality_1,axiom,Eq_x_0 = Eq_x_0,theory(equality,[reflexivity]) ).
cnf(equality_2,axiom,( Eq_x_0 != Eq_x_1| Eq_x_1 = Eq_x_0 ),theory(equality,[symmetry]) ).
cnf(equality_11,axiom,( Eq_x_0 != Eq_y_0| Eq_x_1 != Eq_y_1| ~ says(Eq_x_0,Eq_x_1)| says(Eq_y_0,Eq_y_1) ),theory(equality,[substitution-predicates]) ).
%----Derivation
tcf('0:0',conjecture, 
    $true, 
    introduced(language,[level(0)],[]),
    [] ).

fof('t1:1',plain, 
    ~from_mars(a),
    inference(start,[level(1),hoverParent("not_from_mars_and_venus")],['0:0']), 
    [] ).
                    
fof('t1:2',plain, 
    ~from_venus(a),
    inference(start,[level(1),hoverParent("not_from_mars_and_venus")],['0:0']), 
    [] ).
                    
fof('t2:1',plain,
    from_mars(a),
    inference(extension,[level(2),hoverParent("one_from_mars"),nextTo('t2:2')],['t1:1']), 
    [] ).
                    
fof('t2:2',plain, 
    from_mars(b),
    inference(extension,[level(2),hoverParent("one_from_mars")],['t1:1']), 
    [] ).
                    
fof('t3:1',plain, 
    $false,
    inference(connection,[level(3)],['t2:1']), 
    [] ).
                    
fof('t4:1',plain, 
    ~from_mars(b),
    inference(extension,[level(3),hoverParent("marsian_females_are_liars")],['t2:2']), 
    [] ).
                    
fof('t4:2',plain, 
    liar(b),
    inference(extension,[level(3),hoverParent("marsian_females_are_liars")],['t2:2']), 
    [] ).
                    
fof('t4:3',plain, 
    ~female(b),
    inference(extension,[level(3),hoverParent("marsian_females_are_liars")],['t2:2']), 
    [] ).
                    
fof('t5:1',plain, 
    $false,
    inference(connection,[level(4)],['t4:1']), 
    [] ).
                    
fof('t6:1',plain, 
    ~liar(b),
    inference(extension,[level(4),hoverParent("liars_make_false_statements")],['t4:2']), 
    [] ).
                    
fof('t6:2',plain, 
    ~a_truth(statement_by(b)),
    inference(extension,[level(4),hoverParent("liars_make_false_statements")],['t4:2']), 
    [] ).
                    
fof('t6:3',plain, 
    ~says(b,statement_by(b)),
    inference(extension,[level(4),hoverParent("liars_make_false_statements")],['t4:2']), 
    [] ).
                    
fof('t7:1',plain, 
    $false,
    inference(connection,[level(5)],['t6:1']), 
    [] ).
                    
fof('t8:1',plain, 
    a_truth(statement_by(b)),
    inference(extension,[level(5),hoverParent("truth_of_bs_statement")],['t6:2']), 
    [] ).
                    
fof('t8:2',plain, 
    a_truth(a_from_mars),
    inference(extension,[level(5),hoverParent("truth_of_bs_statement")],['t6:2']), 
    [] ).
                    
fof('t9:1',plain, 
    $false,
    inference(connection,[level(6)],['t8:1']), 
    [] ).
                    
fof('t10:1',plain, 
    ~a_truth(a_from_mars),
    inference(extension,[level(6),hoverParent("a_from_mars2")],['t8:2']), 
    [] ).
                    
fof('t10:2',plain, 
    from_mars(a),
    inference(extension,[level(6),hoverParent("a_from_mars2")],['t8:2']), 
    [] ).
                    
fof('t11:1',plain, 
    $false,
    inference(connection,[level(7)],['t10:1']), 
    [] ).
                    
fof('t12:1',plain, 
    $false,
    inference(reduction,[level(7)],['t10:2']), 
    [] ).
                    
fof('t13:1',plain, 
    says(b,statement_by(b)),
    inference(extension,[level(5),hoverParent("equality_11")],['t6:3']), 
    [] ).
                    
fof('t13:2',plain, 
    b!=b,
    inference(extension,[level(5),hoverParent("equality_11")],['t6:3']), 
    [] ).
                    
fof('t13:3',plain, 
    ~says(b,a_has_lied),
    inference(extension,[level(5),hoverParent("equality_11")],['t6:3']), 
    [] ).
                    
fof('t13:4',plain, 
    a_has_lied!=statement_by(b),
    inference(extension,[level(5),hoverParent("equality_11")],['t6:3']), 
    [] ).
                    
fof('t14:1',plain, 
    $false,
    inference(connection,[level(6)],['t13:1']), 
    [] ).
                    
fof('t15:1',plain, 
    b=b,
    inference(extension,[level(6),hoverParent("equality_2")],['t13:2']), 
    [] ).
                    
fof('t15:2',plain, 
    b!=b,
    inference(extension,[level(6),hoverParent("equality_2")],['t13:2']), 
    [] ).
                    
fof('t16:1',plain, 
    $false,
    inference(connection,[level(7)],['t15:1']), 
    [] ).
                    
fof('t17:1',plain, 
    b=b,
    inference(extension,[level(7),hoverParent("equality_1")],['t15:2']), 
    [] ).
                    
fof('t18:1',plain, 
    $false,
    inference(connection,[level(8)],['t17:1']), 
    [] ).
                    
fof('t19:1',plain, 
    says(b,a_has_lied),
    inference(extension,[level(6),hoverParent("b_says_a_lies")],['t13:3']), 
    [] ).
                    
fof('t20:1',plain, 
    $false,
    inference(connection,[level(7)],['t19:1']), 
    [] ).
                    
thf('l10:1',axiom, 
    says(b,a_has_lied), 
    inference(lemma,[level(4),nextTo('t13:3'),below(t6:3)],['t13:3']), 
    [] ).
            
fof('t21:1',plain, 
    a_has_lied=statement_by(b),
    inference(extension,[level(6),hoverParent("people_say_their_statements")],['t13:4']), 
    [] ).
                    
fof('t21:2',plain, 
    ~says(b,a_has_lied),
    inference(extension,[level(6),hoverParent("people_say_their_statements")],['t13:4']), 
    [] ).
                    
fof('t22:1',plain, 
    $false,
    inference(connection,[level(7)],['t21:1']), 
    [] ).
                    
fof('t23:1',plain,
    says(b,a_has_lied),
    inference(lemma_extension,[level(7),hoverNode('l10:1')],['t21:2']), 
    [] ).
                
fof('t24:1',plain, 
    $false,
    inference(connection,[level(8)],['t23:1']), 
    [] ).
                    
fof('t25:1',plain, 
    female(b),
    inference(extension,[level(4),hoverParent("different_sex2")],['t4:3']), 
    [] ).
                    
fof('t25:2',plain, 
    ~male(a),
    inference(extension,[level(4),hoverParent("different_sex2")],['t4:3']), 
    [] ).
                    
fof('t26:1',plain, 
    $false,
    inference(connection,[level(5)],['t25:1']), 
    [] ).
                    
fof('t27:1',plain, 
    male(a),
    inference(extension,[level(5),hoverParent("male_or_female")],['t25:2']), 
    [] ).
                    
fof('t27:2',plain, 
    female(a),
    inference(extension,[level(5),hoverParent("male_or_female")],['t25:2']), 
    [] ).
                    
fof('t28:1',plain, 
    $false,
    inference(connection,[level(6)],['t27:1']), 
    [] ).
                    
fof('t29:1',plain, 
    ~female(a),
    inference(extension,[level(6),hoverParent("venusian_female_are_truthtellers")],['t27:2']), 
    [] ).
                    
fof('t29:2',plain, 
    ~from_venus(a),
    inference(extension,[level(6),hoverParent("venusian_female_are_truthtellers")],['t27:2']), 
    [] ).
                    
fof('t29:3',plain, 
    truthteller(a),
    inference(extension,[level(6),hoverParent("venusian_female_are_truthtellers")],['t27:2']), 
    [] ).
                    
fof('t30:1',plain, 
    $false,
    inference(connection,[level(7)],['t29:1']), 
    [] ).
                    
fof('t31:1',plain, 
    from_venus(a),
    inference(extension,[level(7),hoverParent("from_mars_or_venus")],['t29:2']), 
    [] ).
                    
fof('t31:2',plain, 
    from_mars(a),
    inference(extension,[level(7),hoverParent("from_mars_or_venus")],['t29:2']), 
    [] ).
                    
fof('t32:1',plain, 
    $false,
    inference(connection,[level(8)],['t31:1']), 
    [] ).
                    
fof('t33:1',plain, 
    $false,
    inference(reduction,[level(8)],['t31:2']), 
    [] ).
                    
fof('t34:1',plain, 
    ~truthteller(a),
    inference(extension,[level(7),hoverParent("truthtellers_make_true_statements")],['t29:3']), 
    [] ).
                    
fof('t34:2',plain, 
    a_truth(a_from_mars),
    inference(extension,[level(7),hoverParent("truthtellers_make_true_statements")],['t29:3']), 
    [] ).
                    
fof('t34:3',plain, 
    ~says(a,a_from_mars),
    inference(extension,[level(7),hoverParent("truthtellers_make_true_statements")],['t29:3']), 
    [] ).
                    
fof('t35:1',plain, 
    $false,
    inference(connection,[level(8)],['t34:1']), 
    [] ).
                    
fof('t36:1',plain, 
    ~a_truth(a_from_mars),
    inference(extension,[level(8),hoverParent("a_from_mars2")],['t34:2']), 
    [] ).
                    
fof('t36:2',plain, 
    from_mars(a),
    inference(extension,[level(8),hoverParent("a_from_mars2")],['t34:2']), 
    [] ).
                    
fof('t37:1',plain, 
    $false,
    inference(connection,[level(9)],['t36:1']), 
    [] ).
                    
fof('t38:1',plain, 
    $false,
    inference(reduction,[level(9)],['t36:2']), 
    [] ).
                    
fof('t39:1',plain, 
    says(a,a_from_mars),
    inference(extension,[level(8),hoverParent("a_says_hes_from_mars")],['t34:3']), 
    [] ).
                    
fof('t40:1',plain, 
    $false,
    inference(connection,[level(9)],['t39:1']), 
    [] ).
                    
thf('l1:1',axiom, 
    from_mars(a), 
    inference(lemma,[level(0),nextTo('t1:1'),below(0:0)],['t1:1']), 
    [] ).
            
fof('t41:1',plain,
    from_venus(a),
    inference(extension,[level(2),hoverParent("one_from_venus"),nextTo('t41:2')],['t1:2']), 
    [] ).
                    
fof('t41:2',plain, 
    from_venus(b),
    inference(extension,[level(2),hoverParent("one_from_venus")],['t1:2']), 
    [] ).
                    
fof('t42:1',plain, 
    $false,
    inference(connection,[level(3)],['t41:1']), 
    [] ).
                    
fof('t43:1',plain, 
    ~from_venus(b),
    inference(extension,[level(3),hoverParent("venusian_female_are_truthtellers")],['t41:2']), 
    [] ).
                    
fof('t43:2',plain, 
    truthteller(b),
    inference(extension,[level(3),hoverParent("venusian_female_are_truthtellers")],['t41:2']), 
    [] ).
                    
fof('t43:3',plain, 
    ~female(b),
    inference(extension,[level(3),hoverParent("venusian_female_are_truthtellers")],['t41:2']), 
    [] ).
                    
fof('t44:1',plain, 
    $false,
    inference(connection,[level(4)],['t43:1']), 
    [] ).
                    
fof('t45:1',plain, 
    ~truthteller(b),
    inference(extension,[level(4),hoverParent("truthtellers_make_true_statements")],['t43:2']), 
    [] ).
                    
fof('t45:2',plain, 
    a_truth(statement_by(b)),
    inference(extension,[level(4),hoverParent("truthtellers_make_true_statements")],['t43:2']), 
    [] ).
                    
fof('t45:3',plain, 
    ~says(b,statement_by(b)),
    inference(extension,[level(4),hoverParent("truthtellers_make_true_statements")],['t43:2']), 
    [] ).
                    
fof('t46:1',plain, 
    $false,
    inference(connection,[level(5)],['t45:1']), 
    [] ).
                    
fof('t47:1',plain, 
    ~a_truth(statement_by(b)),
    inference(extension,[level(5),hoverParent("a_from_mars3")],['t45:2']), 
    [] ).
                    
fof('t47:2',plain, 
    ~a_truth(a_from_mars),
    inference(extension,[level(5),hoverParent("a_from_mars3")],['t45:2']), 
    [] ).
                    
fof('t48:1',plain, 
    $false,
    inference(connection,[level(6)],['t47:1']), 
    [] ).
                    
fof('t49:1',plain, 
    a_truth(a_from_mars),
    inference(extension,[level(6),hoverParent("a_from_mars1")],['t47:2']), 
    [] ).
                    
fof('t49:2',plain, 
    ~from_mars(a),
    inference(extension,[level(6),hoverParent("a_from_mars1")],['t47:2']), 
    [] ).
                    
fof('t50:1',plain, 
    $false,
    inference(connection,[level(7)],['t49:1']), 
    [] ).
                    
fof('t51:1',plain,
    from_mars(a),
    inference(lemma_extension,[level(7),hoverNode('l1:1')],['t49:2']), 
    [] ).
                
fof('t52:1',plain, 
    $false,
    inference(connection,[level(8)],['t51:1']), 
    [] ).
                    
fof('t53:1',plain, 
    says(b,statement_by(b)),
    inference(extension,[level(5),hoverParent("equality_11")],['t45:3']), 
    [] ).
                    
fof('t53:2',plain, 
    b!=b,
    inference(extension,[level(5),hoverParent("equality_11")],['t45:3']), 
    [] ).
                    
fof('t53:3',plain, 
    ~says(b,a_has_lied),
    inference(extension,[level(5),hoverParent("equality_11")],['t45:3']), 
    [] ).
                    
fof('t53:4',plain, 
    a_has_lied!=statement_by(b),
    inference(extension,[level(5),hoverParent("equality_11")],['t45:3']), 
    [] ).
                    
fof('t54:1',plain, 
    $false,
    inference(connection,[level(6)],['t53:1']), 
    [] ).
                    
fof('t55:1',plain, 
    b=b,
    inference(extension,[level(6),hoverParent("equality_2")],['t53:2']), 
    [] ).
                    
fof('t55:2',plain, 
    b!=b,
    inference(extension,[level(6),hoverParent("equality_2")],['t53:2']), 
    [] ).
                    
fof('t56:1',plain, 
    $false,
    inference(connection,[level(7)],['t55:1']), 
    [] ).
                    
fof('t57:1',plain, 
    b=b,
    inference(extension,[level(7),hoverParent("equality_1")],['t55:2']), 
    [] ).
                    
fof('t58:1',plain, 
    $false,
    inference(connection,[level(8)],['t57:1']), 
    [] ).
                    
fof('t59:1',plain, 
    says(b,a_has_lied),
    inference(extension,[level(6),hoverParent("b_says_a_lies")],['t53:3']), 
    [] ).
                    
fof('t60:1',plain, 
    $false,
    inference(connection,[level(7)],['t59:1']), 
    [] ).
                    
thf('l29:1',axiom, 
    says(b,a_has_lied), 
    inference(lemma,[level(4),nextTo('t53:3'),below(t45:3)],['t53:3']), 
    [] ).
            
fof('t61:1',plain, 
    a_has_lied=statement_by(b),
    inference(extension,[level(6),hoverParent("people_say_their_statements")],['t53:4']), 
    [] ).
                    
fof('t61:2',plain, 
    ~says(b,a_has_lied),
    inference(extension,[level(6),hoverParent("people_say_their_statements")],['t53:4']), 
    [] ).
                    
fof('t62:1',plain, 
    $false,
    inference(connection,[level(7)],['t61:1']), 
    [] ).
                    
fof('t63:1',plain,
    says(b,a_has_lied),
    inference(lemma_extension,[level(7),hoverNode('l29:1')],['t61:2']), 
    [] ).
                
fof('t64:1',plain, 
    $false,
    inference(connection,[level(8)],['t63:1']), 
    [] ).
                    
fof('t65:1',plain, 
    female(b),
    inference(extension,[level(4),hoverParent("different_sex2")],['t43:3']), 
    [] ).
                    
fof('t65:2',plain, 
    ~male(a),
    inference(extension,[level(4),hoverParent("different_sex2")],['t43:3']), 
    [] ).
                    
fof('t66:1',plain, 
    $false,
    inference(connection,[level(5)],['t65:1']), 
    [] ).
                    
fof('t67:1',plain, 
    male(a),
    inference(extension,[level(5),hoverParent("male_or_female")],['t65:2']), 
    [] ).
                    
fof('t67:2',plain, 
    female(a),
    inference(extension,[level(5),hoverParent("male_or_female")],['t65:2']), 
    [] ).
                    
fof('t68:1',plain, 
    $false,
    inference(connection,[level(6)],['t67:1']), 
    [] ).
                    
fof('t69:1',plain, 
    ~female(a),
    inference(extension,[level(6),hoverParent("marsian_females_are_liars")],['t67:2']), 
    [] ).
                    
fof('t69:2',plain, 
    ~from_mars(a),
    inference(extension,[level(6),hoverParent("marsian_females_are_liars")],['t67:2']), 
    [] ).
                    
fof('t69:3',plain, 
    liar(a),
    inference(extension,[level(6),hoverParent("marsian_females_are_liars")],['t67:2']), 
    [] ).
                    
fof('t70:1',plain, 
    $false,
    inference(connection,[level(7)],['t69:1']), 
    [] ).
                    
fof('t71:1',plain,
    from_mars(a),
    inference(lemma_extension,[level(7),hoverNode('l1:1')],['t69:2']), 
    [] ).
                
fof('t72:1',plain, 
    $false,
    inference(connection,[level(8)],['t71:1']), 
    [] ).
                    
fof('t73:1',plain, 
    ~liar(a),
    inference(extension,[level(7),hoverParent("liars_make_false_statements")],['t69:3']), 
    [] ).
                    
fof('t73:2',plain, 
    ~a_truth(a_from_mars),
    inference(extension,[level(7),hoverParent("liars_make_false_statements")],['t69:3']), 
    [] ).
                    
fof('t73:3',plain, 
    ~says(a,a_from_mars),
    inference(extension,[level(7),hoverParent("liars_make_false_statements")],['t69:3']), 
    [] ).
                    
fof('t74:1',plain, 
    $false,
    inference(connection,[level(8)],['t73:1']), 
    [] ).
                    
fof('t75:1',plain, 
    a_truth(a_from_mars),
    inference(extension,[level(8),hoverParent("a_from_mars1")],['t73:2']), 
    [] ).
                    
fof('t75:2',plain, 
    ~from_mars(a),
    inference(extension,[level(8),hoverParent("a_from_mars1")],['t73:2']), 
    [] ).
                    
fof('t76:1',plain, 
    $false,
    inference(connection,[level(9)],['t75:1']), 
    [] ).
                    
fof('t77:1',plain,
    from_mars(a),
    inference(lemma_extension,[level(9),hoverNode('l1:1')],['t75:2']), 
    [] ).
                
fof('t78:1',plain, 
    $false,
    inference(connection,[level(10)],['t77:1']), 
    [] ).
                    
fof('t79:1',plain, 
    says(a,a_from_mars),
    inference(extension,[level(8),hoverParent("a_says_hes_from_mars")],['t73:3']), 
    [] ).
                    
fof('t80:1',plain, 
    $false,
    inference(connection,[level(9)],['t79:1']), 
    [] ).
                    
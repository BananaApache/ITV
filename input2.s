% Checking upload ... % Checker ran ... % No errors ...
% START OF SYSTEM OUTPUT
% Checking upload ... % Checker ran ... % No errors ...
% START OF SYSTEM OUTPUT
cnf(from_mars_or_venus,axiom,
    ( from_mars(X)
    | from_venus(X) ),
    file('PUZ001-0.ax',from_mars_or_venus) ).

cnf(not_from_mars_and_venus,axiom,
    ( ~ from_mars(X)
    | ~ from_venus(X) ),
    file('PUZ001-0.ax',not_from_mars_and_venus) ).

cnf(male_or_female,axiom,
    ( male(X)
    | female(X) ),
    file('PUZ001-0.ax',male_or_female) ).

cnf(people_say_their_statements,axiom,
    ( ~ says(X,Y)
    | Y = statement_by(X) ),
    file('PUZ001-0.ax',people_say_their_statements) ).

cnf(venusian_female_are_truthtellers,axiom,
    ( ~ from_venus(X)
    | ~ female(X)
    | truthteller(X) ),
    file('PUZ001-0.ax',venusian_female_are_truthtellers) ).

cnf(marsian_females_are_liars,axiom,
    ( ~ from_mars(X)
    | ~ female(X)
    | liar(X) ),
    file('PUZ001-0.ax',marsian_females_are_liars) ).

cnf(truthtellers_make_true_statements,axiom,
    ( ~ truthteller(X)
    | ~ says(X,Y)
    | a_truth(Y) ),
    file('PUZ001-0.ax',truthtellers_make_true_statements) ).

cnf(liars_make_false_statements,axiom,
    ( ~ liar(X)
    | ~ says(X,Y)
    | ~ a_truth(Y) ),
    file('PUZ001-0.ax',liars_make_false_statements) ).

cnf(a_says_hes_from_mars,hypothesis,
    says(a,a_from_mars),
    file('PUZ007-1.p',a_says_hes_from_mars) ).

cnf(b_says_a_lies,hypothesis,
    says(b,a_has_lied),
    file('PUZ007-1.p',b_says_a_lies) ).

cnf(a_from_mars1,hypothesis,
    ( ~ from_mars(a)
    | a_truth(a_from_mars) ),
    file('PUZ007-1.p',a_from_mars1) ).

cnf(a_from_mars2,hypothesis,
    ( from_mars(a)
    | ~ a_truth(a_from_mars) ),
    file('PUZ007-1.p',a_from_mars2) ).

cnf(a_from_mars3,hypothesis,
    ( ~ a_truth(a_from_mars)
    | ~ a_truth(statement_by(b)) ),
    file('PUZ007-1.p',a_from_mars3) ).

cnf(truth_of_bs_statement,hypothesis,
    ( a_truth(a_from_mars)
    | a_truth(statement_by(b)) ),
    file('PUZ007-1.p',truth_of_bs_statement) ).

cnf(different_sex2,hypothesis,
    ( ~ male(a)
    | female(b) ),
    file('PUZ007-1.p',different_sex2) ).

cnf(one_from_mars,negated_conjecture,
    ( from_mars(b)
    | from_mars(a) ),
    file('PUZ007-1.p',one_from_mars) ).

cnf(one_from_venus,negated_conjecture,
    ( from_venus(a)
    | from_venus(b) ),
    file('PUZ007-1.p',one_from_venus) ).

cnf(equality_1,axiom,
    Eq_x_0 = Eq_x_0,
    theory(equality,[reflexivity]) ).

cnf(equality_2,axiom,
    ( Eq_x_0 != Eq_x_1
    | Eq_x_1 = Eq_x_0 ),
    theory(equality,[symmetry]) ).

cnf(equality_11,axiom,
    ( Eq_x_0 != Eq_y_0
    | Eq_x_1 != Eq_y_1
    | ~ says(Eq_x_0,Eq_x_1)
    | says(Eq_y_0,Eq_y_1) ),
    theory(equality,[substitution-predicates]) ).

cnf(t1,plain,
    ( ~ from_mars(a)
    | ~ from_venus(a) ),
    inference(start,[status(thm),parent(0:0)],[not_from_mars_and_venus]) ).

cnf(t2,plain,
    ( from_mars(a)
    | from_mars(b) ),
    inference(extension,[status(thm),parent(t1:1)],[one_from_mars]) ).

cnf(t3,plain,
    $false,
    inference(connection,[status(thm),parent(t2:1)],[t2:1,t1:1]) ).

cnf(t4,plain,
    ( ~ from_mars(b)
    | liar(b)
    | ~ female(b) ),
    inference(extension,[status(thm),parent(t2:2)],[marsian_females_are_liars]) ).

cnf(t5,plain,
    $false,
    inference(connection,[status(thm),parent(t4:1)],[t4:1,t2:2]) ).

cnf(t6,plain,
    ( ~ liar(b)
    | ~ a_truth(statement_by(b))
    | ~ says(b,statement_by(b)) ),
    inference(extension,[status(thm),parent(t4:2)],[liars_make_false_statements]) ).

cnf(t7,plain,
    $false,
    inference(connection,[status(thm),parent(t6:1)],[t6:1,t4:2]) ).

cnf(t8,plain,
    ( a_truth(statement_by(b))
    | a_truth(a_from_mars) ),
    inference(extension,[status(thm),parent(t6:2)],[truth_of_bs_statement]) ).

cnf(t9,plain,
    $false,
    inference(connection,[status(thm),parent(t8:1)],[t8:1,t6:2]) ).

cnf(t10,plain,
    ( ~ a_truth(a_from_mars)
    | from_mars(a) ),
    inference(extension,[status(thm),parent(t8:2)],[a_from_mars2]) ).

cnf(t11,plain,
    $false,
    inference(connection,[status(thm),parent(t10:1)],[t10:1,t8:2]) ).

cnf(t12,plain,
    $false,
    inference(reduction,[status(thm),parent(t10:2)],[t10:2,t1:1]) ).

cnf(t13,plain,
    ( says(b,statement_by(b))
    | b != b
    | ~ says(b,a_has_lied)
    | a_has_lied != statement_by(b) ),
    inference(extension,[status(thm),parent(t6:3)],[equality_11]) ).

cnf(t14,plain,
    $false,
    inference(connection,[status(thm),parent(t13:1)],[t13:1,t6:3]) ).

cnf(t15,plain,
    ( b = b
    | b != b ),
    inference(extension,[status(thm),parent(t13:2)],[equality_2]) ).

cnf(t16,plain,
    $false,
    inference(connection,[status(thm),parent(t15:1)],[t15:1,t13:2]) ).

cnf(t17,plain,
    b = b,
    inference(extension,[status(thm),parent(t15:2)],[equality_1]) ).

cnf(t18,plain,
    $false,
    inference(connection,[status(thm),parent(t17:1)],[t17:1,t15:2]) ).

cnf(t19,plain,
    says(b,a_has_lied),
    inference(extension,[status(thm),parent(t13:3)],[b_says_a_lies]) ).

cnf(t20,plain,
    $false,
    inference(connection,[status(thm),parent(t19:1)],[t19:1,t13:3]) ).

cnf(l10,lemma,
    says(b,a_has_lied),
    inference(lemma,[status(cth),parent(t13:3),below(t6:3)],[t13:3]) ).

cnf(t21,plain,
    ( a_has_lied = statement_by(b)
    | ~ says(b,a_has_lied) ),
    inference(extension,[status(thm),parent(t13:4)],[people_say_their_statements]) ).

cnf(t22,plain,
    $false,
    inference(connection,[status(thm),parent(t21:1)],[t21:1,t13:4]) ).

cnf(t23,plain,
    says(b,a_has_lied),
    inference(lemma_extension,[status(thm),parent(t21:2)],[l10:1]) ).

cnf(t24,plain,
    $false,
    inference(connection,[status(thm),parent(t23:1)],[t23:1,t21:2]) ).

cnf(t25,plain,
    ( female(b)
    | ~ male(a) ),
    inference(extension,[status(thm),parent(t4:3)],[different_sex2]) ).

cnf(t26,plain,
    $false,
    inference(connection,[status(thm),parent(t25:1)],[t25:1,t4:3]) ).

cnf(t27,plain,
    ( male(a)
    | female(a) ),
    inference(extension,[status(thm),parent(t25:2)],[male_or_female]) ).

cnf(t28,plain,
    $false,
    inference(connection,[status(thm),parent(t27:1)],[t27:1,t25:2]) ).

cnf(t29,plain,
    ( ~ female(a)
    | ~ from_venus(a)
    | truthteller(a) ),
    inference(extension,[status(thm),parent(t27:2)],[venusian_female_are_truthtellers]) ).

cnf(t30,plain,
    $false,
    inference(connection,[status(thm),parent(t29:1)],[t29:1,t27:2]) ).

cnf(t31,plain,
    ( from_venus(a)
    | from_mars(a) ),
    inference(extension,[status(thm),parent(t29:2)],[from_mars_or_venus]) ).

cnf(t32,plain,
    $false,
    inference(connection,[status(thm),parent(t31:1)],[t31:1,t29:2]) ).

cnf(t33,plain,
    $false,
    inference(reduction,[status(thm),parent(t31:2)],[t31:2,t1:1]) ).

cnf(t34,plain,
    ( ~ truthteller(a)
    | a_truth(a_from_mars)
    | ~ says(a,a_from_mars) ),
    inference(extension,[status(thm),parent(t29:3)],[truthtellers_make_true_statements]) ).

cnf(t35,plain,
    $false,
    inference(connection,[status(thm),parent(t34:1)],[t34:1,t29:3]) ).

cnf(t36,plain,
    ( ~ a_truth(a_from_mars)
    | from_mars(a) ),
    inference(extension,[status(thm),parent(t34:2)],[a_from_mars2]) ).

cnf(t37,plain,
    $false,
    inference(connection,[status(thm),parent(t36:1)],[t36:1,t34:2]) ).

cnf(t38,plain,
    $false,
    inference(reduction,[status(thm),parent(t36:2)],[t36:2,t1:1]) ).

cnf(t39,plain,
    says(a,a_from_mars),
    inference(extension,[status(thm),parent(t34:3)],[a_says_hes_from_mars]) ).

cnf(t40,plain,
    $false,
    inference(connection,[status(thm),parent(t39:1)],[t39:1,t34:3]) ).

cnf(l1,lemma,
    from_mars(a),
    inference(lemma,[status(cth),parent(t1:1),below(0:0)],[t1:1]) ).

cnf(t41,plain,
    ( from_venus(a)
    | from_venus(b) ),
    inference(extension,[status(thm),parent(t1:2)],[one_from_venus]) ).

cnf(t42,plain,
    $false,
    inference(connection,[status(thm),parent(t41:1)],[t41:1,t1:2]) ).

cnf(t43,plain,
    ( ~ from_venus(b)
    | truthteller(b)
    | ~ female(b) ),
    inference(extension,[status(thm),parent(t41:2)],[venusian_female_are_truthtellers]) ).

cnf(t44,plain,
    $false,
    inference(connection,[status(thm),parent(t43:1)],[t43:1,t41:2]) ).

cnf(t45,plain,
    ( ~ truthteller(b)
    | a_truth(statement_by(b))
    | ~ says(b,statement_by(b)) ),
    inference(extension,[status(thm),parent(t43:2)],[truthtellers_make_true_statements]) ).

cnf(t46,plain,
    $false,
    inference(connection,[status(thm),parent(t45:1)],[t45:1,t43:2]) ).

cnf(t47,plain,
    ( ~ a_truth(statement_by(b))
    | ~ a_truth(a_from_mars) ),
    inference(extension,[status(thm),parent(t45:2)],[a_from_mars3]) ).

cnf(t48,plain,
    $false,
    inference(connection,[status(thm),parent(t47:1)],[t47:1,t45:2]) ).

cnf(t49,plain,
    ( a_truth(a_from_mars)
    | ~ from_mars(a) ),
    inference(extension,[status(thm),parent(t47:2)],[a_from_mars1]) ).

cnf(t50,plain,
    $false,
    inference(connection,[status(thm),parent(t49:1)],[t49:1,t47:2]) ).

cnf(t51,plain,
    from_mars(a),
    inference(lemma_extension,[status(thm),parent(t49:2)],[l1:1]) ).

cnf(t52,plain,
    $false,
    inference(connection,[status(thm),parent(t51:1)],[t51:1,t49:2]) ).

cnf(t53,plain,
    ( says(b,statement_by(b))
    | b != b
    | ~ says(b,a_has_lied)
    | a_has_lied != statement_by(b) ),
    inference(extension,[status(thm),parent(t45:3)],[equality_11]) ).

cnf(t54,plain,
    $false,
    inference(connection,[status(thm),parent(t53:1)],[t53:1,t45:3]) ).

cnf(t55,plain,
    ( b = b
    | b != b ),
    inference(extension,[status(thm),parent(t53:2)],[equality_2]) ).

cnf(t56,plain,
    $false,
    inference(connection,[status(thm),parent(t55:1)],[t55:1,t53:2]) ).

cnf(t57,plain,
    b = b,
    inference(extension,[status(thm),parent(t55:2)],[equality_1]) ).

cnf(t58,plain,
    $false,
    inference(connection,[status(thm),parent(t57:1)],[t57:1,t55:2]) ).

cnf(t59,plain,
    says(b,a_has_lied),
    inference(extension,[status(thm),parent(t53:3)],[b_says_a_lies]) ).

cnf(t60,plain,
    $false,
    inference(connection,[status(thm),parent(t59:1)],[t59:1,t53:3]) ).

cnf(l29,lemma,
    says(b,a_has_lied),
    inference(lemma,[status(cth),parent(t53:3),below(t45:3)],[t53:3]) ).

cnf(t61,plain,
    ( a_has_lied = statement_by(b)
    | ~ says(b,a_has_lied) ),
    inference(extension,[status(thm),parent(t53:4)],[people_say_their_statements]) ).

cnf(t62,plain,
    $false,
    inference(connection,[status(thm),parent(t61:1)],[t61:1,t53:4]) ).

cnf(t63,plain,
    says(b,a_has_lied),
    inference(lemma_extension,[status(thm),parent(t61:2)],[l29:1]) ).

cnf(t64,plain,
    $false,
    inference(connection,[status(thm),parent(t63:1)],[t63:1,t61:2]) ).

cnf(t65,plain,
    ( female(b)
    | ~ male(a) ),
    inference(extension,[status(thm),parent(t43:3)],[different_sex2]) ).

cnf(t66,plain,
    $false,
    inference(connection,[status(thm),parent(t65:1)],[t65:1,t43:3]) ).

cnf(t67,plain,
    ( male(a)
    | female(a) ),
    inference(extension,[status(thm),parent(t65:2)],[male_or_female]) ).

cnf(t68,plain,
    $false,
    inference(connection,[status(thm),parent(t67:1)],[t67:1,t65:2]) ).

cnf(t69,plain,
    ( ~ female(a)
    | ~ from_mars(a)
    | liar(a) ),
    inference(extension,[status(thm),parent(t67:2)],[marsian_females_are_liars]) ).

cnf(t70,plain,
    $false,
    inference(connection,[status(thm),parent(t69:1)],[t69:1,t67:2]) ).

cnf(t71,plain,
    from_mars(a),
    inference(lemma_extension,[status(thm),parent(t69:2)],[l1:1]) ).

cnf(t72,plain,
    $false,
    inference(connection,[status(thm),parent(t71:1)],[t71:1,t69:2]) ).

cnf(t73,plain,
    ( ~ liar(a)
    | ~ a_truth(a_from_mars)
    | ~ says(a,a_from_mars) ),
    inference(extension,[status(thm),parent(t69:3)],[liars_make_false_statements]) ).

cnf(t74,plain,
    $false,
    inference(connection,[status(thm),parent(t73:1)],[t73:1,t69:3]) ).

cnf(t75,plain,
    ( a_truth(a_from_mars)
    | ~ from_mars(a) ),
    inference(extension,[status(thm),parent(t73:2)],[a_from_mars1]) ).

cnf(t76,plain,
    $false,
    inference(connection,[status(thm),parent(t75:1)],[t75:1,t73:2]) ).

cnf(t77,plain,
    from_mars(a),
    inference(lemma_extension,[status(thm),parent(t75:2)],[l1:1]) ).

cnf(t78,plain,
    $false,
    inference(connection,[status(thm),parent(t77:1)],[t77:1,t75:2]) ).

cnf(t79,plain,
    says(a,a_from_mars),
    inference(extension,[status(thm),parent(t73:3)],[a_says_hes_from_mars]) ).

cnf(t80,plain,
    $false,
    inference(connection,[status(thm),parent(t79:1)],[t79:1,t73:3]) ).

% END OF SYSTEM OUTPUT
% RESULT: SOT_ygZSBg - TPTP4X---0.0 says Unknown - CPU = 0.00 WC = 0.01 
% OUTPUT: SOT_ygZSBg - TPTP4X---0.0 says None - CPU = 0 WC = 0 

% END OF SYSTEM OUTPUT
% RESULT: SOT_1GBxs5 - TPTP4X---0.0 says Unknown - CPU = 0.00 WC = 0.01 
% OUTPUT: SOT_1GBxs5 - TPTP4X---0.0 says None - CPU = 0 WC = 0 
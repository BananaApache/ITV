
import re
import argparse

STARTING_LINE = """tcf('0:0',conjecture, 
    $true, 
    introduced(language,[level(0)],[]),
    [] ).
"""

def get_all_formulas(filename="input.s"):
    raw_file = open(filename, 'r').readlines()

    all_formulas = []
    inside_formula = False
    pattern = r'^(tpi|thf|tff|tcf|fof|cnf)\('

    for line in raw_file:
        if re.match(pattern, line):
            inside_formula = True
            all_formulas.append(line.strip())
            continue
        
        if inside_formula:
            all_formulas[-1] += line.strip()
            if line.endswith(").\n"):
                inside_formula = False

    return all_formulas

def get_all_cnfs(filename="input.s"):
    try:
        all_formulas = get_all_formulas(filename)
        all_cnfs = []
        # might not work for other inferences with more than 3 parameters!!
        inference_pattern = r'inference\(\s*([^,\[\]]+),\s*(\[(?:[^\[\]]+|\[[^\[\]]*\])*\]),\s*(\[(?:[^\[\]]+|\[[^\[\]]*\])*\])\s*\)'

    for formula in all_formulas:
        if formula.startswith("cnf(") and "path" in formula:
            cut_formula = formula[4:][:-3]
            cnf_formula = cut_formula.split(",")[2].replace(" ", "")
            inference = ",".join(cut_formula.split(",")[3:])
            all_cnfs.append(
                {
                    "raw": formula,
                    "name": cut_formula.split(",")[0],
                    "formula_role": cut_formula.split(",")[1],
                    "formula": cnf_formula[1:-1].strip() if cnf_formula.strip().startswith('(') and cnf_formula.strip().endswith(')') else cnf_formula.strip(),
                    # "annotations": inference,
                    "inference_rule": re.match(inference_pattern, inference).group(1),
                    # "useful_info": re.match(pattern, inference).group(2),
                    "path": [item.strip() for item in re.search(r'path\(\[([^\]]*)\]\)', inference).group(1).split(',')],
                    "parents": re.match(inference_pattern, inference).group(3)
                }
            )

    # for cnf in all_cnfs:
    #     print(f"Raw Formula: {cnf['raw'].replace(' ', '')}")
    #     print(f"Name: {cnf['name']}")
    #     print(f"Formula Role: {cnf['formula_role']}")
    #     print(f"Formula: {cnf['formula']}")
    #     # print(f"Annotations: {cnf['annotations']}")
    #     print(f"Inference Rule: {cnf['inference_rule']}")
    #     # print(f"Useful Info: {cnf['useful_info']}")
    #     print(f"Path: {cnf['path']}")
    #     print(f"Parents: {cnf['parents']}")
    #     print()
        
    # print("Total formulas:", len(all_formulas))
    # print("Converted formulas:", len(all_cnfs))

    return all_cnfs

#~ if inference_rule is lemma -> then make it thf + axiom
#~ if formula is $true OR $false -> then make it tcf + conjecture
#~ everything else if fof + plain

#~ if has formula, split it by "|" to get the literals -> then create new formulas and number them accordingly

#~ ORIGINAL: cnf(t1    , plain, ( q(b) | ~ s(sK1) ), inference(start,[status(thm),path([0:0])],[c1]) ).

#~ TEMPLATE: fof('t1:1', plain, q(b)   , inference(extension,[level(1)],['0:0']), []      ).
#~                name , role , formula, annotations                            , parents

def convert_cnfs(filename="input.s", output_filename=None):
    all_cnfs = get_all_cnfs(filename)
    
    if len(all_cnfs) > 0:
        noErrors = True
    else:
        noErrors = False



    output = [STARTING_LINE]

    for cnf in all_cnfs:
        if ("(" in cnf['formula'] or ")" in cnf['formula']) and cnf['inference_rule'] != "lemma_extension" and cnf['inference_rule'] != "lemma": # for formulas
            literals = cnf['formula'].split("|")
            for i, literal in enumerate(literals):
                if len(cnf['path']) == 2 and i + 2 <= len(literals):
                    new_formula = f"""
fof('{cnf['name']}:{i + 1}',plain, 
    {literal},
    inference({cnf['inference_rule']},[level({len(cnf['path'])}), nextTo('{cnf['name']}:{i + 2}')],['{cnf['path'][0]}']), 
    [] ).
                """
                    output.append(new_formula)
                    continue
                else:
                    new_formula = f"""
fof('{cnf['name']}:{i + 1}',plain, 
    {literal},
    inference({cnf['inference_rule']},[level({len(cnf['path'])})],['{cnf['path'][0]}']), 
    [] ).
                """
                    output.append(new_formula)
                    continue
                
        elif ("(" in cnf['formula'] or ")" in cnf['formula']) and cnf['inference_rule'] == "lemma_extension": # for formulas lemma_extension
            literals = cnf['formula'].split("|")
            for i, literal in enumerate(literals):
                new_formula = f"""
fof('{cnf['name']}:{i + 1}',plain,
    {literal},
    inference({cnf['inference_rule']},[level({len(cnf['path'])}), hoverNode('{cnf['parents'].strip("[]")}')],['{cnf['path'][0]}']), 
    [] ).
                """
                output.append(new_formula)
                continue
        
        elif "true" in cnf['formula'] or "false" in cnf['formula']: # for $true and $false
            # connection
            if cnf['inference_rule'] == "connection":
                new_formula = f"""
tcf({cnf['name']},conjecture,
    {cnf['formula']},
    inference({cnf['inference_rule']},[level({len(cnf['path'])})],['{cnf['path'][0]}']),
    [] ).
                """
                output.append(new_formula)
                continue
            
            # lemma_extension
            elif cnf['inference_rule'] == "lemma_extension":
                new_formula = f"""
tcf({cnf['name']},conjecture,
    {cnf['formula']},
    inference({cnf['inference_rule']},[level({len(cnf['path'])}), hoverNode('{cnf['parents'].strip("[]").split(",")[0]}')],['{cnf['path'][0]}']),
    [] ).
                """
                output.append(new_formula)
                continue
            
            # reduction
            else:
#                 new_formula = f"""
# tcf({cnf['name']},conjecture, 
#     {cnf['formula']}, 
#     inference({cnf['inference_rule']},[level({len(cnf['path'])})],{"[" + ",".join(f"'{item}'" for item in cnf['parents'].strip("[]").split(",")) + "]"}), 
#     [] ).
                new_parents = cnf['parents'].strip("[]").split(",")
                new_parents.remove(cnf['path'][0]) 

                new_formula = f"""
tcf({cnf['name']},conjecture, 
    {cnf['formula']}, 
    inference({cnf['inference_rule']},[level({len(cnf['path'])}), hoverNode('{new_parents[0]}')],['{cnf['path'][0]}']), 
    [] ).
                """
                output.append(new_formula)
                continue

        elif cnf['inference_rule'] == "lemma": # for lemmas
            new_formula = f"""
thf('{cnf['name']}:{1}',axiom, 
    {cnf['formula']}, 
    inference({cnf['inference_rule']},[level({len(cnf['path']) - 1}), nextTo('{cnf['path'][0]}')],['{cnf['path'][0]}']), 
    [] ).
            """
            output.append(new_formula)
            continue
        
    if output_filename is not None:
        with open(output_filename, "w") as f:
            f.writelines(output)
            print("\nFile written successfully.\n")
            print(f"Input file: {filename}")
            print(f"Output file: {output_filename}")
            
        return output
    else:
        for line in output:
            print(line.strip())

        return output

    if noErrors is True:
        output[-1] = output[-1] + "\n"
        with open(output_filename, "w") as f:
            f.writelines(output)
#        print("\nFile written successfully.\n")
#        print(f"Input file: {filename}")
#        print(f"Output file: {output_filename}")
        
        print("% SYZ status Sucess")
        print(f"% SZS output start ListOfFormulae for {filename}")
        for line in output:
            print(line)
        print(f"% SZS output end ListOfFormulae for {output_filename}")

        return output
    else:
        print("% SZS status NoSucess")
        return []


parser = argparse.ArgumentParser(description="Process one input file and one output file.")
parser.add_argument("input_file", help="Path to the input file")
parser.add_argument("output_file", nargs='?', help="Path to the output file (optional)")

args = parser.parse_args()

if args.output_file:
    convert_cnfs(args.input_file, args.output_file)
else:
    convert_cnfs(args.input_file)


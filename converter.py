
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

    for cnf in all_cnfs:
        print(f"Raw Formula: {cnf['raw'].replace(' ', '')}")
        print(f"Name: {cnf['name']}")
        print(f"Formula Role: {cnf['formula_role']}")
        print(f"Formula: {cnf['formula']}")
        # print(f"Annotations: {cnf['annotations']}")
        print(f"Inference Rule: {cnf['inference_rule']}")
        # print(f"Useful Info: {cnf['useful_info']}")
        print(f"Path: {cnf['path']}")
        print(f"Parents: {cnf['parents']}")
        print()
        
    print("Total formulas:", len(all_formulas))
    print("Converted formulas:", len(all_cnfs))

    return all_cnfs

#~ if inference_rule is lemma -> then make it thf + axiom
#~ if formula is $true OR $false -> then make it tcf + conjecture
#~ everything else if fof + plain

#~ if has formula, split it by "|" to get the literals -> then create new formulas and number them accordingly

#~ ORIGINAL: cnf(t1    , plain, ( q(b) | ~ s(sK1) ), inference(start,[status(thm),path([0:0])],[c1]) ).

#~ TEMPLATE: fof('t1:1', plain, q(b)   , inference(extension,[level(1)],['0:0']), []      ).
#~                name , role , formula, annotations                            , parents

def convert_cnfs(filename="input.s", output_filename="new_output.s"):
    all_cnfs = get_all_cnfs(filename)

    output = [STARTING_LINE]

    for cnf in all_cnfs:
        if "|" in cnf['formula']: # for formulas
            literals = cnf['formula'].split("|")
            for i, literal in enumerate(literals):
                new_formula = f"""
    fof('{cnf['name']}:{i + 1}',plain, 
        {literal}, 
        inference({cnf['inference_rule']},[level({len(cnf['path'])})],['{cnf['path'][0]}']), 
        [] ).
                """
                output.append(new_formula)
        
        if "true" in cnf['formula'] or "false" in cnf['formula']: # for $true and $false
            # connection
            if cnf['inference_rule'] == "connection":
                new_formula = f"""
    tcf({cnf['name']},conjecture, 
        {cnf['formula']}, 
        inference({cnf['inference_rule']},[level({len(cnf['path'])})],['{cnf['path'][0]}']), 
        [] ).
                """
            
            # lemma_extension
            elif cnf['inference_rule'] == "lemma_extension":
                new_formula = f"""
    tcf({cnf['name']},conjecture, 
        {cnf['formula']},
        inference({cnf['inference_rule']},[level({len(cnf['path']) - 1})],{"[" + ",".join(f"'{item}'" for item in cnf['parents'].strip("[]").split(",")) + "]"}), 
        [] ).
                """
            
            # reduction
            else:
                new_formula = f"""
    tcf({cnf['name']},conjecture, 
        {cnf['formula']}, 
        inference({cnf['inference_rule']},[level({len(cnf['path'])})],{"[" + ",".join(f"'{item}'" for item in cnf['parents'].strip("[]").split(",")) + "]"}), 
        [] ).
                """

            output.append(new_formula)

        if cnf['inference_rule'] == "lemma": # for lemmas
            
            new_formula = f"""
    thf('{cnf['name']}:{1}',axiom, 
        {cnf['formula']}, 
        inference({cnf['inference_rule']},[level({len(cnf['path']) - 1})],['{cnf['path'][0]}'], nextTo('{cnf['path'][0]}')), 
        [] ).
            """
            output.append(new_formula)

    with open(output_filename, "w") as f:
        f.writelines(output)
        print("\nFile written successfully.\n")
        print(f"Input file: {filename}")
        print(f"Output file: {output_filename}")
        
    return output


parser = argparse.ArgumentParser(description="Process one input file and one output file.")
parser.add_argument("input_file", help="Path to the input file")
parser.add_argument("output_file", help="Path to the output file")

args = parser.parse_args()

convert_cnfs(args.input_file, args.output_file)


import re

text = 'inference(start, [status(thm), path([0:0])], [c1])'

pattern = r'inference\(\s*([^,\[\]]+),\s*(\[(?:[^\[\]]+|\[[^\[\]]*\])*\]),\s*(\[(?:[^\[\]]+|\[[^\[\]]*\])*\])\s*\)'

match = re.match(pattern, text)

if match:
    arg1 = match.group(1)
    arg2 = match.group(2)
    arg3 = match.group(3)
    print("Arg1:", arg1)
    print("Arg2:", arg2)
    print("Arg3:", arg3)
else:
    print("No match.")

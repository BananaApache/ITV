
from antlr4 import *

from PythonParsers.g4.TPTPLexer import TPTPLexer
from PythonParsers.g4.TPTPParser import TPTPParser
from PythonParsers.g4.TPTPVisitor import TPTPVisitor

class MyCNFVisitor(TPTPVisitor):
    def visitCnf_annotated(self, ctx):
        return {
            "name": ctx.name(),
            "role": ctx.formula_role(),
            "formula": ctx.cnf_formula(),
            "annotations": ctx.annotations()
        }

    
text = """
cnf(t6,plain,
    ( ~ liar(b)
    | ~ a_truth(statement_by(b))
    | ~ says(b,statement_by(b)) ),
    inference(extension,[status(thm),parent(t4:2)],[liars_make_false_statements]) ).
"""

input_stream = InputStream(text)
lexer = TPTPLexer(input_stream)
token_stream = CommonTokenStream(lexer)
parser = TPTPParser(token_stream)
parser.removeErrorListeners()

tree = parser.cnf_annotated()
visitor = MyCNFVisitor()
result = visitor.visit(tree)

print(result)

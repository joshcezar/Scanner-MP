import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;

import java.util.ArrayList;

import static org.antlr.v4.runtime.CharStreams.fromFileName;

public class Scanner {

    public static void main(String[] args) throws Exception {
        String file = "testinputs.txt";
        CharStream inputs = fromFileName(file);
        MingoXDLexer lexer = new MingoXDLexer(inputs);
        Token token = lexer.nextToken();
        while (token.getType() != MingoXDLexer.EOF) {
            if(token.getType() == lexer.Keyword) {
                System.out.println("Keyword\t\t\t: " + token.getText());
            }
            else if(token.getType() == lexer.Identifier) {
                System.out.println("Identifier\t\t: " + token.getText());
        }
            else if(token.getType() == lexer.Operator) {
                System.out.println("Operator\t\t: " + token.getText());
            }
            else if(token.getType() == lexer.Literal) {
                System.out.println("Literal\t\t\t: " + token.getText());
            }
            else if(token.getType() == lexer.Separator) {
                System.out.println("Separator\t\t: " + token.getText());
            }
            else
                System.out.println("Other");
            token = lexer.nextToken();
        }
    }
}

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;

import java.util.ArrayList;

import static org.antlr.v4.runtime.CharStreams.fromFileName;

public class Scanner {

    public static void main(String[] args) throws Exception {
        String filename = "testinputs.txt";
        CharStream input = fromFileName(filename);
        MingoXDLexer lexer = new MingoXDLexer(input);

        Token token = lexer.nextToken();
        ArrayList<Token> tokens = new ArrayList<>();
        while (token.getType() != MingoXDLexer.EOF) {
            if(token.getType() == lexer.Keyword) {
                System.out.println("Keyword");
            }
            else if(token.getType() == lexer.Identifier)
                System.out.println("Identifier");
            else if(token.getType() == lexer.Operator)
                System.out.println("Operator");
            else if(token.getType() == lexer.Literal)
                System.out.println("Literal");
            else if(token.getType() == lexer.Separator)
                System.out.println("Separator");
            tokens.add(token);
            token = lexer.nextToken();
        }
    }
}

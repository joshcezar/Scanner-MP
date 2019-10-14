import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;

import java.util.ArrayList;

import static org.antlr.v4.runtime.CharStreams.fromFileName;

public class TestLexer {

    public static void main(String[] args) throws Exception {
        String filename = "testinputs.txt";
        CharStream input = fromFileName(filename);
        MingoXDLexer lexer = new MingoXDLexer(input);

        Token token = lexer.nextToken();
        ArrayList<Token> tokens = new ArrayList<>();
        ArrayList<String> tokentypes = new ArrayList<>();
        while (token.getType() != MingoXDLexer.EOF) {
            tokens.add(token);
            token = lexer.nextToken();
            if(token == lexer.Key)
        }
    }
}

package grammar;

import java.io.File;
import java.io.FileReader;

public class Manager {
    private static parser p;

    public static void setFileAndCheck(File file) throws Exception, Error {
        p = new parser(new Lexer(new FileReader(file)));
        p.parse();
    }

    public static void show() {
        p.show();
    }
}

package ljh;

import grammar.Manager;

import java.io.File;

public class Main {
    static public void main(String argv[]) {
        try {
            Manager.setFileAndCheck(new File("./data.txt"));
            Manager.show();
        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }catch (Error e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

}



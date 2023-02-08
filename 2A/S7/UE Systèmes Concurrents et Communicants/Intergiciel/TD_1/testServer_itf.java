import java.net.*;
import java.io.*;

public class testServer_itf {
    final static String hosts[] = {"host1", "host2", "host3"};
    final static int ports[] = {8081,8082,8083};
    final static int nb = 3;
    static String document[] = new String[nb];

    int fragment;

    public testServer_itf(int i) {
        this.fragment = i;
    }

    public void run() {
        
    }
    public static void main(String[] args) {

        try {

            while(true) {        
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}

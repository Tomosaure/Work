import java.util.Random;
import java.net.Socket;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;

public class LoadBalancer extends Thread {
    static String hosts[] = {"localhost", "localhost"};
    static int ports[] = {8081,8082};
    static int nbHosts = 2;
    static Random rand = new Random();
    private Socket client;
         
    public LoadBalancer(Socket s1) {
        this.client = s1;
    }

    public static void main(String[] args) throws IOException {
        ServerSocket ss1 = new ServerSocket(8080);
        while (true) {
            Socket s1 = ss1.accept();
            new LoadBalancer(s1).start();
        }
    }

    public void run() {
        try {
            int i = rand.nextInt(nbHosts);
            Socket server = new Socket(hosts[i], ports[i]);
            OutputStream clientOS = client.getOutputStream();
            OutputStream serverOS = server.getOutputStream();
            InputStream clientIS = client.getInputStream();
            InputStream serverIS = server.getInputStream();
            byte [] buff = new byte[1024];
            int nbCR = clientIS.read(buff);
            serverOS.write(buff, 0, nbCR);
            int nbSR = serverIS.read(buff);
            clientOS.write(buff, 0, nbSR);
            client.close();
            server.close();

            } catch (Exception e) {
                    e.printStackTrace();
        }
    }
}
import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.registry.*;
import java.net.*;
import java.util.HashMap;

public class Server extends UnicastRemoteObject implements Server_itf {

    private static int identifiant = 0;
    
	// HashMap des objets partagés stockés au niveau du serveur
	private static HashMap<Integer, ServerObject> serverObjects;

    // HashMap des objets partagés ayant pour clé leur identifiant et le nom la donnée niveau du serveur
	private static HashMap<String, Integer> name_serverObjects;


    public Server() throws RemoteException {
        super();
        serverObjects = new HashMap<Integer, ServerObject>();
        name_serverObjects = new HashMap<String, Integer>();
    }

    @Override
    public int lookup(String name) throws RemoteException {
        Integer identifiant = name_serverObjects.get(name);
        if (identifiant != null)
            return identifiant;
        else
            return -1;
    }

    @Override
    public void register(String name, int id) throws RemoteException {
        name_serverObjects.put(name, id);
    }
    
    private int incrementer() {
        return identifiant+1;
    }

    @Override
    public int create(Object o) throws RemoteException {
        incrementer();
        ServerObject servObj = new ServerObject(o, identifiant);
        serverObjects.put(identifiant, servObj);
        return identifiant;
    }

    @Override
    public Object lock_read(int id, Client_itf client) throws RemoteException {
        ServerObject so = serverObjects.get(id);
        return so.lock_read(client);
    }

    @Override
    public Object lock_write(int id, Client_itf client) throws RemoteException {
        ServerObject so = serverObjects.get(id);
        return so.lock_write(client);

    } 

    public static void main(String[] args) {
        try {
            LocateRegistry.createRegistry(Registry.REGISTRY_PORT);
            Server server = new Server();
            String URL = "//" + InetAddress.getLocalHost().getHostName() + ":" + Registry.REGISTRY_PORT + "/monServer";
            Naming.rebind(URL, server);
        } catch (Exception e) {
            e.printStackTrace();
        }
    
    }
}

import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.*;
import java.util.*;

public class testImpl extends UnicastRemoteObject implements MOMItf {

    private HashMap<String,  Vector<CallBack>> subscribers;

    public testImpl() throws RemoteException {
        subscribers = new HashMap<String, Vector<CallBack>>();
    }

    public void publish(String topic, Message message) throws RemoteException {

    }

    public void subscribe(String topic, Callback cb) throws RemoteException {
        
    }

    public static void main(String[] args) {
        try {
        Naming.rebind("//localhost:4000/MOM",new testImpl());
        }
        catch (Exception e) {
        e.printStackTrace();
        }
    }
}

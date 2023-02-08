import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.registry.*;
import java.net.*;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.lang.reflect.Constructor;

public class Client extends UnicastRemoteObject implements Client_itf {

	private static Client_itf client;

	private static Server_itf server;

	private static String serverURL;

	// HashMap des objets partagés stockés au niveau du client
	private static HashMap<Integer, SharedObject> sharedObjects;

	/**
	 * Constructeur du client
	 * @throws RemoteException
	 */
	public Client() throws RemoteException {
		super();
		sharedObjects= new HashMap<Integer, SharedObject>();

	}


///////////////////////////////////////////////////
//         Interface to be used by applications
///////////////////////////////////////////////////

	// initialization of the client layer
	public static void init() {
		// Initialisation du client
		try {
			client = new Client();
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		// Initialisation de la variable contenant les objets partagés
		sharedObjects = new HashMap<Integer, SharedObject>();

		// Récupérer l'URL du serveur
		InetAddress a;
		int port = Registry.REGISTRY_PORT;
		try {
			a = InetAddress.getLocalHost();
			serverURL = "//" + a.getHostName() + ":" + port + "/monServer";
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
		// Initialisation du serveur en récupérant ses informations
		try {
			server = (Server_itf) Naming.lookup(serverURL);
		} catch (MalformedURLException | RemoteException | NotBoundException e) {
			e.printStackTrace();
		}
	}
	
	// lookup in the name server
	public static SharedObject lookup(String name) {
		SharedObject shared_obj = null;
		try {
			// On récupère l'id de l'objet partagé à partir de son nom du côté du serveur
			Integer id = server.lookup(name);
			if (id != -1) {
				Object obj = server.lock_read(id, client);
				shared_obj = StubCreator(obj, id);
				shared_obj.unlock();
				sharedObjects.put(id, shared_obj);
			}
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return shared_obj;
	}		
	
	// binding in the name server
	public static void register(String name, SharedObject_itf so) {
		try {
			server.register(name, ((SharedObject) so).getId());
		} catch (RemoteException e) {
			e.printStackTrace();
		}
	}

	// creation of a shared object
	public static SharedObject create(Object o) {
		SharedObject shared_obj = null;
		try {
			// Création de l'objet côté serveur et récupération de son identifiant
			int id = server.create(o);
			// Création du ShareObjetct côté client
			shared_obj = StubCreator(o, id);
			// Ajout de l'objet partagé créee dans le HashMap
			sharedObjects.put(id, shared_obj);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return shared_obj;

	}
	
/////////////////////////////////////////////////////////////
//    Interface to be used by the consistency protocol
////////////////////////////////////////////////////////////

	// request a read lock from the server
	public static Object lock_read(int id) {
		Object obj = null;
		try {
			obj = server.lock_read(id, client);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return obj;
	}

	// request a write lock from the server
	public static Object lock_write (int id) {
		Object obj = null;
		try {
			obj = server.lock_write(id, client);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return obj;
	}

	// receive a lock reduction request from the server
	public Object reduce_lock(int id) throws java.rmi.RemoteException {
		return sharedObjects.get(id).reduce_lock();
	}


	// receive a reader invalidation request from the server
	public void invalidate_reader(int id) throws java.rmi.RemoteException {
		sharedObjects.get(id).invalidate_reader();
	}


	// receive a writer invalidation request from the server
	public Object invalidate_writer(int id) throws java.rmi.RemoteException {
		return sharedObjects.get(id).invalidate_writer();
	}

	public static SharedObject StubCreator (Object obj, int id) {
		SharedObject shared_obj = null;
		try {
			Class<?> c = Class.forName(obj.getClass().getName()+"_stub");
			Constructor<?> constructor = c.getConstructor(new Class[] {Object.class, int.class});
			shared_obj = (SharedObject) constructor.newInstance(new Object[] {obj, id});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return shared_obj;
	}

	public static SharedObject getSharedObject(int id) {
		return sharedObjects.get(id);
	}
}

import java.io.*;

public class SharedObject implements Serializable, SharedObject_itf {

	// Champ obj pointant sur l'objet effectif
	protected Object obj; 
	
	// Identifiant unique de l'objet par rapport au serveur
	private int id; 

	// Attribut lock indiquant l'état du verrouillage de l'objet sur le site
	private int lock; 

	// Boolean indiquant si le verrou est tenu
	private boolean locked;

	private final static int NL = 0; // no local lock
	private final static int RLC = 1; // read lock cached (not taken)
	private final static int WLC = 2; // write lock cached
	private final static int RLT = 3; // read lock taken
	private final static int WLT = 4; // write lock taken
	private final static int RLT_WLC = 5; // read lock taken and write lock cached

	/**
	 * Constructeur de la classe SharedObject
	 * @param obj	objet à partager
	 * @param id identifiant du ShareObjetct
	 */
	public SharedObject(Object obj, int id) {
		this.obj = obj;
		this.id = id;
		this.lock = NL;
		this.locked = false;
	}

	/**
	 * Récupérer l'id du SharedObject
	 * @return id du SharedObject
	 */
	public int getId() {
		return this.id;
	}

	// invoked by the user program on the client node
	public void lock_read() {
		boolean bool = false;
		synchronized(this) {
			if (this.locked) {
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			switch (this.lock) {
				case NL :
					bool = true;
					this.lock = RLT;
					break;
				case RLC :
					this.lock = RLT;
					break;
				case WLC :
					this.lock = RLT_WLC;
					break;
				default :
					break;
			}
		}
		if (bool) {
			this.obj = Client.lock_read(this.id);
		}
	}

	// invoked by the user program on the client node
	public  void lock_write() {
		boolean bool = false;
		synchronized(this) {
			// Le verrou est tenu, il faut attendre
			if (this.locked) {
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
	
			// diagramme slide 28
			switch (this.lock) {
				case NL:
					bool = true;
					this.lock = WLT;
					break;
	
				case RLC:
				bool = true;
				this.lock = WLT;
					break;
				case WLC:
					this.lock = WLT;
					break;
				default:
					break;
			}
		}
		if (bool) {
			this.obj = Client.lock_write(this.id);
		}
	}

	// invoked by the user program on the client node
	public synchronized void unlock() {
		switch (this.lock) {
			case RLT :
				this.lock = RLC;
				break;
			case WLT :
				this.lock = WLC;
				break;
			case RLT_WLC :
				this.lock = WLC;
				break;
			default :
				break;
		}
		notify();
	}


	// callback invoked remotely by the server
	public synchronized Object reduce_lock() {
		this.locked = true;
		// voir diagramme slide 19, 21
		switch (this.lock) {
			case WLT:
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			case WLC:
				this.lock = RLC;
				break;
			case RLT_WLC:
				this.lock = RLT;
				break;
			default:
				break;
		}
		notify();
		this.locked = false;
		return this.obj;

	}

	// callback invoked remotely by the server
	public synchronized void invalidate_reader() {
		this.locked = true;
		switch (this.lock) {
			case RLT:
				try {
					wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			case RLC :
				this.lock = NL;
				break;
			default :
				break;
		}
		this.locked = false;
		notify();
	}

	public synchronized Object invalidate_writer() {
		this.locked = true;
		// voir diagr"amme slide 28
		switch (this.lock) {
			// On attend la fin de l'écriture
			case WLT:
					try {
						wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
			case WLC:
				this.lock = NL;
				break;
			case RLT_WLC:
					try {
						wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				this.lock = NL;
				break;
			default:
				break;
		}
		this.locked = false;
		notify();
		return this.obj;
	}

	// méthode appelée lors de la désérialisation d'un objet
	protected Object readResolve() throws ObjectStreamException {
		// Récupère l'objet partagé depuis le serveur
		Object obj = Client.getSharedObject(this.id);

		Client.StubCreator(obj, this.id);

		// Retourne l'objet partagé 
		return obj;
	}

	// méthode appelée lors de la sérialisation d'un objet
	protected void writeObject(ObjectOutputStream out) throws IOException {
		out.writeObject(this.obj);
	}
}
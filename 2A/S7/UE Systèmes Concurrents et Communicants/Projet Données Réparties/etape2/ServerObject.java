import java.util.ArrayList;
import java.io.Serializable;
import java.rmi.RemoteException;

public class ServerObject implements Serializable, ServerObject_itf {

    // Objet partagé
    private Object obj;

    // Identifiant de l'objet
    private int id;

    // Mode de verrouillage de l'objet
    private int lock;

    private final static int NL = 0; // no lock
    private final static int RL= 1; // read lock
    private final static int WL = 2; // write lock 

    // Client écrivain si l'objet est en écriture
    private Client_itf ecrivain; 

    // Liste des clients lecteurs si l'objet est en lecture
    private ArrayList<Client_itf> lecteurs;

    public ServerObject(Object obj, int id) {
        this.obj = obj;
        this.id = id;
        this.lock = NL;
        this.ecrivain = null;
        this.lecteurs = new ArrayList<Client_itf>();
    }

    public synchronized Object lock_read(Client_itf client) {
        switch (this.lock) {
            case NL :
                this.lock = RL;
                this.lecteurs.add(client);
                break;
            case RL :
                this.lecteurs.add(client);
                break;
            case WL :
                try {
                    this.obj = ecrivain.reduce_lock(this.id);
                } catch (RemoteException e) {
                    e.printStackTrace();
                }
                this.lock = RL;
                this.lecteurs.add(this.ecrivain);
                this.lecteurs.add(client);
                this.ecrivain = null;
                break;
        }
        return obj;
    }

    public synchronized Object lock_write(Client_itf client) {
        switch (this.lock) {
            case NL :
                this.lock = WL;
                this.ecrivain = client;
                this.lecteurs.clear();
                break;
            case RL :
                this.lecteurs.remove(client);
                for (Client_itf lecteur : this.lecteurs) {
                    try {
                        lecteur.invalidate_reader(this.id);
                    } catch (RemoteException e) {
                        e.printStackTrace();
                    }
                }
                this.lock = WL;
                this.ecrivain = client;
                this.lecteurs.clear();

                break;
            case WL :
                try {
                    this.obj = this.ecrivain.invalidate_writer(this.id);
                } catch (RemoteException e) {
                    e.printStackTrace();
                }
                this.ecrivain = client;
                this.lecteurs.clear();
                break;
        }
        return obj;
    }
}

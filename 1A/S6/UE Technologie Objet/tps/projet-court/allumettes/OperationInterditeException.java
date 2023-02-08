package allumettes;

/** Exception pour indiquer à un joueur qui triche que son action est interdite.
 * @author tbonetto
 */

public class OperationInterditeException extends RuntimeException {

	/** Initaliser une OperationInterditeException avec le message précisé.
	 * @param message le message explicatif
	 */
	public OperationInterditeException(String message) {
		super(message);
	}

}

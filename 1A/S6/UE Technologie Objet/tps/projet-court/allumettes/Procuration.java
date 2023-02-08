package allumettes;

public class Procuration implements Jeu {

	private Jeu jeu;
	/** le jeu . */

	/**
	 * Constructeur de jeu procuration.
	 *
	 * @param jeu le jeu
	 */
	public Procuration(Jeu jeu) {
		assert (jeu != null);
		this.jeu = jeu;
	}

	@Override
	public int getNombreAllumettes() {
		return this.jeu.getNombreAllumettes();
	}

	@Override
	public void retirer(int nbPrises) throws OperationInterditeException {
		throw new OperationInterditeException(null);

	}

}

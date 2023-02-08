package allumettes;

public class JeuSimple implements Jeu {

	/** Nombre d'allumettes du jeu. */
	private int nbAllumettes;

	/**
	 * Constructeur de JeuSimple.
	 *
	 * @param nombreAllumette le nombre d'allumettes
	 */
	public JeuSimple(int nombreAllumette) {
		assert (nombreAllumette > 0);
		this.nbAllumettes = nombreAllumette;
	}

	@Override
	public int getNombreAllumettes() {
		int aux = nbAllumettes;
		return aux;
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		if (nbPrises > this.nbAllumettes || nbPrises <= 0
			|| nbPrises > Jeu.PRISE_MAX) {
			throw new CoupInvalideException(nbPrises, "Coup invalide");
		} else {
			this.nbAllumettes -= nbPrises;
		}
	}
}

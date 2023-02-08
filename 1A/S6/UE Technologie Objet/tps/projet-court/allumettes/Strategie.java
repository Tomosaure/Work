package allumettes;

public interface Strategie {

	/** Retourne le nombre d'allumettes en fonction de la strategie
	 *
	 * @param jeu le jeu
	 * @return le nombre d'allumettes
	 */
	int getPrise(Jeu jeu);
}

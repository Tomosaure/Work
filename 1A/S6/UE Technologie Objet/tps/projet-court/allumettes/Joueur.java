package allumettes;

public class Joueur {

	/** Nom du joueur. */
	private String nom;
	/** Stratégie du joueur. */
	private Strategie strategie;

	/** Constructeur de joueur avec la liste chaine contenant nom et stratégie.
	 *
	 * @param nom nom du joueur
	 * @param strategie stratégie du joueur
	 */
	public Joueur(String nom, Strategie strategie) {
		this.nom = nom;
		this.strategie = strategie;
	}

	/**
	 * Obtenir le nom du joueur.
	 *
	 * @return le nom du joueur
	 */
	public String getNom() {
		String aux = this.nom;
		return aux;
	}

	/**
	 * Obtenir la stratégie.
	 *
	 * @return la stratégie
	 */
	public Strategie getStrategie() {
		return this.strategie;
	}

	/** Etablir la stratégie
	 *
	 * @param nouvelleStrategie la nouvelle stratégie du joueur
	 */
	public void setStrategie(Strategie nouvelleStrategie) {
		this.strategie = nouvelleStrategie;
	}

	/**
	 * Obtenir la prise du joueur.
	 *
	 * @param jeu
	 * @return la prise du joueur
	 */
	public int getPrise(Jeu jeu) {
		return this.strategie.getPrise(jeu);
	}

	/**
	 * Comparer deux joueur pour savoir si ce sont les mêmes.
	 *
	 * @param j2 le joueur à comparer
	 * @return true si les joueurs sont égaux, false sinon
	 */
	public boolean joueurEgal(Joueur j2) {
		return this.nom == j2.nom;
	}
}

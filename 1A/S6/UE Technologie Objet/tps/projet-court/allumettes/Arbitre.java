package allumettes;

import java.util.Scanner;

public class Arbitre {

	/** Le joueur1. */
	private Joueur joueur1;
	/** Le joueur2. */
	private Joueur joueur2;
	/** Rend l'arbitre confiant. */
	private boolean confiant;

	/** Constructeur d'Arbitre à partir de joueur 1 et 2.
	 * @param j1 joueur 1
	 * @param j2 joueur 2
	 */
	public Arbitre(Joueur j1, Joueur j2) {
		assert (j1 != null && j2 != null);
		this.joueur1 = j1;
		this.joueur2 = j2;
	}

	/** Constructeur d'Arbitre à partir de joueur 1 et 2 et confiant.
	 * @param j1 joueur 1
	 * @param j2 joueur 2
	 * @param confiant argument confiant pour l'arbitre
	 */
	public Arbitre(Joueur j1, Joueur j2, boolean confiant) {
		assert (j1 != null && j2 != null);
		this.joueur1 = j1;
		this.joueur2 = j2;
		this.confiant = confiant;
	}

	/**
	 * Méthode qui retourne soit getPrise de la classe JeuSimple soit de
	 * Procuration.
	 * @param jeu    le jeu actuel
	 * @param joueur le joueur courant du tour
	 * @return la prise d'allumettes du joueur
	 */
	public int getPrise(Jeu jeu, Joueur joueur) {
		if (this.confiant) {
			return joueur.getPrise(jeu);
		} else {
			return joueur.getPrise(new Procuration(jeu));
		}
	}

	/** Retourne la stratégie souhaitée.
	 *
	 * @param strategieStr la stratégie souhaitée
	 * @param joueur le joueur actuel
	 * @return la stratégie souhaitée
	 */
	public Strategie stringToJoueur(String strategieStr, Joueur joueur) {
		if (strategieStr == "non") {
			return joueur.getStrategie();
		} else {
			return Jouer.stringToJoueur(strategieStr);
		}
	}

	/** Afficher des indications sur la de changer de stratégie. */
	public static void afficherChangementStrategie() {
		System.out.println("\n" + "Changement de stratégie ? :" + "\n\t"
				+ "strategie = naif | rapide | expert | humain | tricheur"
				+ " | lent" + "\n" + "pas de changement : non");
	}

	/**
	 * Arbitrer la partie entre les 2 joueurs.
	 * @param jeu le jeu en question
	 */
	public void arbitrer(Jeu jeu, boolean changementStrategie) {

		Scanner scan = new Scanner(System.in);
		assert (jeu != null);
		Joueur joueur = this.joueur1;
		Strategie strat = null;
		boolean coupinvalide = false;
		int nbretirer = 0;
		boolean tricherie = false;
		String strategieStr;
		while (jeu.getNombreAllumettes() > 0 && !tricherie) {

			try {
				strat = joueur.getStrategie();
				coupinvalide = false;
				System.out.println("Allumettes restantes : " + jeu.getNombreAllumettes());

				if (changementStrategie) {
					afficherChangementStrategie();
					strategieStr = scan.nextLine();
					joueur.setStrategie(stringToJoueur(strategieStr, joueur));
				}
				if (strat.getClass() == StrategieHumain.class) {
					nbretirer = StrategieHumain.getPrise(jeu, joueur.getNom(), scan);
				} else {
					nbretirer = this.getPrise(jeu, joueur);
				}

				if (nbretirer <= 1) {
					System.out.print(joueur.getNom() + " prend ");
					System.out.println(nbretirer + " allumette.");
				} else {
					System.out.print(joueur.getNom() + " prend ");
					System.out.println(nbretirer + " allumettes.");
				}
				System.out.println();
				jeu.retirer(nbretirer);

			} catch (CoupInvalideException e) {
				System.out.print("Impossible ! ");
				if (e.getCoup() > jeu.getNombreAllumettes()) {
					System.out.print("Nombre invalide : " + e.getCoup());
					System.out.println(" (> " + jeu.getNombreAllumettes() + ")");
				} else if (e.getCoup() > Jeu.PRISE_MAX) {
					System.out.print("Nombre invalide : " + e.getCoup());
					System.out.println(" (> " + Jeu.PRISE_MAX + ")");
				} else if (e.getCoup() < 1) {
					System.out.print("Nombre invalide : ");
					System.out.println(e.getCoup() + " (< 1)");
				}

				coupinvalide = true;
			} catch (OperationInterditeException e) {
				System.out.println("[Je triche...]");
				System.out.print("Abandon de la partie car ");
				System.out.println(joueur.getNom() + " triche !");
				tricherie = true;
			}
			if (!coupinvalide) {
				if (joueur.joueurEgal(this.joueur2)) {
					joueur = this.joueur1;
				} else {
					joueur = this.joueur2;
				}
			}
		}
		if (!tricherie) {
			if (joueur.joueurEgal(this.joueur2)) {
				System.out.println(this.joueur1.getNom() + " perd !");
				System.out.println(this.joueur2.getNom() + " gagne !");
			} else {
				System.out.println(this.joueur2.getNom() + " perd !");
				System.out.println(this.joueur1.getNom() + " gagne !");
			}
		}
	}
}

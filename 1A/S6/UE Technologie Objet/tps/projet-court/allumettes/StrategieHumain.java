package allumettes;

import java.util.Scanner;

public class StrategieHumain implements Strategie {

	/** le scanner. */
	private Scanner scanner;

	/** Constructeur de la stratégie huamin.
	 *
	 */
	public StrategieHumain() {
		this.scanner = new Scanner(System.in);
	}

	@Override
	public int getPrise(Jeu jeu) {
		assert (jeu != null);
		assert (jeu.getNombreAllumettes() > 0);
		int nbrAllumettes = 0;
		try {
			nbrAllumettes = Integer.parseInt(this.scanner.nextLine());
		} catch (NumberFormatException e) {
			System.out.println("Vous devez donner un entier.");
			return getPrise(jeu);
		}
		return nbrAllumettes;
	}

	/**
	 * Renvoie la prise du joueur, et redemande au joueur sa prise si sa saisie.
	 * n'est pas valide.
	 *
	 * @param jeu  le jeu
	 * @param nom  le nom du joueur courant de la partie en cours
	 * @param scan le scanner de la partie pour en garder qu'un seul
	 * @return la prise d'allumettes du joueur
	 * @throws CoupInvalideException
	 */
	public static int getPrise(Jeu jeu, String nom, Scanner scan)
		throws CoupInvalideException {
		assert (jeu != null);
		assert (jeu.getNombreAllumettes() > 0);
		int nbrAllumettes = 0;
		try {
			System.out.print(nom + ", combien d'allumettes ? ");
			nbrAllumettes = Integer.parseInt(scan.nextLine());
		} catch (NumberFormatException e) {
			if (e.getMessage().contains("triche")) {
				System.out.print("[Une allumette en moins, plus que ");
				System.out.println((jeu.getNombreAllumettes() - 1) + ". Chut !]");
				jeu.retirer(1);
				return getPrise(jeu, nom, scan);
			} else {
				System.out.println("Vous devez donner un entier.");
				return getPrise(jeu, nom, scan);
			}
		}
		return nbrAllumettes;
	}
}

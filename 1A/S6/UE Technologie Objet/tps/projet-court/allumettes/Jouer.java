package allumettes;

/**
 * Lance une partie des 13 allumettes en fonction des arguments fournis sur la
 * ligne de commande.
 *
 * @author Xavier Crégut
 * @version $Revision: 1.5 $
 */
public class Jouer {
	/** Nombre d'allumettes dans le jeu. */
	private static final int NB_ALLUMETTES_INIT = 13;
	/** Nombre d'arguments de la ligne de commande. */
	private static final int NB_ARGS = 3;

	/**
	 * Lancer une partie. En argument sont donnés les deux joueurs sous la forme.
	 * nom@stratégie.
	 *
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		Joueur joueur1 = null;
		Joueur joueur2 = null;
		Arbitre arbitre = null;
		try {
			verifierNombreArguments(args);
			verifierArguments(args);
			if (args.length == NB_ARGS) {
				joueur1 = joueurInit(args[1]);
				joueur2 = joueurInit(args[2]);
			} else {
				joueur1 = joueurInit(args[0]);
				joueur2 = joueurInit(args[1]);
			}
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}

		Jeu jeu = new JeuSimple(NB_ALLUMETTES_INIT);
		arbitre = new Arbitre(joueur1, joueur2, args[0].equals("-confiant"));
		arbitre.arbitrer(jeu, args[0].equals("-changementStrategie"));
	}

	/**
	 * Vérifie le nombre d'argument de la ligne de commande.
	 *
	 * @param args la ligne de commande
	 */
	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : " + args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : " + args.length);
		}
	}

	/** Vérifie les arguments de la ligne de commande.
	 * Si l'argument n'est pas de la forme : nom@stratégie alors
	 * lève ConfigurationException.
	 * @param args la ligne de commande
	 * @throws ConfigurationException
	 */
	private static void verifierArguments(String[] args)
		throws ConfigurationException {
		//Permet de compter les occurences du caractère '@'
		//dans le cas où il y a 2 arguments.
		int count1 = args[args.length - 2].length()
				- args[args.length - 2].replace("@", "").length();
		//Permet de compter les occurences du caractère '@'
		//dans le cas où il y a 3 arguments.
		int count2 = args[args.length - 1].length()
				- args[args.length - 1].replace("@", "").length();
		if (count1 != 1 || count2 != 1) {
			throw new ConfigurationException("Saisi invalide");
			}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :" + "\n\t"
				+ "java allumettes.Jouer joueur1 joueur2" + "\n\t\t"
				+ "joueur est de la forme nom@stratégie" + "\n\t\t"
				+ "strategie = naif | rapide | expert | humain | tricheur"
				+ " | lent" + "\n" + "\n\t" + "Exemple :" + "\n\t"
				+ "	java allumettes.Jouer Xavier@humain " + "Ordinateur@naif" + "\n");
	}

	/**
	 * Obtenir la stratégie à partir de la saisie au clavier de l'utilisateur.
	 *
	 * @param strategieStr la stratégie demandée par l'utilisateur sous forme de
	 * chaine de caractères
	 * @return la stratégie correspondante
	 * @throws ConfigurationException si la stratégie demandée n'existe pas
	 */
	public static Strategie stringToJoueur(String strategieStr)
		throws ConfigurationException {
		String stratStr = strategieStr.toLowerCase();

		switch (stratStr) {

		case "naif":
			return new StrategieNaif();

		case "humain":
			return new StrategieHumain();

		case "expert":
			return new StrategieExpert();

		case "lent":
			return new StrategieLent();

		case "rapide":
			return new StrategieRapide();

		case "tricheur":
			return new StrategieTricheur();

		default:
			throw new ConfigurationException("Stratégie incorrecte");
		}
	}

	/**
	 * Initialise les joueurs à partir de la ligne de commande.
	 *
	 * @param arguments la ligne de commande (ex : Xavier@humain)
	 * @return le joueur initialisé
	 */
	public static Joueur joueurInit(String arguments) {
		String[] str;
		str = arguments.split("@");
		if (str[0].length() == 0 || str[1].length() == 0) {
			throw new ConfigurationException("Saisie invalide");
		}
		return new Joueur(str[0], stringToJoueur(str[1]));
	}
}

package editeur;

import editeur.commande.*;
import menu.Menu;

/** Un éditeur pour une ligne de texte.  Les commandes de
 * l'éditeur sont accessibles par un menu.
 *
 * @author	Xavier Crégut
 * @version	1.6
 */
public class EditeurLigne {

	/** La ligne de notre éditeur */
	private Ligne ligne;

	/** Le menu principal de l'éditeur */
	private Menu menuPrincipal;
	private Menu sous_menu_curseur;
		// Remarque : Tous les éditeurs ont le même menu mais on
		// ne peut pas en faire un attribut de classe car chaque
		// commande doit manipuler la ligne propre à un éditeur !

	/** Initialiser l'éditeur à partir de la ligne à éditer. */
	public EditeurLigne(Ligne l) {
		ligne = l;

		// Créer le menu principal
		menuPrincipal = new Menu("Menu principal");
		sous_menu_curseur = new Menu("Sous menu curseur");
		menuPrincipal.ajouter("Ajouter un texte en fin de ligne",
					new CommandeAjouterFin(ligne));
		sous_menu_curseur.ajouter("Avancer le curseur d'un caractère",
					new CommandeCurseurAvancer(ligne));
		sous_menu_curseur.ajouter("Reculer le curseur d'un caractère",
					new CommandeCurseurReculer(ligne));
		menuPrincipal.ajouter("Ramener le curseur sur le premier caractère de la ligne",
				new Curseur1Char(ligne));
		menuPrincipal.ajouter("Supprimer le cractère sous le curseur",
				new DelChar(ligne));
	}

	public void editer() {
		do {
			// Afficher la ligne
			System.out.println();
			ligne.afficher();
			System.out.println();

			// Afficher le menu
			menuPrincipal.afficher();
			sous_menu_curseur.afficher();

			// Sélectionner une entrée dans le menu
			menuPrincipal.selectionner();
			sous_menu_curseur.selectionner();
			// Valider l'entrée sélectionnée
			menuPrincipal.valider();
			sous_menu_curseur.valider();
		} while (! menuPrincipal.estQuitte());
	}

}

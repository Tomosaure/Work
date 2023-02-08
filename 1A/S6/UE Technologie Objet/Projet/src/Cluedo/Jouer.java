package Cluedo;

/**
 * Lance une partie de cluedo
 * 
 * @author Agathe Perrin
 * @author Antoine Dalle fratte
 * @author Antonin Litschgy
 * @author Maëlis Marchand
 * @author Mickaël Song
 * @author Thierry Xu
 * @author Tom Bonetto
 * @version $Revision : 1.0 $
 */
public class Jouer {

    public static void main(String[] args) {

        Joueur[] joueurs = new Joueur[6]; //Tableaux des Joueurs, certains sont joués d'autres non
        //TODO Les Joueurs seront à compléter en fonction des choix de l'utilisateur
        joueurs[0] = new Joueur(null, null);
        joueurs[1] = new Joueur(null, null);
        joueurs[2] = new Joueur(null, null);
        joueurs[3] = new Joueur(null, null);
        joueurs[4] = new Joueur(null, null);
        joueurs[5] = new Joueur(null, null);
        Arbitre arbitre = new Arbitre(joueurs);

        arbitre.arbitrer();
    }
}

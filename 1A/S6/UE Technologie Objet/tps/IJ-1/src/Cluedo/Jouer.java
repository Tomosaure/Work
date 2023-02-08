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
 * @version $Revision : 1.3 $
 */
public class Jouer {

    public static void main(String[] args) {

        /* Pour simplifier, on joue avec 3 joueurs : un humain et 2 bots naïfs */
        Joueur[] joueurs = new Joueur[3];
        joueurs[0] = new Joueur("A", 1);
        // LE JOUEUR 1 SERA TOUJOURS LE JOUEUR HUMAIN
        joueurs[1] = new BotNaif("B", 2);
        joueurs[2] = new BotNaif("C", 3);
        //joueurs[3] = new Joueur("D", 4);
        //joueurs[4] = new Joueur("E", 5);
        //joueurs[5] = new Joueur("F", 6);

        MenuPrincipal menu = new MenuPrincipal(joueurs[0]);
        // on passe le joueur humain en paramètre du menu principal pour lui associer le personnage qu'il choisit
        
        Arbitre arbitre = new Arbitre(joueurs);
        
        arbitre.arbitrer();
    }
}

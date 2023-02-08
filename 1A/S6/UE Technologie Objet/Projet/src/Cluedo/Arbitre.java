package Cluedo;

/**
 * Classe permettant de mettre le jeu en place à travers différentes mécaniques.
 */
public class Arbitre {

    Joueur[] joueurs;
    int indiceCourant; // le numéro du joueur courant

    /**
     * Constructeur de la classe arbitre
     * 
     * @param joueurs la liste des joueurs allant jouer la partie
     */
    public Arbitre(Joueur[] joueurs) {
        this.joueurs = joueurs;
        this.indiceCourant = 0;
    }

    /**
     * Obtenir le joueur courant
     * 
     * @return le joueur courant
     */
    public Joueur joueurCourant() {
        return joueurs[indiceCourant];
    }

    /**
     * Passer au joueur suivant
     */
    public void joueurSuivant() {
        indiceCourant = (indiceCourant + 1) % joueurs.length;
    }

    public void arbitrer() {
    }

}
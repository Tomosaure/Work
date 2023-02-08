package Cluedo;

public class Hypothese {

    private Carte personnage;
    private Carte salle;
    private Carte arme;
    // private boolean accusation; /* l'hypothèse est-elle une accusation ? */

    /** Construire une simple hypothèse avec une carte arme, une carte salle et une carte personnage. */
    public Hypothese(Carte personnage, Carte arme, Carte salle) {
        this.personnage = personnage;
        this.arme = arme;
        this.salle = salle;
        // this.accusation = false;
    }

    /** Retourne la carte Arme de l'hypothèse. */
    public Carte getArme() {
        return this.arme;
    }

    /** Retourne la carte Pièce de l'hypothèse. */
    public Carte getSalle() {
        return this.salle;
    }

    /** Retourne la carte Personnage de l'hypothèse. */
    public Carte getPersonnage() {
        return this.personnage;
    }

    public void afficher() {
        System.out.println(personnage.getNom() + " avec ");
        arme.afficher();
        System.out.println(" dans ");
        salle.afficher();
    }

    public Carte getPiece() {
        return null;
    }

}
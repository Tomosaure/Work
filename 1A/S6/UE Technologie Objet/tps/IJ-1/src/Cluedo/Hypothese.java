package Cluedo;

public class Hypothese {

    private Carte personnage;
    private Carte salle;
    private Carte arme;

    /** Construire une simple hypothèse avec une carte arme, une carte salle et une carte personnage. */
    public Hypothese(Carte personnage, Carte arme, Carte salle) {
        this.personnage = personnage;
        this.arme = arme;
        this.salle = salle;
    }

    /** Construire une simple hypothèse avec une carte arme, une carte salle et une carte personnage. */
    public Hypothese(NomCarte nomPersonnage, NomCarte nomArme, NomCarte nomSalle) {
        this.personnage = new Carte(TypeCarte.PERSONNAGE, nomPersonnage);
        this.arme = new Carte(TypeCarte.ARME, nomArme);
        this.salle = new Carte(TypeCarte.SALLE, nomSalle);
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

    /** Définir le Personnage soupçonné dans l'hypothèse. */
    public void setPersonnage(Carte personnage) {
        this.personnage = personnage;
    }

    /** Définir l'arme de l'hypothèse. */
    public void setArme(Carte arme) {
        this.arme = arme;
    }

    /** Définir la salle de l'hypothèse. */
    public void setSalle(Carte salle) {
        this.salle = salle;
    }

    public void afficher() {
        System.out.println(personnage.getNom() + " avec ");
        arme.afficherNom();
        System.out.print(" dans ");
        salle.afficherNom();
    }

    public Carte getPiece() {
        return null;
    }

}
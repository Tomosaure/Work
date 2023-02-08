package Cluedo;

import java.util.ArrayList;

public class Joueur {
    
    private Strategie strategie;
    private String nom;
    private Position position;
    private NomCarte personnage;
    private ArrayList<Carte> main;
    private ArrayList<Carte> cartesVues; /* cartes qui ont été montrées au joueur durant la partie */

    private Carnet carnet; /* carnet de notes du joueur */

    /** Construire un joueur à partir de son nom et sa stratégie. */
    public Joueur(String nom, Strategie strategie) {
        this.nom = nom;
        this.strategie = strategie;
    }

    /** Construire un joueur à partir de son nom, sa stratégie et le personnage choisi. */
    public Joueur(String nom, Strategie strategie, NomCarte nomPersonnage) {
        this(nom, strategie);
        this.personnage = nomPersonnage;
    }

    /** Construire un joueur à partir de son nom et sa position. */
     public Joueur(String nom, Position pos) {
        this.nom = nom;
        this.position = pos;
    }

    /** Retourne le nom du joueur. */
    public String getNom() {
        return this.nom;
    }

    /** Retourne la stratégie du joueur. */
    public Strategie getStrategie() {
        return this.strategie;
    }

    /** Retourne le personnage du joueur. */
    public NomCarte getPersonnage() {
        return this.personnage;
    }

    /** Retourne la main du joueur. */
    public ArrayList<Carte> getMain() {
        return this.main;
    }

    /* Retourne la position du joueur */
    public Position getPos() {
        return this.position;
    }

    /** Modifier le nom du joueur. */
    public void setNom(String nom) {
        this.nom = nom;
    }

    /** Associer au joueur le personnage qu'il a choisi. */
    public void setPersonnage(NomCarte nomPersonnage) {
        this.personnage = nomPersonnage;
    }

    /* Positionner le joueur */
    public void setPos(Position pos) {
        this.position = pos;
    }

    /** Le joueur possède-t-il la carte Arme de l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
     */
    public boolean possedeArme(Hypothese h) {
        return this.main.contains(h.getArme());
    }

    /** Le joueur possède-t-il la carte Salle de l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
     */
    public boolean possedeSalle(Hypothese h) {
        return this.main.contains(h.getSalle());
    }

    /** Le joueur possède-t-il la carte Personnage de l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
     */
    public boolean possedePersonnage(Hypothese h) {
        return this.main.contains(h.getPersonnage());
    }

    /** Le joueur a-t-il vu la carte carte ? */
    public boolean aVu(Carte carte) {
        return this.cartesVues.contains(carte);
    }

    /** Formuler une hypothèse en fonction de sa stratégie. */
    public void formulerHypothese() {
        Hypothese h = this.strategie.formulerHypothese();
        System.out.println("Je soupçonne ");
        h.afficher();
        System.out.println(".");
    }

    /** Formuler une accusation. */
    public void formulerAccusation() {
        Hypothese h = this.strategie.formulerAccusation();
        System.out.println("J'accuse ");
        h.afficher();
        System.out.println(".");
    }

    /** Montrer une carte à partir de l'hypothèse d'un autre joueur. */
    public void montrerCarte(Hypothese hypothese) {
        Carte carte = this.strategie.montrerCarte(hypothese, this);
        if (carte == null) {
            System.out.println("Je ne possède aucune de ces cartes dans mon jeu.");
        } else {
            System.out.println("Je possède la carte : " + carte.getNom() + ".");
        }
    }

    /** Le joueur est-il prêt à formuler une accusation ?
     * Cela se produit si il a trouvé, à coup sûr, les 3 cartes du crime.
     */
    public boolean peutAccuser() {
        for (Carte carte : main) {
            // main à remplacer : le joueur doit regarder dans son carnet
        }
        return true;
    }

    /** Le joueur possède-t-il au moins 2 cartes dans l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
    */
    public boolean aPlusieursCartes(Hypothese h) {
        return (this.main.contains(h.getArme()) && this.main.contains(h.getSalle()))
            || (this.main.contains(h.getArme()) && this.main.contains(h.getPersonnage()))
            || (this.main.contains(h.getPersonnage()) && this.main.contains(h.getSalle()));
    }

}
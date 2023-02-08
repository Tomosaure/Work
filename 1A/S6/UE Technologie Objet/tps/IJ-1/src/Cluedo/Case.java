package Cluedo;

public abstract class Case {
    protected final Position pos;
    public Joueur joueur;
    protected boolean surbrillance = false;

    public Case(Position pos) {
        this.pos = pos;
    }

    /** Ajoute un joueur sur une case
     * 
     * @param j le joueur à ajouter
     */
    public abstract void ajouterJoueur(Joueur j);
    
    /** Enelever le joueur d'une case
     * 
     */
    public void enleverJoueur() {
        this.joueur = null;
    }

    /** Regarder si la case comporte un joueur
     * 
     * @return vrai si la case à un joueur, faux sinon
     */
    public boolean joueurPresent() {
        return this.joueur != null;
    }

    /** Retourner la position de la case
     * 
     * @return la position de la case
     */
    public Position getPos() {
        return this.pos;
    }

    /** Retourner le joueur présent sur la case
     * 
     * @return le joueur présent sur la case
     */
    public Joueur getJoueur() {
        return this.joueur;
    }

    /** Regarder si la case est une porte
     * 
     * @return vrai si c'est une porte, faux sinon
     */
    public boolean estPorte() {
        return this instanceof Porte;
    }

    /** Regarder si la case est une salle
     * 
     * @return vrai si c'est une salle, faux sinon
     */
    public boolean estSalle() {
        return this instanceof Salle;
    }

     /** Regarder si la case est un couloir
     * 
     * @return vrai si c'est une couloir, faux sinon
     */
    public boolean estCouloir() {
        return this instanceof Couloir;
    }
    
    /**
     * Retourne si la case est en surbrillance
     * @return Vrai si la case est en surbrillance
     */
    public boolean estSurbrillant() {
        return surbrillance;
    }

    /**
     * Placer un joueur sur une case.
     * @param nouveauJoueur le joueur à placer
     */
    public void setJoueur(Joueur nouveauJoueur) {
        this.joueur = nouveauJoueur;
    }
}

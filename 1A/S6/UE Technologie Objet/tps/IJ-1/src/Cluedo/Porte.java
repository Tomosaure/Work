package Cluedo;

public class Porte extends Case {
    
    private Salles salle;

    public Porte(Position pos) {
        super(pos);   
    }

    public Porte(Position pos, Salles salle) {
        super(pos); 
        this.salle = salle;

    }
    public void ajouterJoueur(Joueur j) {
            this.joueur = j;
    
    }
    
    /** Retourner la salle à laquelle appartient la porte.
     * 
     * @return la salle de la porte
     */
    public Salles getSalle() {
        return this.salle;
    }
    
}

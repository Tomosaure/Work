package Cluedo;

import java.util.ArrayList;

public class Salle extends Case {

    private Salles nom;
    private ArrayList<Salle> placeJoueur = new ArrayList<>();

    public Salle(Position pos) {
        super(pos);
    }

    public Salle(Position pos, Salles nomSalle) {
        super(pos);
        this.nom = nomSalle;
    }

    /** Ajouter un joueur dans une place de la salle
     * 
     * @param joueur le joueur à ajouter dans la salle
     */
    public void ajouterJoueur(Joueur joueur) {
        for (Salle salle : placeJoueur) {
            if (!salle.joueurPresent()) {
                salle.setJoueur(joueur);
                joueur.setPos(salle.getPos());
                break;
            }
        }
    }

    /** Allouer une zone de 3x2 dans une salle pour y placer les joueurs.
     * 
     * @param p le plateau de jeu
     * @param x l'abscisse du début de la zone à allouer
     * @param y l'ordonnée du début de la zone à allouer
     */
    public void setPlaceJoueur(Plateau p, int x, int y) {
        for (int i = x; i < x+3; i++){
            for (int k = y; k < y+2; k++){
                placeJoueur.add((Salle) (p.getCase(new Position(i, k))));
            }
        }
    }
    
    /** Retourner le nom de la salle.
     * 
     * @return le nom de la salle
     */
    public Salles getNomSalle() {
        return nom;
    }

    public void setJoueur(Joueur joueur) {
        this.joueur = joueur;
    }

}

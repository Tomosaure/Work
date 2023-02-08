package Cluedo;

public class CaseCarnet {

    private Joueur joueur; // colonne = numéro du joueur
    private Carte carte; // ligne = carte

    public CaseCarnet(Joueur joueur, Carte carte) {
        this.joueur = joueur;
        this.carte = carte;
    }
    
}

package Cluedo;

public class Carnet {

    // tableau de cases
    private Symbole[][] carnet;

    /**
     * La grille de cases est construite tous les symboles valent VIDE
     * 
     * @param nbLignes   le nombre de lignes dans la grille
     * @param nbColonnes le nombre de colonnes dans la grille
     */
    public Carnet(int nbLignes, int nbColonnes) {
        this.carnet = new Symbole[nbLignes][nbColonnes];
        for (int i = 0; i < nbLignes; i++) {
            for (int j = 0; j < nbColonnes; j++) {
                this.carnet[i][j] = Symbole.VIDE;
            }
        }
    }
    

    /**
     * Permet de mettre un symbole dans une case
     * 
     * @param indiceLigne   le numéro de ligne de la case
     * @param indiceColonne le numéro de colonne de la case
     * @param symbole       le symbole à stocker
     */
    public void cocherCase(int indiceLigne, int indiceColonne, Symbole symbole) {
        this.carnet[indiceLigne][indiceColonne] = symbole;
    }

    /**
     * Permet de transformer le symbole d'une case en son élément suivant
     * 
     * @param indiceLigne
     * @param indiceColonne
     */
    public void symboleSuivant(int indiceLigne, int indiceColonne) {
        cocherCase(indiceLigne, indiceColonne, getCase(indiceLigne, indiceColonne).next());
    }

    /**
     * Permet d'obtenir le symbole stocké dans une case de la grille
     * 
     * @param indiceLigne   le numéro de ligne de la case
     * @param indiceColonne le numéro de colonne de la case
     * @return le symbole stocké dans cette case
     */
    public Symbole getCase(int indiceLigne, int indiceColonne) {
        return this.carnet[indiceLigne][indiceColonne];
    }

    /**
     * Vide une case de la grille de ses symboles
     * 
     * @param indiceLigne   le numéro de ligne de la case à vider
     * @param indiceColonne le numéro de colonne de la case à vider
     */
    public void viderCase(int indiceLigne, int indiceColonne) {
        this.cocherCase(indiceLigne, indiceColonne, Symbole.VIDE);
    }

    /**
     * Vider une ligne de tous ses symboles
     * 
     * @param indiceLigne l'indice de la ligne à vider
     */
    public void viderLigne(int indiceLigne) {
        for (int indiceColonne = 0; indiceColonne < carnet[indiceLigne].length; indiceColonne++) {
            viderCase(indiceLigne, indiceColonne);
        }
    }

    /**
     * Vider une colonne de tous ses symboles
     * 
     * @param indiceColonne l'indice de la colonne à vider
     */
    public void viderColonne(int indiceColonne) {
        for (int indiceLigne = 0; indiceLigne < carnet.length; indiceLigne++) {
            viderCase(indiceLigne, indiceColonne);
        }
    }

    /**
     * Vider la grille de tous ses symboles
     */
    public void vider() {
        for (int indiceLigne = 0; indiceLigne < carnet.length; indiceLigne++) {
            viderLigne(indiceLigne);
        }
    }
}

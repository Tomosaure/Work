package Cluedo;

public class Carnet {

    // tableau de cases
    private Symbole[][] carnet;
    //private static int indicePersos = 5;

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

    /** La case d'indice (i,j) est-elle vide ?
     * @param i l'indice de la ligne
     * @param j l'indice de la colonne
     */
    public boolean caseVide(int i, int j) {
        return (this.carnet[i][j] == Symbole.VIDE);
    }

    /** La ligne d'indice indiceLigne est-elle vide ?
     * @param indiceLigne l'indice de la ligne
     */
    public boolean ligneVide(int indiceLigne) {
        for (int indiceColonne = 0; indiceColonne < carnet[indiceLigne].length; indiceColonne++) {
            if (! caseVide(indiceLigne, indiceColonne)) {
                return false;
            }
        }
        return true;
    }

    /** Combien de lignes sont vides entre l'indice i1 et l'indice i2 inclus ?
    */
    public int nbLignesVides(int i1, int i2) {
        int compteur = 0;
        for (int i = i1; i <= i2; i++) {
            if (ligneVide(i)) {
                compteur++;
            }
        }
        return compteur;
    }

    /** Quel est l'indice de la ligne vide entre i1 et i2 ? */
    public int indiceLigneVide(int i1, int i2) {
        int indice=0;
        for (int i = i1; i <= i2; i++) {
            if (ligneVide(i)) {
                indice = i;
            }
        }
        return indice;
    }

    /** Quelle carte n'a pas été vue entre les lignes d'indice i1 et i2 ?
     * @return le nom de la carte s'il n'y en a qu'une seule, null sinon
     */
    public NomCarte carteNonVue(int i1, int i2) {
        NomCarte carte = null;
        int compteur = nbLignesVides(i1, i2);
        if (compteur == 1) {
            int indice = indiceLigneVide(i1, i2);
            carte = NomCarte.values()[indice];
        }
        return carte;
    }

}

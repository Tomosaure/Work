package Cluedo;
import javax.swing.*;

public class Carte {

    private TypeCarte type;
    private NomCarte nom;
    private ImageIcon image;

    /** Construire une carte à partir de son type et son nom.
        Exemple : la carte PERSONNAGE - Mme Pervenche. */
    public Carte(TypeCarte type, NomCarte nom) {
        this.type = type;
        this.nom = nom;
    }

    /** Construire une carte à partir de son type, son nom et son visuel.
        Exemple : la carte PERSONNAGE - Mme Pervenche. */
    public Carte(TypeCarte type, NomCarte nom, ImageIcon img) {
        this(type, nom);
        this.image = img;
    }

    /** Construire une carte Personnage à partir d'un personnage. */
    public Carte(Personnage personnage) {
        this(TypeCarte.PERSONNAGE, personnage.getNom(), personnage.getImage());
    }

    /** Retourne le nom de la carte sous forme de String (exemple : "REVOLVER"). */
    public String getNom() {
        return this.nom.name();
    }

    /** Retourne le nom de la carte sous forme de NomCarte (exemple : NomCarte.CORDE). */
    public NomCarte getNomCarte() {
        return this.nom;
    }

    /** Retourne le type de la carte (ARME, PIECE ou PERSONNAGE). */
    public TypeCarte getType() {
        return this.type;
    }

    /** Retourne l'image de la carte. */
    public ImageIcon getImage() {
        return this.image;
    }

    public void setNom(NomCarte nom) {
        this.nom = nom;
    }

    public void setType(TypeCarte type) {
        this.type = type;
    }

    /** Afficher le nom d'une carte. */
    public void afficherNom() {
        System.out.print(this.determinant() + this.nom); // exemple : "le salon"
    }

    /** Afficher une carte. */
    public void afficher() {
        // afficher l'image
    }

    /** Retourne le bon déterminant pour le nom de la carte. */
    public String determinant() { // exemple : "le" pour salon
        switch (this.nom.name()) {
            case "CHANDELIER":
            case "REVOLVER":
            case "POIGNARD":
            case "HALL":
            case "GRAND_SALON":
            case "BUREAU":
            case "PETIT_SALON":
                return "le ";
            case "CLE_ANGLAISE":
            case "BARRE_DE_FER":
            case "CORDE":
            case "CUISINE":
            case "SALLE_A_MANGER":
            case "BIBLIOTHEQUE":
            case "SALLE_DE_BILLARD":
            case "VERANDA":
                return "la ";
            default: // pour les personnages, pas de déterminant
                return "";
        }
    }

    /** Indice de la ligne de la carte dans le carnet de jeu. */
    public int indiceLigneCarnet() {
        return this.nom.ordinal();
    }

}
package Cluedo;

public class Carte {

    private TypeCarte type;
    private NomCarte nom;

    /** Construire une carte à partir de son type et de son nom.
        Exemple : la carte PERSONNAGE - Mme Pervenche. */
    public Carte(TypeCarte type, NomCarte nom) {
        this.type = type;
        this.nom = nom;
    }

    /** Retourne le nom de la carte (exemple : REVOLVER). */
    public NomCarte getNom() {
        return this.nom;
    }

    /** Retourne le type de la carte (ARME, PIECE ou PERSONNAGE). */
    public TypeCarte getType() {
        return this.type;
    }

    public void setNom(NomCarte nom) {
        this.nom = nom;
    }

    public void setType(TypeCarte type) {
        this.type = type;
    }

    /** Afficher le nom d'une carte. */
    public void afficher() {
        System.out.println(this.determinant() + this.nom); // exemple : "le salon"
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

}
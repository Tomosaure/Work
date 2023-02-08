package Cluedo;

import java.util.ArrayList;

public class MiseEnPlace {

    private Carte armeCrime;
    private Carte personnageCrime;
    private Carte salleCrime;

    private void setArme(NomCarte nom) {
        this.armeCrime.setType(TypeCarte.ARME);
        this.armeCrime.setNom(nom);
    }

    private void setPersonnage(NomCarte nom) {
        this.personnageCrime.setType(TypeCarte.PERSONNAGE);
        this.personnageCrime.setNom(nom);
    }

    private void setSalle(NomCarte nom) {
        this.salleCrime.setType(TypeCarte.SALLE);
        this.salleCrime.setNom(nom);
    }

    /*
     * Création du paquet de cartes en retirant les cartes d'indices nombre1,
     * nombre2, nombre3
     */
    public ArrayList<Carte> creationPaquet(int nombre1, int nombre2, int nombre3) {
        ArrayList<Carte> paquet = new ArrayList<Carte>();
        Carte carte;
        for (int i = 0; i < 21; i++) {
            /*
             * On ajoute la carte d'indice i au paquet si i est différent de nombre1,
             * nombre2, nombre3
             */
            if (i != nombre1 && i != nombre2 && i != nombre3) {
                /* On ajoute la carte au paquet */
                if (i <= 5) {
                    carte = new Carte(TypeCarte.ARME, NomCarte.values()[i]);
                } else if (i <= 11) {
                    carte = new Carte(TypeCarte.PERSONNAGE, NomCarte.values()[i]);
                } else {
                    carte = new Carte(TypeCarte.SALLE, NomCarte.values()[i]);
                }
                paquet.add(carte);
            }
        }
        return paquet;
    }

    /* On tire au sort une carte de chaque type (arme, personnage, salle) */
    public void tirageCrime() {

        /* Tirage de l'arme parmi les 6 existantes */
        int nombre1 = (int) (Math.random() * 6);
        this.setArme(NomCarte.values()[nombre1]);

        /* Tirage du personnage parmi les 6 existants */
        int nombre2 = (int) (Math.random() * 6);
        this.setPersonnage(NomCarte.values()[nombre2 + 6]);

        /* Tirage de la salle parmi les 9 existantes */
        int nombre3 = (int) (Math.random() * 9);
        this.setSalle(NomCarte.values()[nombre3 + 6 + 6]);

        /* Paquet trié par catégories */
        ArrayList<Carte> paquet = creationPaquet(nombre1, nombre2, nombre3);

        /* Mélanger le paquet */
    }

}

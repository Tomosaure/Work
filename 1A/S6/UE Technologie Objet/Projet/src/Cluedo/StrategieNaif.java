package Cluedo;

public class StrategieNaif implements Strategie {

    /** Formuler une hypothèse avec 3 cartes choisies au hasard. */
    public Hypothese formulerHypothese() {
        /* Choix de la carte Arme au hasard */
        int nombre1 = (int) (Math.random() * 6 );
        Carte arme =new Carte(TypeCarte.ARME, NomCarte.values()[nombre1]);
        /* Choix de la carte Personnage au hasard */
        int nombre2 = (int) (Math.random() * 6 );
        Carte personnage = new Carte(TypeCarte.PERSONNAGE, NomCarte.values()[nombre2 + 6]);
        /* Choix de la carte Salle au hasard */
        int nombre3 = (int) (Math.random() * 9 );
        Carte salle = new Carte(TypeCarte.SALLE, NomCarte.values()[nombre3 + 6 + 6]);
        return new Hypothese(personnage, arme, salle);
    }

    /** Montrer une carte au hasard. */
    public Carte montrerCarte(Hypothese hypothese, Joueur joueur) {
        
        Carte carteMontree = null;
        Carte arme = hypothese.getArme();
        Carte salle = hypothese.getSalle();
        Carte perso = hypothese.getPersonnage();
        int n = (int) (Math.random() * 3 );

        if (n==1) {
            carteMontree = montrer(arme, perso, salle, joueur); // on regarde en priorité l'arme, puis le perso, puis la salle
        } else if (n==2) {
            carteMontree = montrer(perso, salle, arme, joueur);
        } else {
            carteMontree = montrer(salle, arme, perso, joueur);
        }
        return null;
    }

    public Carte montrer(Carte c1, Carte c2, Carte c3, Joueur joueur) {
        Carte carte = null;
        if (joueur.getMain().contains(c1)) {
            carte = c1;
        } else if (joueur.getMain().contains(c2)) {
            carte = c2;
        } else if (joueur.getMain().contains(c3)) {
            carte = c3;
        } else {
            // rien
        }
        return carte;
    }

    /** Formuler une accusation quand on peut accuser, i.e quand on est sûr à 100% des 3 cartes du crime. */
    public Hypothese formulerAccusation() {
        return null; // utiliser le Carnet
    }
    
}

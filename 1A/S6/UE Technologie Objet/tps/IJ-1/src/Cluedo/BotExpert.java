package Cluedo;

import java.io.FileNotFoundException;

/** Bot adoptant la stratégie experte. */
public class BotExpert extends Joueur {

    // A REVOIR mais pas une priorité

    /** Construire un bot expert à partir de son personnage. */
    public BotExpert(NomCarte personnage) {
        super(personnage.name());
    }
    
    public Carte montrerCarte(Hypothese hypothese, Joueur joueurHyp) {
        Carte aMontrer = montrerCarteVue(hypothese, joueurHyp);
        if (aMontrer == null) {
            aMontrer = super.montrerCarte(hypothese);
        }
        return aMontrer;
    }

    /** Si le joueur qui formule l'hypothèse a déjà vu une des cartes du joueur,
     * ce dernier lui montre cette carte pour lui faire perdre un tour.
     * @param hypothese l'hypothèse formulée par un autre joueur
     * @param autre le joueur qui a formulé l'hypothèse
     */
    public Carte montrerCarteVue(Hypothese hypothese, Joueur autre) {
        Carte arme = hypothese.getArme();
        Carte salle = hypothese.getSalle();
        Carte perso = hypothese.getPersonnage();
        if (possedeArme(hypothese) && autre.aVu(arme)) {
            return arme;
        } else if (possedePersonnage(hypothese) && autre.aVu(perso)) {
            return perso;
        } else if (possedeSalle(hypothese) && autre.aVu(salle)) {
            return salle;
        } else {
            return null;
        }
    }

    @Override
    public Hypothese formulerAccusation() {
        return null;
    }

    /** Le joueur a-t-il vu la carte 'carte' ? */
    public boolean aVu(Carte carte) {
        int i = carte.indiceLigneCarnet();
        return !this.getCarnet().ligneVide(i);
        // si la ligne n'est pas vide, c'est que le joueur a vu la carte chez quelqu'un
    }

    /** Se déplacer sur le plateau de jeu en fonction de son score aux dés. */
    public Position seDeplacer(Position arrivee, int scoreDe, Plateau plateau) throws FileNotFoundException {
        return PathFinder.chemin(this.position, arrivee, scoreDe, plateau);
    }

    public Position trouverDestination(Position pos, Plateau plateau, Salle salle) throws FileNotFoundException {
        return PathFinder.trouverSalle(this.getPos(), plateau, this.getSalle());
    }

}

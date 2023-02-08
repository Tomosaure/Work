package Cluedo;

public class StrategieHumain implements Strategie {
    
    @Override
    public Hypothese formulerHypothese() {
        return null;
    }

    @Override
    // je vais surement changer ça
    public Carte montrerCarte(Hypothese hypothese, Joueur joueur, Joueur joueurHyp) {
        if (joueur.aPlusieursCartes(hypothese)) {
            return montrerCarteVue(hypothese, joueur, joueurHyp);
        } else {
            return montrerCarteBasique(hypothese, joueur);
        }
    }

    /** Si le joueur qui formule l'hypothèse (joueurHyp) a déjà vu une des cartes du joueur,
     * ce dernier lui montre cette carte pour lui faire perdre un tour.
     */
    public Carte montrerCarteVue(Hypothese hypothese, Joueur joueur, Joueur joueurHyp) {
        if (joueur.possedeArme(hypothese) && true) {
            return hypothese.getArme();
        } else if (joueur.possedePersonnage(hypothese) && true) {
            return hypothese.getPersonnage();
        } else {
            return hypothese.getSalle();
        }
    }

    public Carte montrerCarteBasique(Hypothese hypothese, Joueur joueur) {
        Carte carte = null;
        if (joueur.getMain().contains(hypothese.getArme())) {
            carte = hypothese.getArme();
        } else if (joueur.getMain().contains(hypothese.getPersonnage())) {
            carte = hypothese.getPersonnage();
        } else if (joueur.getMain().contains(hypothese.getPiece())) {
            carte = hypothese.getPiece();
        } else {
            // rien
        }
        return carte;
    }

    @Override
    public Hypothese formulerAccusation() {
        return null;
    }

}

package Cluedo;

import java.io.FileNotFoundException;
import java.nio.file.Path;

// objectif : bot naïf qui marche

/** Bot adoptant la stratégie naïve. */
public class BotNaif extends Joueur {

    /** Construire un bot naïf avec son nom et son numéro */
    public BotNaif(String nom, int numero) {
        super(nom, numero);
    }

    /** Construire un bot naïf à partir de son personnage. */
    public BotNaif(NomCarte personnage) {
        super(personnage.name());
    }

    @Override
    /** Formuler une hypothèse avec 3 cartes choisies au hasard. */
    public Hypothese formulerHypothese() {
        /* Choix de la carte Arme au hasard */
        int n = (int) (Math.random() * 6 );
        Carte arme =new Carte(TypeCarte.ARME, NomCarte.values()[n]);
        /* Choix de la carte Personnage au hasard */
        n = (int) (Math.random() * 6 );
        Carte personnage = new Carte(TypeCarte.PERSONNAGE, NomCarte.values()[n + 6]);
        /* Choix de la carte Salle au hasard */
        n = (int) (Math.random() * 9 );
        Carte salle = new Carte(TypeCarte.SALLE, NomCarte.values()[n + 6 + 6]);
        return new Hypothese(personnage, arme, salle);
    }

    @Override
    /** Montrer une carte au hasard.
     * Le bot regarde d'abord s'il possède la salle, puis le personnage, puis l'arme.
     * @param hypothese l'hypothèse formulée par un autre joueur
     * @return une carte de l'hypothèse si le bot en possède une, null sinon
    */
    public Carte montrerCarte(Hypothese hypothese) {
        
        if (possedeSalle(hypothese)) {
            return hypothese.getSalle();
        } else if (possedePersonnage(hypothese)) {
            return hypothese.getPersonnage();
        } else if (possedeArme(hypothese)) {
            return hypothese.getArme();
        } else {
            // le joueur ne possède pas de carte de l'hypothèse
            return null;
        }
        
    }

    /** Le joueur peut accuser quand il est sûr à 100% des 3 cartes du crime.
     * @return Le joueur peut-il accuser ?
     */
    public boolean peutAccuser() {
        NomCarte personnage = this.getCarnet().carteNonVue(0, 5);
        NomCarte arme = this.getCarnet().carteNonVue(6, 11);
        NomCarte salle = this.getCarnet().carteNonVue(12, 20);
        return (personnage != null && arme != null && salle != null);
    }

    @Override
    /** Formuler une accusation quand on peut accuser. */
    public Hypothese formulerAccusation() {
        if (peutAccuser()) {
            NomCarte personnage = this.getCarnet().carteNonVue(0, 5);
            NomCarte arme = this.getCarnet().carteNonVue(6, 11);
            NomCarte salle = this.getCarnet().carteNonVue(12, 20);
            Hypothese accusation = new Hypothese(personnage, arme, salle);
            return accusation;
        } else {
            return null;
        }
        
    }

    /** Cocher une carte montrée par un autre joueur
     * @param carteMontree la carte montrée au bot
     * @param joueur le joueur qui a montré la carte au bot
     */
    public void cocher(Carte carteMontree, Joueur joueur) {
        int x = carteMontree.indiceLigneCarnet();
        int y = joueur.indiceColonneCarnet();
        if (!this.getCarnet().caseVide(x,y)) {
            this.getCarnet().cocherCase(x, y, Symbole.CROIX); // on coche la case dans la colonne du joueur
            this.getCarnet().cocherCase(x, 1, Symbole.CROIX); // et aussi dans la 1ère colonne
        }
    }


    /** Se déplacer sur le plateau de jeu en fonction de son score aux dés. */
    public Position seDeplacer(Position arrivee, int scoreDe, Plateau plateau) throws FileNotFoundException {
        return PathFinder.chemin(this.position, arrivee, scoreDe, plateau);
    }

    public Position trouverDestination(Position pos, Plateau plateau, Salle salle) throws FileNotFoundException {
        return PathFinder.trouverSalle(this.getPos(), plateau, this.getSalle());
    }

}

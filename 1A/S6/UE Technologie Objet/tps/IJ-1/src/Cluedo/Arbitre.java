package Cluedo;

import java.util.Collections;
import java.util.ArrayList;
import java.util.Iterator;
import java.io.IOException;

/**
 * Classe permettant de mettre le jeu en place à travers différentes mécaniques.
 */
public class Arbitre {

    Joueur[] joueurs;
    int indiceCourant; // le numéro du joueur courant
    Jeu jeu;

    /**
     * Constructeur de la classe arbitre
     * 
     * @param joueurs la liste des joueurs allant jouer la partie
     */
    public Arbitre(Joueur[] joueurs) {
        this.joueurs = joueurs;
        this.indiceCourant = 0;
        try  {
            this.jeu = new Jeu();
        } catch (IOException e) {

        }
    }

    /**
     * Obtenir le joueur courant
     * 
     * @return le joueur courant
     */
    public Joueur joueurCourant() { 
        return joueurs[indiceCourant]; 
    }

    /**
     * Passer au joueur suivant
     */
    public void joueurSuivant() {
        indiceCourant = (indiceCourant + 1) % joueurs.length;
    }

    /** Retirer les 3 cartes du crime au jeu */
    public void retirerCartesCrime(Jeu jeu, TirageCrime tirage) {
        ArrayList<Carte> paquet = jeu.getCartes();
        paquet.remove(tirage.getPerso());
        paquet.remove(tirage.getArme());
        paquet.remove(tirage.getSalle());
    }

    /** Distribuer le reste des cartes aux joueurs */
    public void distribuerCartes() {

        ArrayList<Carte> paquet = jeu.getCartes();
        /* Mélanger le paquet */
        Collections.shuffle(paquet);

        Iterator<Carte> itr = paquet.iterator();
        int i=0;
        while (itr.hasNext()) {
            if (i == this.joueurs.length) {
                i=0;
            }
            Carte c = itr.next();
            System.out.println(c.getNomCarte() + " donnée au joueur " + (i+1));
            this.joueurs[i].ajouterCarte(c);
            i++;
        }

    }

    public void arbitrer() {
        /* Tirage du crime */
        TirageCrime tirage = new TirageCrime(this.jeu);
        /* Retirer du paquet de cartes les 3 cartes du crime */
        retirerCartesCrime(this.jeu, tirage);
        /* Distribuer le reste des cartes aux joueurs */
        System.out.println("Distribution des cartes : ");
        distribuerCartes();

        /**   TODO Faire jouer les joueurs un par un
            * Demander le déplacement (pour un bot)
            * Vérifier le déplacement
            * Déplacer le joueur
            * Réafficher le plateau
            * Demander l'hypothèse
            * Fournir la réponse
            * Demander l'accusation (éventuellement NULL)
            */
    }

}
package Cluedo;

import java.util.ArrayList;
import java.util.Random;
import java.io.IOException;

public class TirageCrime {

    private Jeu jeu;
    private Carte perso; /* personnage du crime */
    private Carte arme; /* arme du crime */
    private Carte salle; /* salle du crime */

    public TirageCrime(Jeu jeu) {
        
        this.jeu = jeu;

        ArrayList<Carte> paquetPersos = jeu.getCartesPerso();
        ArrayList<Carte> paquetArmes = jeu.getCartesArme();
        ArrayList<Carte> paquetSalles = jeu.getCartesSalle();

        /** Tirage du personnage du crime */
        this.perso = paquetPersos.get(new Random().nextInt(paquetPersos.size()));
        /** Tirage de l'arme du crime */
        this.arme = paquetArmes.get(new Random().nextInt(paquetArmes.size()));
        /** Tirage de la salle du crime */
        this.salle = paquetSalles.get(new Random().nextInt(paquetArmes.size()));

    }

    public Carte getPerso() {
        return this.perso;
    }

    public Carte getArme() {
        return this.arme;
    }

    public Carte getSalle() {
        return this.salle;
    }

}
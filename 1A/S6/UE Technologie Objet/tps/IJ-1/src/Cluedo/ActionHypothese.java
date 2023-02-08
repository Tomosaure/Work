package Cluedo;

import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.imageio.*;

/* Action qui se produit lorsque le joueur humain clique sur "Formuler une hypothèse" */
public class ActionHypothese implements ActionListener {

    private Jeu jeu;
    private Hypothese hypothese; /* l'hypothèse formulée */

    private ArrayList<BoutonCarte> boutonsPerso = new ArrayList<BoutonCarte>();
    private ArrayList<BoutonCarte> boutonsArme = new ArrayList<BoutonCarte>();
    private ArrayList<BoutonCarte> boutonsSalle = new ArrayList<BoutonCarte>();

    public ActionHypothese(Jeu jeu) {

        this.jeu = jeu; // pour récupérer les cartes du jeu
        this.hypothese = new Hypothese(NomCarte.OLIVE, NomCarte.REVOLVER, NomCarte.CUISINE);

        for (Carte c : jeu.getCartesPerso()) {
            boutonsPerso.add(new BoutonCarte(c, c.getImage()));
        }
        for (Carte c : jeu.getCartesArme()) {
            boutonsArme.add(new BoutonCarte(c, c.getImage()));
        }
        for (Carte c : jeu.getCartesSalle()) {
            boutonsSalle.add(new BoutonCarte(c, c.getImage()));
        }

        /* Récupérer le personnage soupçonné */
        for (BoutonCarte b : boutonsPerso) {
            b.addActionListener(e -> {
                Carte perso = jeu.lePersonnage(b.getCarte().getNomCarte());
                hypothese.setPersonnage(perso);
             });
        }

        /* Récupérer l'arme soupçonnée */
        for (BoutonCarte b : boutonsArme) {
            b.addActionListener(e -> {
                Carte arme = jeu.lArme(b.getCarte().getNomCarte());
                hypothese.setArme(arme);
             });
        }

        /* Récupérer la salle soupçonnée */
        for (BoutonCarte b : boutonsSalle) {
            b.addActionListener(e -> {
                Carte salle = jeu.laSalle(b.getCarte().getNomCarte());
                hypothese.setSalle(salle);
             });
        }

    }

    public JFrame afficherChoix(ArrayList<BoutonCarte> boutons) {
        JFrame fenetre = new JFrame("Choix"); // fenêtre
        Container conteneur = fenetre.getContentPane(); // conteneur associé
        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // se fermer lors du clic sur la croix

        // dimensionner la fenêtre à la taille de l'écran
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        fenetre.setSize(screenSize.width, screenSize.height);

        fenetre.setVisible(true);
        conteneur.setLayout(new FlowLayout());
        for (BoutonCarte b : boutons) {
            conteneur.add(b);
        }
        return fenetre;
    }

    public void afficherPersos() {
        JFrame fenetrePersos = afficherChoix(boutonsPerso);
        for (BoutonCarte b : boutonsPerso) {
            b.addActionListener(e -> {
                fenetrePersos.dispose();
                afficherArmes();
             });
        }
    }

    public void afficherArmes() {
        JFrame fenetreArmes = afficherChoix(boutonsArme);
        for (BoutonCarte b : boutonsArme) {
            b.addActionListener(e -> {
                fenetreArmes.dispose();
                afficherSalles();
             });
        }
    }

    public void afficherSalles() {
        JFrame fenetreSalles = afficherChoix(boutonsSalle);
        for (BoutonCarte b : boutonsSalle) {
            b.addActionListener(e -> {
                fenetreSalles.dispose();
             });
        }
    }

    @Override
    public void actionPerformed(ActionEvent action) {

        afficherPersos();
        
    }

    /* Renvoie l'hypothèse formulée par le joueur.
        (utilisée par l'arbitre) */
    public Hypothese getHypothese() {
        return this.hypothese;
    }

    
}

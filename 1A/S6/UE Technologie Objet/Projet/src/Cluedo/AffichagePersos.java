package Cluedo;

import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.imageio.*;

/* Interface qui invite le joueur à choisir son personnage pour la partie */
// TODO : ACTIONS DES BOUTONS -> créer un joueur avec ce perso

public class AffichagePersos { // ChoixPersonnage ?

    /* Constructeur */
    public AffichagePersos() {

        JFrame fenetre = new JFrame("Choix du personnage"); // fenêtre
        JPanel conteneur = new JPanel(); // conteneur associé
        fenetre.add(conteneur);

        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // se fermer lors du clic sur la croix
        fenetre.setLocationRelativeTo(null); // la fenêtre est placée au centre de l'écran
        fenetre.setSize(300,300);
        fenetre.setVisible(true);

        conteneur.setLayout(new GridLayout(2, 3));
        //conteneur.setLayout(new FlowLayout());

        /* Images des personnages */
        ImageIcon pervenche = new ImageIcon("src/Ressources/Image/Persos/pervenche.png");
        ImageIcon rose = new ImageIcon("src/Ressources/Image/Persos/rose.png");
        ImageIcon moutarde = new ImageIcon("src/Ressources/Image/Persos/moutarde.png");
        ImageIcon olive = new ImageIcon("src/Ressources/Image/Persos/olive.png");
        ImageIcon violet = new ImageIcon("src/Ressources/Image/Persos/violet.png");
        ImageIcon orchidee = new ImageIcon("src/Ressources/Image/Persos/orchidee.png");

        /* Création des boutons avec nom des personnages + images */
        JButton boutonPervenche = creerBouton("Madame Pervenche", pervenche);
        JButton boutonRose = creerBouton("Mademoiselle Rose", rose);
        JButton boutonMoutarde = creerBouton("Colonel Moutarde", moutarde);
        JButton boutonOlive = creerBouton("Monsieur Olive", olive);
        JButton boutonViolet = creerBouton("Professeur Violet", violet);
        JButton boutonOrchidee = creerBouton("Docteur Orchidée", orchidee);

        /* Ajout des boutons au panneau */
        conteneur.add(boutonPervenche);
        conteneur.add(boutonRose);
        conteneur.add(boutonMoutarde);
        conteneur.add(boutonOlive);
        conteneur.add(boutonViolet);
        conteneur.add(boutonOrchidee);

        /* Programmation des actions qui se produisent quand on clique sur un bouton */
        boutonPervenche.addActionListener(new ActionPervenche());
        boutonRose.addActionListener(new ActionRose());
        boutonMoutarde.addActionListener(new ActionMoutarde());
        boutonOlive.addActionListener(new ActionOlive());
        boutonViolet.addActionListener(new ActionViolet());
        boutonOrchidee.addActionListener(new ActionOrchidee());

    }

    public JButton creerBouton(String nom, ImageIcon img) {
        JButton bouton = new JButton(nom, img);
        bouton.setVerticalTextPosition(SwingConstants.TOP);
        bouton.setHorizontalTextPosition(SwingConstants.CENTER);
        return bouton;
    }

    // Pour l'instant, les actions exécutées sont des print pour tester
    // TODO à changer
    private class ActionMoutarde implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            System.out.println("Moutarde");
        }
    }

    private class ActionRose implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            System.out.println("Rose");
        }
    }

    private class ActionPervenche implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            System.out.println("Pervenche");
        }
    }

    private class ActionOrchidee implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            System.out.println("Orchidée");
        }
    }

    private class ActionOlive implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            System.out.println("Olive");
        }
    }

    private class ActionViolet implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            System.out.println("Violet");
        }
    }
    
    // à mettre dans le programme principal
    // il faudra probablement remplacer JFrame par Jwindow
    public static void main(String[] args) {
        AffichagePersos frame = new AffichagePersos();
    }

}

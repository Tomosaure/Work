package Cluedo;

import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.imageio.*;
import javax.sound.sampled.Clip;

/* Interface qui invite le joueur à choisir son personnage pour la partie */

public class ChoixPersonnage {

    private Joueur joueurHumain;
    private Clip clip;

    /* Constructeur */
    public ChoixPersonnage(Joueur joueur, Clip clip) {

        this.joueurHumain = joueur;
        this.clip = clip;
        JFrame fenetre = new JFrame("Choix du personnage"); // fenêtre
        JPanel conteneur = new JPanel(); // conteneur associé
        fenetre.add(conteneur);

        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // se fermer lors du clic sur la croix
        fenetre.setLocationRelativeTo(null); // la fenêtre est placée au centre de l'écran
        fenetre.setExtendedState(JFrame.MAXIMIZED_BOTH); 

        fenetre.setResizable(true);
        fenetre.setVisible(true);
        fenetre.setLocationRelativeTo(null);

        conteneur.setLayout(new GridLayout(2, 3));
        //conteneur.setLayout(new FlowLayout());

        /* Images des personnages */
        ImageIcon pervenche = new ImageIcon("../src/Ressources/Image/Persos/pervenche.png");
        ImageIcon rose = new ImageIcon("../src/Ressources/Image/Persos/rose.png");
        ImageIcon moutarde = new ImageIcon("../src/Ressources/Image/Persos/moutarde.png");
        ImageIcon olive = new ImageIcon("../src/Ressources/Image/Persos/olive.png");
        ImageIcon violet = new ImageIcon("../src/Ressources/Image/Persos/violet.png");
        ImageIcon orchidee = new ImageIcon("../src/Ressources/Image/Persos/orchidee.png");

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

        /* La page se ferme une fois que le joueur a choisi son personnage. */

        JButton boutons[] = {boutonRose, boutonPervenche, boutonOlive, boutonMoutarde, boutonOrchidee, boutonViolet};

        for (int i = 0; i < boutons.length; i++) {
           boutons[i].addActionListener(e -> {
                fenetre.dispose();
               TiragedebutInterfaceG tirageCrime = new TiragedebutInterfaceG(clip);
            });
          }

    }

    public JButton creerBouton(String nom, ImageIcon img) {
        JButton bouton = new JButton(nom, img);
        bouton.setVerticalTextPosition(SwingConstants.TOP);
        bouton.setHorizontalTextPosition(SwingConstants.CENTER);
        return bouton;
    }

    private class ActionMoutarde implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            try {
                joueurHumain.setPersonnage(NomCarte.MOUTARDE);
            } catch (IOException e) {
                System.out.println("Image du pion non trouvé");
            }
        }
    }

    private class ActionRose implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            try {
                joueurHumain.setPersonnage(NomCarte.ROSE);
            } catch (IOException e) {
                System.out.println("Image du pion non trouvé");
            }
        }
    }

    private class ActionPervenche implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            try {
                joueurHumain.setPersonnage(NomCarte.PERVENCHE);
            } catch (IOException e) {
                System.out.println("Image du pion non trouvé");
            }
        }
    }

    private class ActionOrchidee implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            try {
                joueurHumain.setPersonnage(NomCarte.ORCHIDEE);
            } catch (IOException e) {
                System.out.println("Image du pion non trouvé");
            }
        }
    }

    private class ActionOlive implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            try {
                joueurHumain.setPersonnage(NomCarte.OLIVE);
            } catch (IOException e) {
                System.out.println("Image du pion non trouvé");
            }
        }
    }

    private class ActionViolet implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent action) {
            try {
                joueurHumain.setPersonnage(NomCarte.VIOLET);
            } catch (IOException e) {
                System.out.println("Image du pion non trouvé");
            }
        }
    }

}

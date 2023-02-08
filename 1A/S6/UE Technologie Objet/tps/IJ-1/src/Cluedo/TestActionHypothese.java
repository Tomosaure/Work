package Cluedo;

import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.imageio.*;

public class TestActionHypothese {

    public static void main(String[] args) throws IOException {

        Jeu jeu = new Jeu();

        JFrame fenetre = new JFrame("Hypothèse"); // fenêtre
        JPanel conteneur = new JPanel(); // conteneur associé
        fenetre.add(conteneur);

        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); // se fermer lors du clic sur la croix
        fenetre.setLocationRelativeTo(null); // la fenêtre est placée au centre de l'écran
        fenetre.setSize(300,300);
        fenetre.setVisible(true);

        conteneur.setLayout(new GridLayout(2, 3));

        JButton boutonHyp = new JButton("Formuler une hypothèse");
        conteneur.add(boutonHyp);
        boutonHyp.addActionListener(new ActionHypothese(jeu));

    }

}

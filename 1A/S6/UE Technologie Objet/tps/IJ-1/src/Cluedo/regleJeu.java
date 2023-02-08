package Cluedo;

import java.awt.event.ActionEvent;

import javax.sound.sampled.Clip;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

public class regleJeu {
    
    private final JFrame fenetre;
    private Joueur joueur;
    private Clip clip;

    public regleJeu(Joueur joueur, Clip clip) {
        this.clip = clip;
        this.joueur = joueur;
        this.fenetre = new JFrame("Règle du jeu");
        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setSize(1500, 750);
		fenetre.setResizable(true);
		fenetre.setLocationRelativeTo(null);
		//Image de fond
		this.fenetre.setContentPane(new JLabel(new ImageIcon("Ressources/Image/Histoire1.png")));
        
        //Bouton passer
		JButton bPasser = new JButton("");
		bPasser.setIcon(new ImageIcon("Ressources/Image/passer.png"));
		bPasser.setBounds(1250, 650, 188, 59);
		bPasser.addActionListener((e) -> skipListener(e));
		this.fenetre.add(bPasser);

        //Bouton suivant
		JButton bNext = new JButton("");
		bNext.setIcon(new ImageIcon("Ressources/Image/suite.png"));
		bNext.setBounds(1250, 575, 188, 59);
		bNext.addActionListener((e) -> nextListener(e));
		this.fenetre.add(bNext);

        //Afficher la fenetre 
		this.fenetre.setVisible(true);

    }

    private void skipListener(ActionEvent e) {
            this.fenetre.dispose();
            ChoixPersonnage frame = new ChoixPersonnage(joueur, clip);
    }

    private void nextListener(ActionEvent e) {
        this.fenetre.dispose();
        regleJeu2 regle2 = new regleJeu2(joueur, clip);
}
}

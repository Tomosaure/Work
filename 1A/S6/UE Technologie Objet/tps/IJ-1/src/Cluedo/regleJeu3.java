package Cluedo;

import java.awt.event.ActionEvent;

import javax.sound.sampled.Clip;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

public class regleJeu3 {
    
    private final JFrame fenetre;
    private Joueur joueur;
    private Clip clip;

    public regleJeu3(Joueur joueur, Clip clip) {
        this.joueur = joueur;
        this.clip = clip;
        this.fenetre = new JFrame("Règle du jeu");
        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setSize(1500, 750);
		fenetre.setResizable(true);
		fenetre.setLocationRelativeTo(null);

		//Image de fond
		this.fenetre.setContentPane(new JLabel(new ImageIcon("Ressources/Image/Histoire3.png")));
        

        //Bouton commencer
		JButton bCommencer = new JButton("");
		bCommencer.setIcon(new ImageIcon("Ressources/Image/commencer.png"));
		bCommencer.setBounds(1200, 650, 262, 59);
		bCommencer.addActionListener((e) -> startListener(e));
		this.fenetre.add(bCommencer);

        //Afficher la fenetre 
		this.fenetre.setVisible(true);

    }

    private void startListener(ActionEvent e) {
        this.fenetre.dispose();
        ChoixPersonnage frame = new ChoixPersonnage(joueur, clip);
}

}
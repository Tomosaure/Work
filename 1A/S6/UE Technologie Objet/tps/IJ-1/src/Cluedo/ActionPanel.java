package Cluedo;

import javax.swing.JPanel;
import javax.swing.Box;
import javax.swing.BoxLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.io.IOException;
import java.awt.Dimension;
import javax.swing.JFrame;
import javax.swing.JTextArea;
import java.io.IOException;

public class ActionPanel extends JPanel {
    private JPanel container;
    private JPanel de;
    private JPanel boutons;

    public static void main(String[] args) throws Exception {
		// Changer le look
		JFrame frame = new JFrame();
        frame.setSize(1500, 1500);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setResizable(true);
        
		// Creer une fenetre
		ActionPanel myWindow = new ActionPanel(new Dimension(100,50), new Dimension(100,50), new Dimension(100,50));
		myWindow.setVisible(true);

		frame.add(myWindow);
		frame.setVisible(true);
	}
    /**
     * Constructeur de la classe ActionPanel.
     * @param containerSize la dimension du panel contenant les dés et les boutons
     * @param deSize la dimension des dés
     * @param boutonSize la dimension des boutons
     */
    ActionPanel(Dimension containerSize, Dimension deSize, Dimension boutonSize ) {
        // Panel contenant les dés et les boutons d'actions
        this.container = new JPanel();
        this.container.setPreferredSize(containerSize);
        this.container.setLayout(new FlowLayout(FlowLayout.CENTER));

        this.de = new JPanel();
        this.de.setPreferredSize(deSize);
        this.de.setLayout(new BoxLayout(de, BoxLayout.X_AXIS));

        this.boutons = new JPanel();
        this.boutons.setPreferredSize(boutonSize);
        this.boutons.setLayout(new GridLayout(3,1));
    }
    /**
     * L'affichage lorsque c'est au joueur de jouer.
     * @param joueur le joueur
     * @param deJoueur les dés du joueur
     * @throws IOException
     */
    public void Action(Joueur joueur, De deJoueur)throws IOException {

        // Nom et personnage du joueur
        JTextArea text = new JTextArea();
        text.append(joueur.getNom());
        this.container.add(text);

        // De
        de.add(Box.createHorizontalStrut(20));
        de.add(deJoueur.getImage());
        this.container.add(de);

        // Boutons
    }
}

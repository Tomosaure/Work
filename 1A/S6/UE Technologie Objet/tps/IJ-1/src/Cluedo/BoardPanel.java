package Cluedo;

import javax.swing.JPanel;
import java.awt.Dimension;
import java.io.IOException;
import java.awt.Container;
import java.awt.FlowLayout;
import javax.imageio.ImageIO;
import java.io.File;
import java.io.FileNotFoundException;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import javax.swing.JFrame;
public class BoardPanel extends JPanel {

    int largeurImage;
    static Plateau plateau;
    int PlateauLargeur = Plateau.getLargeur() + 1;
    int PlateauHauteur = Plateau.getLargeur() + 1;
    BoardPanel(Dimension size) throws IOException {

        this.setLayout(new FlowLayout(FlowLayout.LEFT));
        this.setPreferredSize(size);
        BoardPanel.plateau = new Plateau();
        this.largeurImage = ImageIO.read(new File("Ressources/Image/CaseNormale/Couloir.png")).getWidth();
    }

    int getBordureX() {
        return (this.getWidth() / 2 - largeurImage * PlateauLargeur / 2);
    }

    int getBordureY() {
        return ((this.getHeight() / 2 - (largeurImage * PlateauHauteur) / 2) / 2);
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        int bordureX = getBordureX();
        int bordureY = getBordureY();

        try {
            BufferedImage[][] image = BoardPanel.plateau.creerPlateau();

            for (int i = bordureX, x = 0; x < image[0].length; i += image[14][14].getHeight(), x++) {
                for (int j = bordureY, y = 0; y < image.length; j += image[14][14].getHeight(), y++) {
                    g.drawImage(image[y][x], i, j, this);
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) throws IOException {
		// Changer le look
		JFrame frame = new JFrame();
		frame.setSize(700, 700);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setResizable(true);

		// Creer un Plateau
		BoardPanel panel = new BoardPanel(new Dimension(692, 480));
		panel.setVisible(true);

		frame.add(panel);
		frame.setVisible(true);
	}
}


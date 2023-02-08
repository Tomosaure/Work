package Cluedo;

import javax.swing.JLabel;
import javax.imageio.ImageIO;
import java.io.File;
import javax.swing.ImageIcon;
import java.io.IOException;

public class De {
    private int nombre;

    public De() {
        this.nombre = (int) (Math.random() * 6 + 1);
    }

    /** Retourner la valeur de dé.
     * 
     * @return la valeur du dé
     */
    public int getNombre() {
        return this.nombre;
    }
    
    public JLabel getImage() throws IOException {
        try {
            return new JLabel(new ImageIcon((ImageIO.read(new File("Ressources/Image/De" + nombre + ".png")))));
        } catch (IOException e) {
            System.out.println("Image incorrecte");
            return null;
        }
    }
}

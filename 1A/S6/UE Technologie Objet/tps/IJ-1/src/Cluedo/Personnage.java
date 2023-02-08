package Cluedo;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.swing.ImageIcon;
import javax.imageio.ImageIO;

/* Un personnage est caractérisé par son nom et son image (pion). */
public class Personnage {

    private NomCarte nom;
    private ImageIcon image;
    private BufferedImage pion;
    public Personnage(NomCarte nom) throws IOException {
        this.nom = nom;
        switch(this.nom) {
            case OLIVE:
            this.pion = ImageIO.read(new File("Ressources/Image/Pion/olive.png"));
            this.image = new ImageIcon("../src/Ressources/Image/Cartes/carteOlive.png");
            break;
            case MOUTARDE:
            this.pion = ImageIO.read(new File("Ressources/Image/Pion/moutarde.png"));
            this.image = new ImageIcon("../src/Ressources/Image/Cartes/carteMoutarde.png");
            break;
            case ORCHIDEE:
            this.image = new ImageIcon("../src/Ressources/Image/Cartes/carteOrchidee.png");
            this.pion = ImageIO.read(new File("Ressources/Image/Pion/orchidee.png"));
            break;
            case PERVENCHE:
            this.image = new ImageIcon("../src/Ressources/Image/Cartes/cartePervenche.png");
            this.pion = ImageIO.read(new File("Ressources/Image/Pion/pervenche.png"));
            break;
            case ROSE:
            this.image = new ImageIcon("../src/Ressources/Image/Cartes/carteRose.png");
            this.pion = ImageIO.read(new File("Ressources/Image/Pion/rose.png"));
            break;
            case VIOLET:
            this.image = new ImageIcon("../src/Ressources/Image/Cartes/carteViolet.png");
            this.pion = ImageIO.read(new File("Ressources/Image/Pion/violet.png"));
            break;
            default:
                break;
        }
    }

    public NomCarte getNom() {
        return this.nom;
    }

    public void setNom(NomCarte nom) {
        this.nom = nom;
    }

    public ImageIcon getImage() {
        return this.image;
    }

    public BufferedImage getPion() {
        return this.pion;
    }
    
}

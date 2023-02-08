package Cluedo;

import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;
import javax.imageio.*;
import java.awt.image.BufferedImage;

/* Un bouton (JButton) associé à une carte. */
public class BoutonCarte extends JButton {

    private Carte carte;

    public BoutonCarte(Carte carte) {
        super();
        this.carte = carte;
    }

    public BoutonCarte(Carte carte, ImageIcon img) {
        super(img);
        this.carte = carte;
    }

    public Carte getCarte() {
        return this.carte;
    }
    
}

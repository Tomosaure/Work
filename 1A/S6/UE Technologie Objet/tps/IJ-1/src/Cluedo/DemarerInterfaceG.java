package Cluedo;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import java.awt.event.ActionEvent;
import java.io.IOException;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;


public class DemarerInterfaceG {

    private Clip clip;
    private static Clip clip2;
	private static AudioInputStream audioIn;
    private final JFrame fenetre;

    public DemarerInterfaceG(Clip clip) {
        this.clip = clip;
        this.fenetre = new JFrame("Tirage des cartes du crime");
        fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setSize(500, 670);
		fenetre.setResizable(true);
		fenetre.setLocationRelativeTo(null);
		//Image de fond
		this.fenetre.setContentPane(new JLabel(new ImageIcon("Ressources/Image/jeudepart.png")));
        
        //Bouton tirer
		JButton bTirer = new JButton("");
		bTirer.setIcon(new ImageIcon("Ressources/Image/enquete.png"));
		bTirer.setBounds(50, 545, 371, 59);
		bTirer.addActionListener((e) -> {
            
                tirerListener(e);
             
        });
		this.fenetre.add(bTirer);

       
        //Afficher la fenetre 
		this.fenetre.setVisible(true);

    }

    private void tirerListener(ActionEvent e) {
           
		
			try {

				java.net.URL soundFile = MenuPrincipal.class.getResource("/musique/sherlock.wav");
				AudioInputStream audioIn = AudioSystem.getAudioInputStream(soundFile);
				AudioFormat format = audioIn.getFormat();
				DataLine.Info info = new DataLine.Info(Clip.class, format);
                
				clip2 = (Clip) AudioSystem.getLine(info);
				clip2.open(audioIn);
				clip2.start();
                this.clip.close();
                this.fenetre.dispose();
                GUI gui = new GUI();
			
				//On affiche l'erreur
			} catch (UnsupportedAudioFileException e1) {
				e1.printStackTrace();
			} catch (IOException e2) {
				e2.printStackTrace();
			} catch (LineUnavailableException e3) {
				e3.printStackTrace();
			}
        
		}
            

    }




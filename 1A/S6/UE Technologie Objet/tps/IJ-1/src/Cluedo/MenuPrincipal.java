package Cluedo;


import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import java.awt.event.ActionEvent;
import java.io.IOException;


public class MenuPrincipal{

    private final JFrame fenetre;
	private static JButton bMusic = new JButton("");
	private static ImageIcon musique = new ImageIcon("Ressources/Image/musique.png");
	private static ImageIcon musiqueclose = new ImageIcon("Ressources/Image/musiqueclose.png");
	private Clip clip;
	private static AudioInputStream audioIn;
	private Joueur joueur;

	public MenuPrincipal(Joueur joueur){
		
		// Construction de la fenêtre de jeu
		this.fenetre = new JFrame("7Clues");
		this.joueur = joueur;
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setSize(1409, 650);
		fenetre.setResizable(true);
		fenetre.setLocationRelativeTo(null);
		//Image de fond
		this.fenetre.setContentPane(new JLabel(new ImageIcon("Ressources/Image/7Clues menuprincipal .png")));

		//Musique de fond 
		try {
			java.net.URL soundFile = MenuPrincipal.class.getResource("/musique/musique.wav");
			AudioInputStream audioIn = AudioSystem.getAudioInputStream(soundFile);
			AudioFormat format = audioIn.getFormat();
			DataLine.Info info = new DataLine.Info(Clip.class, format);
			clip = (Clip) AudioSystem.getLine(info);
			clip.open(audioIn);
			clip.start();
		
			//On affiche l'erreur
		} catch (UnsupportedAudioFileException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (LineUnavailableException e) {
			e.printStackTrace();
		}
		
		
		//Bouton Jouer
		JButton bStart = new JButton("");
		bStart.setIcon(new ImageIcon("Ressources/Image/Jouer .png"));
		bStart.setBounds(630, 300, 183, 59);
		bStart.addActionListener((e) -> startListener(e));
		this.fenetre.add(bStart);

		//Bouton quitter
		JButton bQuitter = new JButton("");
		bQuitter.setIcon(new ImageIcon("Ressources/Image/quitter.png"));
		bQuitter.setBounds(630, 375, 197, 59);
		bQuitter.addActionListener((e) -> quitterListener(e));
		this.fenetre.add(bQuitter);

		//Bouton musique
		JButton bMusic = new JButton("");
		bMusic.setIcon(new ImageIcon("Ressources/Image/musique.png"));
		bMusic.setBounds(630, 450, 212, 59);
		bMusic.addActionListener((e) -> musicListener(e));
		this.fenetre.add(bMusic);

		

		//Afficher la fenetre 
		this.fenetre.setVisible(true);
	}



	private void startListener(ActionEvent e) {
    
		this.fenetre.dispose();
		regleJeu regle = new regleJeu(this.joueur, clip);
		
	}

	private void musicListener(ActionEvent e) {
		bMusic = (JButton) e.getSource();
		
		if (bMusic.getIcon() == musiqueclose) {
			bMusic.setIcon(musique);
			try {
				java.net.URL soundFile = MenuPrincipal.class.getResource("/musique/musique.wav");
				AudioInputStream audioIn = AudioSystem.getAudioInputStream(soundFile);
				AudioFormat format = audioIn.getFormat();
				DataLine.Info info = new DataLine.Info(Clip.class, format);
				clip = (Clip) AudioSystem.getLine(info);
				clip.open(audioIn);
				clip.start();
			
				//On affiche l'erreur
			} catch (UnsupportedAudioFileException e1) {
				e1.printStackTrace();
			} catch (IOException e2) {
				e2.printStackTrace();
			} catch (LineUnavailableException e3) {
				e3.printStackTrace();
			}
		}

		else {
			bMusic.setIcon(musiqueclose);
			clip.close();
		}
	}
    				
	
	
	private void quitterListener(ActionEvent e) {
    
		this.fenetre.dispose();
	}
}
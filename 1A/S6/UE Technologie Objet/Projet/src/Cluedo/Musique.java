package src.Cluedo;

import javax.swing.JOptionPane;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import javax.swing.JOptionPane;
import sun.audio.AudioPlayer;
import sun.audio.AudioStream;


public class Musique {
	public static void main(String[] args) {
		playMusic("/home/adallefr/Annee_1/tob/tps/Projet_long/IJ-1/src/musique");
	}
	public static void playMusic(String filepath) {
	InputStream music;
	try {
		music= new FileInputStream(new File(filepath));
		AudioStream audios= new AudioStream(music);
		AudioPlayer.player.start(audios);
		
		
	}
	catch(Exception e ) {
		JOptionPane.showMessageDialog(null,"Error");
		
	}

}
}

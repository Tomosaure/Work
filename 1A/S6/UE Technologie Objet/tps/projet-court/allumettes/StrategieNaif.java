package allumettes;

import java.util.Random;

public class StrategieNaif implements Strategie {

	private Random rdm = new Random();

	@Override
	public int getPrise(Jeu jeu) {
		assert (jeu != null);
		assert (jeu.getNombreAllumettes() > 0);
		return this.rdm.nextInt(Math.min(jeu.getNombreAllumettes(), Jeu.PRISE_MAX)) + 1;
	}

}

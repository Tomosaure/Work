package allumettes;

import java.util.Random;

public class StrategieExpert implements Strategie {

	private Random rdm = new Random();

	@Override
	public int getPrise(Jeu jeu) {
		assert (jeu != null);
		assert (jeu.getNombreAllumettes() > 0);
		if ((jeu.getNombreAllumettes() - 1) % (Jeu.PRISE_MAX + 1) == 0) {
			return
			this.rdm.nextInt(Math.min(jeu.getNombreAllumettes(), Jeu.PRISE_MAX))
			+ 1;
		} else {
			return (jeu.getNombreAllumettes() - 1) % (Jeu.PRISE_MAX + 1);
		}
	}

}

package allumettes;

public class StrategieRapide implements Strategie {

	@Override
	public int getPrise(Jeu jeu) {
		assert (jeu != null);
		assert (jeu.getNombreAllumettes() > 0);
		return Math.min(Jeu.PRISE_MAX, jeu.getNombreAllumettes());
	}

}

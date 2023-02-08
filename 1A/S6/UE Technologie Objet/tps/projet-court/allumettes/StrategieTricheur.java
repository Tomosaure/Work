package allumettes;

public class StrategieTricheur implements Strategie {

	@Override
	public int getPrise(Jeu jeu) {
		assert (jeu != null);
		assert (jeu.getNombreAllumettes() > 0);
		try {
			while (jeu.getNombreAllumettes() > 2) {
				jeu.retirer(1);
			}
			System.out.println("[Je triche...]");
			System.out.println("[Allumettes restantes : "
			+ jeu.getNombreAllumettes() + "]");
		} catch (CoupInvalideException e) {
			System.out.println("Coup invalide");
		}
		return 1;
	}

}

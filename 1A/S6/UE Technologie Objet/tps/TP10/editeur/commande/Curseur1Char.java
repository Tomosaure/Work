package editeur.commande;

import editeur.Ligne;

public class Curseur1Char extends CommandeLigne {
	
	public Curseur1Char(Ligne l) {
		super(l);
	}

	@Override
	public void executer() {
		ligne.raz();
		
	}

	@Override
	public boolean estExecutable() {
		return ligne.getLongueur() > 0;
	}

}

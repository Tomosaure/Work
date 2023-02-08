package editeur.commande;

import editeur.Ligne;

public class DelChar extends CommandeLigne {
	
	public DelChar(Ligne l) {
		super(l);
	}

	@Override
	public void executer() {
		ligne.supprimer();
	}

	@Override
	public boolean estExecutable() {
		return ligne.getCurseur() != 0;
	}

}


public class EnsembleChaine implements Ensemble{
	
	private Cellule cellule;
	private EnsembleChaine suivant;
	
	public EnsembleChaine(int x) {
		this.cellule = new Cellule(x);
		this.suivant = null;
	}
	
	public EnsembleChaine(Cellule c, EnsembleChaine e) {
		this.cellule = c;
		this.suivant = e;
	}
	
	public boolean estVide() {
		return this == null;		
	}
	
	public int cardinal() {
		if (this.estVide()) {
			return 0;
		}
		else {
			return this.suivant.cardinal() + 1;
		}
		
	}
	
	public boolean contient(int x) {
		if (this.estVide()) {
			return false;
		}
		if (this.cellule.getElement() == x) {
			return true;
		}
		else {
			return this.suivant.contient(x);
		}
	}
	
	public void ajouter(int x) {
		if (this.contient(x)) {
		}
		else {
			Cellule cellule = new Cellule(x);
			EnsembleChaine ensemble = new EnsembleChaine(this.cellule, this.suivant);
			this.cellule = cellule;
			this.suivant = ensemble;		
		}
	}
	
	public void supprimer(int x) {
		if (this.contient(x)) {
			
		}
	}
}

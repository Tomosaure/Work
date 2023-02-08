import java.awt.Color;



abstract public class elementGeometrique {
	
	private Color couleur ;
	
	public elementGeometrique(Color c) {
		this.couleur = c;
	}
	
	public Color getCouleur() {
		return this.couleur;
	}
	
	public void setCouleur(Color c) {
		this.couleur = c;
	}
	
	abstract public void afficher();
	
	abstract public void translater(double dx, double dy);

	abstract public void dessiner(afficheur.Afficheur afficheur);


}

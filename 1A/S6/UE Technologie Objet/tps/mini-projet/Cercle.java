import java.awt.Color;

public class Cercle implements Mesurable2D {
	/**
	 * déclaration des variables.
	 */
	private double rayon;  /** rayon du cercle. */
	private Point centre;  /** centre du cercle. */
	private Color couleur;	/** couleur du cercle. */
	public static final double PI = Math.PI;

	/** Constructeur du cercle à partir de son rayon et son centre.
	 * @param centre centre du cercle
	 * @param rayon rayon du cercle
	 */
	public Cercle(Point centre, double rayon) {
		assert (centre != null);
		assert (rayon > 0);
		this.centre = new Point(centre.getX(), centre.getY());
		this.rayon = rayon;
		this.couleur = Color.blue;
	}

	/** Constructeur du cercle à partir de deux points diamétralement opposés.
	 * @param p1 premier point
	 * @param p2 deuxième point
	 */
	public Cercle(Point p1, Point p2) {
		assert (p1 != null);
		assert (p2 != null);
		assert (p1.getX() != p2.getX() || p1.getY() != p2.getY());
		double cx = (p1.getX() + p2.getX()) / 2;
		double cy = (p1.getY() + p2.getY()) / 2;
		this.centre = new Point(cx, cy);
		this.rayon = p2.distance(p1) / 2;
		this.couleur = Color.blue;
	}

	/** Constructeur du cercle avec deux points opposés et une couleur.
	 * @param p1 premier point
	 * @param p2 deuxième point
	 * @param couleur
	 */
	public Cercle(Point p1, Point p2, Color couleur) {
		this(p1, p2);
		assert (couleur != null);
		this.couleur = couleur;
	}

	/** Créer un cercle à partir du centre et d'un point sur sa circonférence.
	 * @param p1 centre du cercle
	 * @param p2 point sur la circonférence
	 * @return Cercle créer
	 */
	public static Cercle creerCercle(Point p1, Point p2) {
		assert (p1 != null);
		assert (p2 != null);
		return new Cercle(p1, p1.distance(p2));
	}

	/** Translater le cercle (centre du cercle).
	* @param dx déplacement suivant l'axe des X
	* @param dy déplacement suivant l'axe des Y
	*/
	public void translater(double dx, double dy) {
		assert (this != null);
		this.centre.translater(dx, dy);
	}

	/** Obtenir le centre du cercle.
	 * @return centre du cercle
	 */
	public Point getCentre() {
		assert (this != null);
		Point vc = new Point(this.centre.getX(), this.centre.getY());
		return vc;
	}

	/** Obtenir le rayon du cercle.
	 * @return rayon du cercle
	 */
	public double getRayon() {
		assert (this != null);
		return this.rayon;
	}

	/** Obtenir le diamètre du cercle.
	 * @return diamètre du cercle
	 */
	public double getDiametre() {
		assert (this != null);
		return this.getRayon() * 2;
	}

	/** Changer le rayon du cercle.
	  * @param rayon nouveau rayon
	  */
	public void setRayon(double rayon) {
		assert (this != null);
		assert (rayon > 0);
		this.rayon = rayon;
	}

	/** Changer le diamètre du cercle.
	  * @param diametre nouveau diamètre
	  */
	public void setDiametre(double diametre) {
		assert (this != null);
		assert (diametre > 0);
		this.rayon = diametre / 2;
	}

	/** Savoir si un point est à l'intérieur du cercle.
	  * @param point à vérifier
	  * @return True ou False suivant si le point est contenu dans le cercle
	  */
	public boolean contient(Point point) {
		assert (this != null);
		assert (point != null);
		return this.rayon >= point.distance(centre);
	}

	/** Obtenir l'aire du cercle.
	 * @return aire du cercle
	 */
	public double aire() {
		assert (this != null);
		return Math.pow(this.getRayon(), 2) * PI;
	}

	/** Obtenir le périmètre du cercle.
	 * @return périmètre du cercle
	 */
	public double perimetre() {
		assert (this != null);
		return getDiametre() * PI;
	}

	/** Obtenir la couleur du cercle.
	 * @return couleur du cercle
	 */
	public Color getCouleur() {
		assert (this != null);
		return this.couleur;
	}

	/** Changer la couleur du cercle.
	  * @param nouvelleCouleur nouvelle couleur
	  */
	public void setCouleur(Color nouvelleCouleur) {
		assert (this != null);
		assert (nouvelleCouleur != null);
		this.couleur = nouvelleCouleur;
	}

	/** Afficher le cercle.
	 * @return Afficher le cercle
	 */
	public String toString() {
		assert (this != null);
		Point point = this.getCentre();
		return ("C" + this.getRayon() + "@" + point.toString());
	}

}

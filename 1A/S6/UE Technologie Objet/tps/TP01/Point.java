import java.awt.Color;

/** Point modÃ©lise un point gÃ©omÃ©trique dans un plan Ã©quipÃ© d'un
 * repÃ¨re cartÃ©sien.  Un point peut Ãªtre affichÃ© et translatÃ©.
 * Sa distance par rapport Ã  un autre point peut Ãªtre obtenue.
 *
 * @author  Xavier CrÃ©gut <PrÃ©nom.Nom@enseeiht.fr>
 */
public class Point {
	/** Construire un point Ã  partir de son abscisse et de son ordonnÃ©e.
	 * @param vx abscisse
	 * @param vy ordonnÃ©e
	 */
	public Point(double vx, double vy) {
		System.out.println("CONSTRUCTEUR Point(" + vx + ", " + vy + ")");
		this.x = vx;
		this.y = vy;
		this.couleur = Color.green;
	}

	/** Obtenir l'abscisse du point.
	 * @return abscisse du point
	 */
	public double getX() {
		return this.x;
	}

	/** Obtenir l'ordonnÃ©e du point.
	 * @return ordonnÃ©e du point
	 */
	public double getY() {
		return this.y;
	}

	/** Changer l'abscisse du point.
	  * @param vx nouvelle abscisse
	  */
	public void setX(double vx) {
		this.x = vx;
	}

	/** Changer l'ordonnÃ©e du point.
	  * @param vy nouvelle ordonnÃ©e
	  */
	public void setY(double vy) {
		this.y = vy;
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.x + ", " + this.y + ")");
	}

	/** Distance par rapport Ã  un autre point.
	 * @param autre l'autre point
	 * @return distance entre this et autre
	 */
	public double distance(Point autre) {
		return Math.sqrt(Math.pow(autre.x - this.x, 2)
					+ Math.pow(autre.y - this.y, 2));
	}

   /** Translater le point.
	* @param dx dÃ©placement suivant l'axe des X
	* @param dy dÃ©placement suivant l'axe des Y
	*/
	public void translater(double dx, double dy) {
		this.x += dx;
		this.y += dy;
	}

//  Gestion de la couleur

	/** Obtenir la couleur du point.
	 * @return la couleur du point
	 */
	public Color getCouleur() {
		return this.couleur;
	}

	/** Changer la couleur du point.
	  * @param nouvelleCouleur nouvelle couleur
	  */
	public void setCouleur(Color nouvelleCouleur) {
		this.couleur = nouvelleCouleur;
	}


	// La mÃ©thode finalize est appelÃ©e avant que le rÃ©cupÃ©rateur de
	// mÃ©moire ne dÃ©truise l'objet.  Attention toutefois, on ne sait
	// pas quand ces ressources seront libÃ©rÃ©es et il est donc
	// dangereux de s'appuyer sur ce mÃ©canisme pour libÃ©rer des
	// ressources qui sont en nombre limitÃ©.
	//
	// D'autre part, pour Ãªtre sÃ»r que les mÃ©thodes << finalize >>
	// sont appelÃ©es avant la fermeture de Java, il faut appeler la
	// mÃ©thode statique :
	//		System.runFinalizersOnExit(true)
	//
	protected void finalize() {
		System.out.print("DESTRUCTION du point : ");
		this.afficher();
		System.out.println();
	}


//	ReprÃ©sentation interne d'un point
//	---------------------------------

// Remarque : en Java, il est conseillÃ© (convention de programmation)
// de mettre les attributs au dÃ©but de la classe.

	private double x;		// abscisse
	private double y;		// ordonnÃ©e
	private Color couleur;	// couleur du point

}

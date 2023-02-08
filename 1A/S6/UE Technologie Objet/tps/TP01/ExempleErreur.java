/** Une erreur à la compilation !
  * Pourquoi ?
  * @author	Xavier Crégut
  * @version	1.3
  */
public class ExempleErreur {

	/** Méthode principale */
	public static void main(String[] args) {
		Point p1 = new Point(0.0,0.0); // Le constructeur définit dans Point requiert deux arguments or ici aucuns n'est renseigné, le proramme ne s'execute donc pas
		p1.setX(1);							// L'intérêt est de forcer l'utilisateur à rentrer des valeurs pour initialiser le point
		p1.setY(2);
		p1.afficher();
		System.out.println();
	}

}

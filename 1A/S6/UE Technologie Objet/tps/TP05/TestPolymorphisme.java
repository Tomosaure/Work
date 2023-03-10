/** Tester le polymorphisme (principe de substitution) et la liaison
 * dynamique.
 * @author	Xavier Crégut
 * @version	1.5
 */
public class TestPolymorphisme {

	/** Méthode principale */
	public static void main(String[] args) {
		// Créer et afficher un point p1
		Point p1 = new Point(3, 4);	// Est-ce autorisé ? Pourquoi ? Oui c'est autorisé car le type de p1 correspond à celui du constructeur
		p1.translater(10,10);		// Quel est le translater exécuté ? La translation de la classe Point est executée
		System.out.print("p1 = "); p1.afficher (); System.out.println ();
										// Qu'est ce qui est affiché ? (13.0,14.0)
 
		// Créer et afficher un point nommé pn1
		PointNomme pn1 = new PointNomme (30, 40, "PN1");
										// Est-ce autorisé ? Pourquoi ? Oui c'est autorisé car le type de pn1 correspond à celui du constructeur
		pn1.translater (10,10);		// Quel est le translater exécuté ? La translation de la classe Point est executée
		System.out.print ("pn1 = "); pn1.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? PN1 : (40.0, 50.0)

		// Définir une poignée sur un point
		Point q;

		// Attacher un point à q et l'afficher
		q = p1;				// Est-ce autorisé ? Pourquoi ? Oui car q et p1 sont du même type
		System.out.println ("> q = p1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? (13.0,14.0)

		// Attacher un point nommé à q et l'afficher
		q = pn1;			// Est-ce autorisé ? Pourquoi ? oui autorisé car le type de pn1 (PointNomme) est un sous-type de Point qui est le type de q
		System.out.println ("> q = pn1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? PN1 : (40.0, 50.0)

		// Définir une poignée sur un point nommé
		PointNomme qn;

		// Attacher un point à q et l'afficher
		//qn = p1;			// Est-ce autorisé ? Pourquoi ? Non pas autorisé car le type de p1 (Point) n'est pas un sous-type de qn (PointNomme)
		//System.out.println ("> qn = p1;");
		//System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? rien car l'affection qn = p1 n'est pas autoirsé, message d'erreur d'affectation

		// Attacher un point nommé à qn et l'afficher
		qn = pn1;			// Est-ce autorisé ? Pourquoi ? oui autorisé car qn et pn1 sont du même type
		System.out.println ("> qn = pn1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println (); 
										// Qu'est ce qui est affiché ? PN1 : (40.0, 50.0)

		double d1 = p1.distance (pn1);	// Est-ce autorisé ? Pourquoi ? oui autorisé car distance peut-être appelé avec Point mais également avec PointNomme
		System.out.println ("distance = " + d1); 

		double d2 = pn1.distance (p1);	// Est-ce autorisé ? Pourquoi ? oui autorisé car distance peut-être appelé avec Point mais également avec PointNomme
		System.out.println ("distance = " + d2);

		double d3 = pn1.distance (pn1);	// Est-ce autorisé ? Pourquoi ? oui autorisé car distance peut-être appelé avec Point mais également avec PointNomme
		System.out.println ("distance = " + d3);

		System.out.println ("> qn = q;");
		//qn = q;				// Est-ce autorisé ? Pourquoi ? Non pas autorisé Point n'est pas une sous classe de PointNomme
		//System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? Rien car affection non autorisé, message d'erreur d'affectation

		System.out.println ("> qn = (PointNomme) q;");
		qn = (PointNomme) q;		// Est-ce autorisé ? Pourquoi ? oui autorisé grâce à l'opération (PointNomme) qui permet de changer le type apparent de la poignée q
		System.out.print ("qn = "); qn.afficher(); System.out.println ();

		System.out.println ("> qn = (PointNomme) p1;");
		qn = (PointNomme) p1;		// Est-ce autorisé ? Pourquoi ? Non pas autorisé car p1 n'est pas une poignée mais un type Point crée par constructeur
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
	}

}

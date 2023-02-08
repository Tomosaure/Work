
public class Cellule {
	
	private int element; /** element de la cellule */
	
	/** Constructeur du cercle à partir de son element
	 * 
	 * @param element de la Cellule
	 */
	public Cellule(int e) {
		this.element = e;
	}
	/** Retourne la valeur de l'élément de la cellule
	 * 
	 * @return element de la cellule
	 */
	public int getElement() {
		assert (this != null);
		int aux = this.element;
		return aux;
	}
}

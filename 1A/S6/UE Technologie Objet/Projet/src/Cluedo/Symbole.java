package Cluedo;

/**Les symboles possibles dans le carnet de notes */
public enum Symbole {
    VIDE, CROIX, ROND, EXCLAMATION, INTERROGATION;

    private static Symbole[] vals = values();

    public Symbole next()
    {
        return vals[(this.ordinal()+1) % vals.length];
    }
}

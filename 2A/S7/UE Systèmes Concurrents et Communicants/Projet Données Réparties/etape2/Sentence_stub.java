public class Sentence_stub extends SharedObject implements Sentence_itf, java.io.Serializable {
  public Sentence_stub(Object o, int id) {
    super(o,id);
  }
  public void write(java.lang.String arg0) {
    Sentence s = (Sentence)obj;
    s.write(arg0);
  }
  public java.lang.String read() {
    Sentence s = (Sentence)obj;
    return s.read();
  }
}
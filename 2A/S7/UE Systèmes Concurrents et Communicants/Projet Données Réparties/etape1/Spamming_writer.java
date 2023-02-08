import java.awt.*;
import java.awt.event.*;


/**
 * This class implements a infinite spamming writer.
 */
public class Spamming_writer extends Frame {
	public TextArea		text;
	SharedObject		sentence;
	static String		myName;

	public static void main(String argv[]) {
		
		if (argv.length != 1) {
			System.out.println("java Spamming_writer <name>");
			return;
		}
		myName = argv[0];
	
		// initialize the system
		Client.init();
		
		// look up the IRC object in the name server
		// if not found, create it, and register it in the name server
		SharedObject s = Client.lookup("IRC");
		if (s == null) {
			s = Client.create(new Sentence());
			Client.register("IRC", s);
		}
		// create the graphical part
		new Spamming_writer(s);
	}

	public Spamming_writer(SharedObject s) {
	
		setLayout(new FlowLayout());
	
		text=new TextArea(10,56);
		text.setEditable(false);
		text.setForeground(Color.red);
		add(text);
	
		Button write_button = new Button("write");
		write_button.addActionListener(new Spamming_writer_Listener(this, write_button));
		add(write_button);
		
		setSize(470,300);
		text.setBackground(Color.black); 
		setVisible(true);
		
		sentence = s;
	}
}

class Spamming_writer_Listener implements ActionListener {
	Spamming_writer irc;
  int cpt = 0;
	Button btn;
	public Spamming_writer_Listener (Spamming_writer i, Button b) {
    irc = i;
		btn = b;
	}

  public void incr_cpt () {
    this.cpt++;
  }

	public void actionPerformed (ActionEvent e) {
    // create a new thread
    new Spamming_writer_slave(irc).start();
		btn.setEnabled(false);
	}
}

class Spamming_writer_slave extends Thread {
  Spamming_writer irc;
  int cpt = 0;

  public Spamming_writer_slave (Spamming_writer i) {
    irc = i;
  }
  public void incr_cpt () {
    this.cpt++;
  }
  public void run() {
		while (true) {
		// get the value to be written from the buffer
    String s = Integer.toString(cpt);
    
    // lock the object in write mode
		irc.sentence.lock_write();
		
		// invoke the method
		((Sentence)(irc.sentence.obj)).write(Spamming_writer.myName+" wrote "+s);
		
		// unlock the object
		irc.sentence.unlock();

		// increment the counter
		this.incr_cpt();
    }
  }
}

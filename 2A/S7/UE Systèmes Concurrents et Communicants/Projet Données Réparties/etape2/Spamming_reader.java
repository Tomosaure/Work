import java.awt.*;
import java.awt.event.*;

/**
 * This class implements a infinite spamming reader.
 */
public class Spamming_reader extends Frame {
	public TextArea		text;
	SharedObject		sentence;
	static String		myName;

	public static void main(String argv[]) {
		
		if (argv.length != 1) {
			System.out.println("java Spamming_reader <name>");
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
		new Spamming_reader(s);
	}

	public Spamming_reader(SharedObject s) {
	
		setLayout(new FlowLayout());
	
		text=new TextArea(10,56);
		text.setEditable(false);
		text.setForeground(Color.red);
		add(text);
	
    Button read_slow_button = new Button("read slow");
		Button read_fast_button = new Button("read fast");
		read_slow_button.addActionListener(new Spamming_slow_reader_Listener(this, read_slow_button, read_fast_button));
		read_fast_button.addActionListener(new Spamming_fast_reader_Listener(this, read_slow_button, read_fast_button));
		add(read_slow_button);
		add(read_fast_button);

		setSize(470,300);
		text.setBackground(Color.black); 
		setVisible(true);
		
		sentence = s;
	}
}

class Spamming_slow_reader_Listener implements ActionListener {
	Spamming_reader irc;
	Button f_btn;
	Button s_btn;

	public Spamming_slow_reader_Listener (Spamming_reader i, Button sb, Button fb) {
		irc = i;
		f_btn = fb;
		s_btn = sb;
	}
	public void actionPerformed (ActionEvent e) {
    new Spamming_slow_reader_slave(irc).start();
		f_btn.setEnabled(false);
		s_btn.setEnabled(false);
    }
}

class Spamming_slow_reader_slave extends Thread {
  Spamming_reader irc;
  public Spamming_slow_reader_slave (Spamming_reader i) {
    irc = i;
  }
  public void run() {
    while(true) {
      // lock the object in read mode
      irc.sentence.lock_read();
      
      // invoke the method
      String s = ((Sentence)(irc.sentence.obj)).read();
      
      // unlock the object
      irc.sentence.unlock();
      
			try {
				sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
      // display the read value
      irc.text.append(s+"\n");
    }
  }
}

class Spamming_fast_reader_Listener implements ActionListener {
	Spamming_reader irc;
	Button f_btn;
	Button s_btn;

	public Spamming_fast_reader_Listener (Spamming_reader i, Button sb, Button fb) {
		irc = i;
		f_btn = fb;
		s_btn = sb;
	}
	public void actionPerformed (ActionEvent e) {
    new Spamming_fast_reader_slave(irc).start();
		f_btn.setEnabled(false);
		s_btn.setEnabled(false);
    }
}

class Spamming_fast_reader_slave extends Thread {
  Spamming_reader irc;
  public Spamming_fast_reader_slave (Spamming_reader i) {
    irc = i;
  }
  public void run() {
    while(true) {
      // lock the object in read mode
      irc.sentence.lock_read();
      
      // invoke the method
      String s = ((Sentence)(irc.sentence.obj)).read();
      
      // unlock the object
      irc.sentence.unlock();
      
      // display the read value
      irc.text.append(s+"\n");
    }
  }
}

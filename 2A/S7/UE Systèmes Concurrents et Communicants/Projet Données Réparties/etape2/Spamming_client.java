import java.awt.*;
import java.awt.event.*;

/**
 * This class implements a infinite spamming reader and writer at the same time.
 */
public class Spamming_client extends Frame {
	public TextArea		text;
	SharedObject		sentence;
	static String		myName;

	public static void main(String argv[]) {
		
		if (argv.length != 1) {
			System.out.println("java Spamming_client <name>");
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
		new Spamming_client(s);
	}

	public Spamming_client(SharedObject s) {
	
		setLayout(new FlowLayout());
	
		text=new TextArea(10,56);
		text.setEditable(false);
		text.setForeground(Color.red);
		add(text);
	
		Button write_button = new Button("write");
		write_button.addActionListener(new Spamming_client_WL(this, write_button));
		add(write_button);
    Button read_slow_button = new Button("read slow");
		Button read_fast_button = new Button("read fast");
		read_slow_button.addActionListener(new Spamming_client_slow_RL(this, read_slow_button, read_fast_button));
		read_fast_button.addActionListener(new Spamming_client_fast_RL(this, read_slow_button, read_fast_button));
		add(read_slow_button);
		add(read_fast_button);
		
		setSize(470,300);
		text.setBackground(Color.black); 
		setVisible(true);
		
		sentence = s;
	}
}



class Spamming_client_slow_RL implements ActionListener {
	Spamming_client irc;
	Button f_btn;
	Button s_btn;

	public Spamming_client_slow_RL (Spamming_client i, Button sb, Button fb) {
		irc = i;
		f_btn = fb;
		s_btn = sb;
	}
	public void actionPerformed (ActionEvent e) {
    new Spamming_client_slow_RL_slave(irc).start();
		f_btn.setEnabled(false);
		s_btn.setEnabled(false);
    }
}

class Spamming_client_slow_RL_slave extends Thread {
  Spamming_client irc;
  public Spamming_client_slow_RL_slave (Spamming_client i) {
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

class Spamming_client_fast_RL implements ActionListener {
	Spamming_client irc;
	Button f_btn;
	Button s_btn;

	public Spamming_client_fast_RL (Spamming_client i, Button sb, Button fb) {
		irc = i;
		f_btn = fb;
		s_btn = sb;
	}
	public void actionPerformed (ActionEvent e) {
    new Spamming_client_fast_RL_slave(irc).start();
		f_btn.setEnabled(false);
		s_btn.setEnabled(false);
    }
}

class Spamming_client_fast_RL_slave extends Thread {
  Spamming_client irc;
  public Spamming_client_fast_RL_slave (Spamming_client i) {
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

class Spamming_client_WL implements ActionListener {
	Spamming_client irc;
  int cpt = 0;
	Button btn;

	public Spamming_client_WL (Spamming_client i, Button b) {
    irc = i;
		btn = b;
	}

  public void incr_cpt () {
    this.cpt++;
  }

	public void actionPerformed (ActionEvent e) {
    // create a new thread
    new Spamming_client_WL_slave(irc).start();
		btn.setEnabled(false);
	}
}

class Spamming_client_WL_slave extends Thread {
  Spamming_client irc;
  int cpt = 0;

  public Spamming_client_WL_slave (Spamming_client i) {
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
		((Sentence)(irc.sentence.obj)).write(Spamming_client.myName+" wrote "+s);
		
		// unlock the object
		irc.sentence.unlock();

		// increment the counter
		this.incr_cpt();
    }
  }
}

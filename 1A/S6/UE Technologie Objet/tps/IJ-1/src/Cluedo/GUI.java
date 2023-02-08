package Cluedo;

import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JPanel;
//import java.awt.Graphics;
//import java.awt.image.BufferedImage;
//import java.io.File;
import java.io.IOException;
import java.util.LinkedList;
//import javax.imageio.ImageIO;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.BorderLayout;
//import java.awt.Component;
import java.awt.GridLayout;
import javax.swing.JButton;
import javax.swing.JTabbedPane;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.JScrollPane;
//import javax.swing.JTextArea;

public class GUI {




    public static void main(String[] args) throws IOException {

        LinkedList<Pion> pion = new LinkedList<>();
      //  final BufferedImage pion_img = ImageIO.read(new File("Image\\Pion_1.png"));
     //   final BufferedImage case_img = ImageIO.read(new File("Image\\Case_2.png"));

        JFrame frame = construireFrame();
        frame.setSize(1250, 1000);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setResizable(true);
        frame.setVisible(true);

        //JPanel panel = new JPanel();
        //frame.add(panel);
        //frame.setContentPane(panel);
        //panel.setLayout(null);

        JMenuBar menuBar = new JMenuBar();
        frame.setJMenuBar(menuBar);
        frame.getContentPane().setLayout(new BorderLayout(0, 0));        
        JMenu menuJeu = new JMenu("Jeu");
        menuBar.add(menuJeu);

        JMenuItem menuNouveau = new JMenuItem("Nouvelle partie");
        JMenuItem menuQuitter = new JMenuItem("Quitter");
        menuJeu.add(menuNouveau);
        menuJeu.add(menuQuitter);
        menuQuitter.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {

                frame.dispose();
            }
        });



        JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
        
        ChangeListener changeListener = new ChangeListener() {
            public void stateChanged(ChangeEvent changeEvent) {
              JTabbedPane sourceTabbedPane = (JTabbedPane) changeEvent.getSource();
              int index = sourceTabbedPane.getSelectedIndex();
              System.out.println("Fenêtre affichée: " + sourceTabbedPane.getTitleAt(index));
            }
          };

        tabbedPane.addChangeListener(changeListener);

        // Carnet Cluedo 
        GrilleCluedo grille = new GrilleCluedo();
        JScrollPane carnet = new JScrollPane(grille);
        carnet.setName("Carnet");
        tabbedPane.add(carnet);
        tabbedPane.setPreferredSize(new Dimension(500, 500));
        frame.add(tabbedPane, BorderLayout.EAST);
        
        String titles[] = {"Cartes", "Console"};
        for (int i = 0, n = titles.length; i < n; i++) {
          add(tabbedPane, titles[i]);
        }

        // panel en haut à gauche
        JPanel panelgauche = new JPanel(new GridLayout(2,1));
        
        frame.add(panelgauche, BorderLayout.WEST);
        panelgauche.setSize(250, 1000);
        JButton boutonAccusation = new JButton("Accusation");
        JButton boutonHypothese = new JButton("Hypothese");
        boutonAccusation.setBounds(750, 1000, 20, 20);
        panelgauche.add(boutonAccusation);
        panelgauche.add(boutonHypothese);
        Jeu leJeu = new Jeu();
        boutonHypothese.addActionListener(new ActionHypothese(leJeu));
        boutonAccusation.addActionListener(new ActionHypothese(leJeu));

        

    }

    public GUI() throws IOException {
      LinkedList<Pion> pion = new LinkedList<>();
      //  final BufferedImage pion_img = ImageIO.read(new File("Image\\Pion_1.png"));
     //   final BufferedImage case_img = ImageIO.read(new File("Image\\Case_2.png"));

        JFrame frame = construireFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setResizable(true);
        frame.setVisible(true);
        frame.setExtendedState(JFrame.MAXIMIZED_BOTH); 
        //JPanel panel = new JPanel();
        //frame.add(panel);
        //frame.setContentPane(panel);
        //panel.setLayout(null);

        JMenuBar menuBar = new JMenuBar();
        frame.setJMenuBar(menuBar);
        frame.getContentPane().setLayout(new BorderLayout(0, 0));        
        JMenu menuJeu = new JMenu("Jeu");
        menuBar.add(menuJeu);

        JMenuItem menuNouveau = new JMenuItem("Nouvelle partie");
        JMenuItem menuQuitter = new JMenuItem("Quitter");
        menuJeu.add(menuNouveau);
        menuJeu.add(menuQuitter);
        menuQuitter.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {

                frame.dispose();
            }
        });

        // panel au centre
        BoardPanel panelcentre = new BoardPanel(new Dimension(692, 480));
        panelcentre.setVisible(true);
        frame.add(panelcentre, BorderLayout.CENTER);

        JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
        
        ChangeListener changeListener = new ChangeListener() {
            public void stateChanged(ChangeEvent changeEvent) {
              JTabbedPane sourceTabbedPane = (JTabbedPane) changeEvent.getSource();
              int index = sourceTabbedPane.getSelectedIndex();
              System.out.println("Fenêtre affichée: " + sourceTabbedPane.getTitleAt(index));
            }
          };

        tabbedPane.addChangeListener(changeListener);

        // Carnet Cluedo 
        GrilleCluedo grille = new GrilleCluedo();
        JScrollPane carnet = new JScrollPane(grille);
        carnet.setName("Carnet");
        tabbedPane.add(carnet);
        tabbedPane.setPreferredSize(new Dimension(500, 500));
        frame.add(tabbedPane, BorderLayout.EAST);
        
        String titles[] = {"Cartes", "Console"};
        for (int i = 0, n = titles.length; i < n; i++) {
          add(tabbedPane, titles[i]);
        }

        // panel en haut à gauche
        JPanel panelgauche = new JPanel(new GridLayout(2,1));
        
        frame.add(panelgauche, BorderLayout.WEST);
        panelgauche.setSize(250, 1000);
        JButton boutonAccusation = new JButton("Accusation");
        JButton boutonHypothese = new JButton("Hypothese");
        boutonAccusation.setBounds(750, 1000, 20, 20);
        panelgauche.add(boutonAccusation);
        panelgauche.add(boutonHypothese);
        Jeu leJeu = new Jeu();
        ActionHypothese formulationHypAcc = new ActionHypothese(leJeu);
        boutonHypothese.addActionListener(formulationHypAcc);
        boutonAccusation.addActionListener(formulationHypAcc);




    }

    private static JFrame construireFrame() {
        JFrame frame = new JFrame("Plateau");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
        return frame;
    }

    static void add(JTabbedPane tabbedPane, String label) {
        JButton button = new JButton(label);
        tabbedPane.addTab(label, button);
      }

}

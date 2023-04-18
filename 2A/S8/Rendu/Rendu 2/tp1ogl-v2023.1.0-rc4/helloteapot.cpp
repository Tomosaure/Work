#include <cstdlib>

// for mac osx
#ifdef __APPLE__
#include <GLUT/glut.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#else
// only for windows
#ifdef _WIN32
#include <windows.h>
#endif
// for windows and linux
#include <GL/freeglut.h>
#include <GL/gl.h>
#include <GL/glu.h>
#endif

bool wireframe = true;

// function called everytime the windows is refreshed
void display()
{
    // clear window
    glClear(GL_COLOR_BUFFER_BIT);

    // draw scene
    glutWireTeapot(.5);

    // flush drawing routines to the window
    glFlush();
}

// Function called everytime a key is pressed
void key(unsigned char key, int, int)
{
    switch(key)
    {
        // the 'esc' key
        case 27:
        // the 'q' key
        case 'q': exit(EXIT_SUCCESS); break;
        default: break;
        // Add a new case for the letter ‘w’, so that every time it is pressed we can switch
        //from a wireframe teapot to a solid teapot and viceversa.(Hint: you can define and
        //use a global bool variable...)
        bool wireframe = true;



    }
    glutPostRedisplay();
}

// Function called every time the main window is resized
void reshape(int width, int height)
{
    // define the viewport transformation;
    // Change the call to glViewport so that every time the windows is resized, the viewport is always a square centred both vertically and
    // horizontally inside the window, and its size is the maximum that can fit the window
    // (i.e. its size is the minimum between the width and the height of the window)
    glViewport((width-height)/2, (height-width)/2, smin(width, height), std::min(width, height));
}

// Main routine
int main(int argc, char* argv[])
{
    // initialize GLUT, using any commandline parameters passed to the
    //   program
    glutInit(&argc, argv);

    // setup the size, position, and display mode for new windows
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(0, 0);
    glutInitDisplayMode(GLUT_RGB);

    // create and set up a window
    glutCreateWindow("Hello, teapot!");

    // Set up the callback functions:
    // for display
    glutDisplayFunc(display);
    // for the keyboard
    glutKeyboardFunc(key);
    // for reshaping
    glutReshapeFunc(reshape);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(60,1,1,10);
    //Try to increase and decrease the value of the parameter fovy of gluPerspective.
    //What happens and why?

    // tell GLUT to wait for events
    glutMainLoop();
}

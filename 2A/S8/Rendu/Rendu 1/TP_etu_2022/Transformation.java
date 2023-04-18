
import algebra.*;

/**
 * author: cdehais
 */
public class Transformation  {

    Matrix worldToCamera;
    Matrix projection;
    Matrix calibration;

    public Transformation () {
        try {
            worldToCamera = new Matrix ("W2C", 4, 4);
            projection = new Matrix ("P", 3, 4);
            calibration = Matrix.createIdentity (3);
            calibration.setName ("K");
        } catch (InstantiationException e) {
            /* should not reach */
        }
    }

    public void setLookAt (Vector3 cam, Vector3 lookAt, Vector3 up) {
        try {
            Vector3 e3 = new Vector3 (lookAt);
            e3.subtract (cam);
            e3.normalize ();
            Vector3 e1 = up.cross (e3);
            e1.normalize ();
            Vector3 e2 = e3.cross (e1);
            e2.normalize ();

            Matrix N = new Matrix(3, 3)
            N.multiply (e1, 0, 0);
            N.multiply (e2, 1, 1);
            N.multiply (e3, 2, 2);
            N.transpose ();

            t = new Vector (3);
            t = cam.multiply (-1);
            t = N.multiply (t);

            worldToCamera = new Matrix (4, 4);
            worldToCamera.setSubMatrix (0, 0, N);
            worldToCamera.setSubMatrix (0, 3, t);
            worldToCamera.setSubMatrix (3, 3, 1);

        } catch (Exception e) { /* unreached */ };
        
        System.out.println ("Modelview matrix:\n" + worldToCamera);
    }

    public void setProjection () {
        
        System.out.println ("Projection matrix:\n" + projection);
    }

    public void setCalibration (double focal, double width, double height) {


	/* à compléter */

	System.out.println ("Calibration matrix:\n" + calibration);
    }

    /**
     * Projects the given homogeneous, 4 dimensional point onto the screen.
     * The resulting Vector as its (x,y) coordinates in pixel, and its z coordinate
     * is the depth of the point in the camera coordinate system.
     */  
    public Vector3 projectPoint (Vector p)
        throws SizeMismatchException, InstantiationException {
	Vector ps = new Vector(3);

        /* à compléter */

	return new Vector3 (ps);
    }
    
    /**
     * Transform a vector from world to camera coordinates.
     */
    public Vector3 transformVector (Vector3 v)
        throws SizeMismatchException, InstantiationException {
        /* Doing nothing special here because there is no scaling */
        Matrix R = worldToCamera.getSubMatrix (0, 0, 3, 3);
        Vector tv = R.multiply (v);
        return new Vector3 (tv);
    }
    
}

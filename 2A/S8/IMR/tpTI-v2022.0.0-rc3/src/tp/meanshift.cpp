#include "ocv_utils.hpp"

#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <iostream>
#include <iostream>
#include <opencv2/opencv.hpp>

using namespace cv;
using namespace std;


void printHelp(const string& progName)
{
    cout << "Usage:\n\t " << progName << " <image_file> [<image_ground_truth>]" << endl;
}

void meanshift(Mat& data, Mat& result, TermCriteria termcrit, int spatialRad, int colorRad)
{
    data.reshape(1, data.rows * data.cols);
    result = data.clone();

    for (int i = 0; i < data.total(); i++) { 

        Vec3b pixel = result.at<Vec3b>(i);
        Vec3b mode = pixel;
        
        bool converged = false;
        while (!converged) {
            Vec3i sum (0, 0, 0);
            int count = 0;
            for (int x = -spatialRad; x <= spatialRad; x++) {
                for (int y = -spatialRad; y <= spatialRad; y++) {
                    int index = i + x + y * data.cols;
                    if (index < 0 || index >= data.total()) {
                        continue;
                    }
                    Vec3b voisin = result.at<Vec3b>(index);
                    if (norm(Vec3i(pixel) - Vec3i(voisin)) < colorRad) {
                        sum += Vec3i(voisin);
                        count++;
                    }
                }
            }

            mode = Vec3b(sum / count);
            Vec3b shift = mode - pixel;
            if (norm(shift) < termcrit.epsilon) {
                converged = true;
            } else {
                pixel += shift;
            }
        }
        result.at<Vec3b>(i) = mode;
    }
    //result.reshape(3, data.rows);
    return;
}

int main(int argc, char** argv)
{
 
    if (argc != 2 && argc != 3)
    {
        cout << " Incorrect number of arguments." << endl;
        printHelp(string(argv[0]));
        return EXIT_FAILURE;
    }

    const auto imageFilename = string(argv[1]);
    const string groundTruthFilename = (argc == 3) ? string(argv[2]) : string();

    // just for debugging
    {
        cout << " Program called with the following arguments:" << endl;
        cout << " \timage file: " << imageFilename << endl;
        if(!groundTruthFilename.empty()) cout << " \tground truth segmentation: " << groundTruthFilename << endl;
    }

    Mat m, m_ref;

    m = imread(imageFilename, IMREAD_COLOR);
    if(m.empty())
    {
        cout << "Could not open or find the image" << std::endl;
        return EXIT_FAILURE;
    }

    if (argc == 3) {
        m_ref = imread(groundTruthFilename, IMREAD_GRAYSCALE);
        if(m_ref.empty())
        {
            cout << "Could not open or find the image" << std::endl;
            return EXIT_FAILURE;
        }
    }
    
    // convertir en espace couleur L*a*b
    cvtColor(m, m, COLOR_BGR2Lab);

    //on définit les paramètres pour meanshift
    TermCriteria termcrit(TermCriteria::MAX_ITER | TermCriteria::EPS, 5, 1);
    int spatialRad = 20;
    int colorRad = 10;
    int maxPyrLevel = 1;
    Mat result;
    //on applique meanshift
    //pyrMeanShiftFiltering(m, result, spatialRad, colorRad, maxPyrLevel, termcrit);
    meanshift(m, result, termcrit, spatialRad, colorRad);

    cvtColor(result, result, COLOR_Lab2BGR);

    namedWindow(imageFilename, cv::WINDOW_AUTOSIZE);
    imshow(imageFilename, imread(imageFilename));

    imshow("Segmented Image", result);

    cvtColor(result, result, COLOR_BGR2GRAY);

    threshold(result, result, 255/2, 255, THRESH_BINARY_INV);

    imshow("Segmented Binary Image", result);

    long TP = 0, FP = 0, FN = 0;

    if (!m_ref.empty()) {

        for (int i = 0; i < m.rows; i++)
        {
            for (int j = 0; j < m.cols; j++)
            {
                if (m_ref.at<uchar>(i,j) == 255 && result.at<uchar>(i,j) == 255)
                    TP++;
                else if (m_ref.at<uchar>(i,j) == 0 && result.at<uchar>(i,j) == 255)
                    FP++;
                else if (m_ref.at<uchar>(i,j) == 255 && result.at<uchar>(i,j) == 0)
                    FN++;
            }
        }

        double Precision   = (double) TP/(TP+FP);
        double Sensibilite = (double) TP/(TP+FN);
        double DICE_coef   = (double) (2*TP)/(2*TP+FP+FN);

        cout << "TP: " << TP << endl;
        cout << "FP: " << FP << endl;
        cout << "FN: " << FN << endl;
        cout << "Précision: " << Precision << endl;
        cout << "Sensibilité: " << Sensibilite << endl;
        cout << "DICE Coefficient: " << DICE_coef << endl;

        namedWindow(groundTruthFilename, cv::WINDOW_AUTOSIZE);
        imshow(groundTruthFilename, m_ref);
    }
   
    cv::waitKey(0);

    return 0;
    }
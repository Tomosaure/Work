#include "ocv_utils.hpp"

#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <iostream>

using namespace cv;
using namespace std;

Mat kmoyenne(Mat data, int k, ) {
    
    
}

void printHelp(const string& progName)
{
    cout << "Usage:\n\t " << progName << " <image_file> <K_num_of_clusters> [<image_ground_truth>]" << endl;
}

int main(int argc, char** argv) {
    
    if (argc != 3 && argc != 4)
    {
        cout << " Incorrect number of arguments." << endl;
        printHelp(string(argv[0]));
        return EXIT_FAILURE;
    }

    const auto imageFilename = string(argv[1]);
    const string groundTruthFilename = (argc == 4) ? string(argv[3]) : string();
    const int k = stoi(argv[2]);

    // just for debugging
    {
        cout << " Program called with the following arguments:" << endl;
        cout << " \timage file: " << imageFilename << endl;
        cout << " \tk: " << k << endl;
        if(!groundTruthFilename.empty()) cout << " \tground truth segmentation: " << groundTruthFilename << endl;
    }

    // load the color image to process from file
    Mat m;
    Mat gt;

    // for debugging use the macro PRINT_MAT_INFO to print the info about the matrix, like size and type
    PRINT_MAT_INFO(m);
    PRINT_MAT_INFO(gt);
    
    // 1) in order to call kmeans we need to first convert the image into floats (CV_32F)
    // see the method Mat.convertTo()
    
    m = imread(imageFilename, IMREAD_COLOR);
       if(m.empty())
    {
        cout << "Could not open or find the image" << std::endl;
        return EXIT_FAILURE;
    }

    gt = imread(groundTruthFilename, IMREAD_GRAYSCALE);

    Mat src = m.clone();
    m.convertTo(m, CV_32F);
    
    // 2) kmeans asks for a mono-dimensional list of "points". Our "points" are the pixels of the image that can be seen as 3D points
    // where each coordinate is one of the color channel (e.g. R, G, B). But they are organized as a 2D table, we need
    // to re-arrange them into a single vector.
    // see the method Mat.reshape(), it is similar to matlab's reshape
    Mat vect = m.reshape(3, m.total());
    PRINT_MAT_INFO(vect);

    // now we can call kmeans(...)
    Mat1f centers;
    vector<int> labels;
    kmeans(vect, k, labels, TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 10, 1.0), 3, KMEANS_PP_CENTERS, centers);

    for (int i = 0; i < 2; i++) {
        centers.at<float>(0, i) = 0;
        centers.at<float>(1, i) = 255;
    }
    PRINT_MAT_INFO(centers);

    for (int i = 0; i < m.total(); i++)
    {
        vect.at<float>(i,0) = centers(labels[i], 0);
        vect.at<float>(i,1) = centers(labels[i], 1);
        vect.at<float>(i,2) = centers(labels[i], 2);
    }

    Mat vect_r = vect.reshape(3, m.rows);
    vect_r.convertTo(vect_r, CV_8U);

    long TP = 0, TN = 0, FP = 0, FN = 0;

    if(!gt.empty()) {

    for (int i = 0; i < m.rows; i++)
    {
        for (int j = 0; j < m.cols; j++)
        {
            if (gt.at<uchar>(i, j) == 0 && vect_r.at<uchar>(i, j) == 0)
                TP++;
            else if (gt.at<uchar>(i, j) == 255 && vect_r.at<uchar>(i, j) == 255)
                TN++;
            else if (gt.at<uchar>(i, j) == 0 && vect_r.at<uchar>(i, j) == 255)
                FP++;
            else if (gt.at<uchar>(i, j) == 255 && vect_r.at<uchar>(i, j) == 0)
                FN++;
        }
    }

        double Accuracy = (double) TP/(TP+FP);
        double Precision = (double) TP/(TP+FN);
        double DICE_coef = (double) (2*TP)/(2*TP+FP+FN);

        cout << "TP: " << TP << endl;
        cout << "TN: " << TN << endl;
        cout << "FP: " << FP << endl;
        cout << "FN: " << FN << endl;
        cout << "Accuracy: " << Accuracy << endl;
        cout << "Precision: " << Precision << endl;
        cout << "DICE Coefficient: " << DICE_coef << endl;

    }
  
    imwrite("kmeans.jpg", vect_r);

    namedWindow(imageFilename, cv::WINDOW_AUTOSIZE);
    namedWindow("kmeans image", cv::WINDOW_AUTOSIZE);

    imshow(imageFilename, src);
    imshow("kmeans image", vect_r);

    // Wait for a keystroke in the window
    waitKey(0);

    return EXIT_SUCCESS;
}

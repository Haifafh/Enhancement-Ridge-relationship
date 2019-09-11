/* Copyright Odyssee Merveille (2017)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. 1

 */
#include <iostream>
#include <png.h>
#include <math.h>
#include "po.hpp"
#include "sort_functions.hpp"

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include "image.hpp"
#include "image_png.hpp"
#include "image_operations.hpp"
#include "rorpo.hpp"
#include "basic_operators.hpp"

using namespace std;


int main(int argc, char **argv) {

    if (argc!=7) {
        fprintf(stderr, "usage: %s <image path> <min path lenght> <factor> <nbScales> <robustParam> <intensity feature path> \n",argv[0]);
        exit(1);
    }

    // Create the output path of the directional feature
    std::string test = argv[6];
    test.erase(test.find_last_of("."), string::npos);

    std::string vxString = "_vx.png";
    std::string vyString = "_vy.png";
    std::string vxPath = test + vxString;
    std::string vyPath = test + vyString;

    // Read the input image
    Image2D<unsigned char> image = read_2D_png_image<unsigned char>(argv[1]);

    // Compute RORPO multiscale
    Image2D<float> vx(image.dimx(), image.dimy());
    Image2D<float> vy(image.dimx(), image.dimy());

    Image2D<unsigned char> multiscale = RORPO_multiscale(image, atoi(argv[2]), atof(argv[3]), atoi(argv[4]), vx, vy, atoi(argv[5]));

    // Write the intensity feature
    write_2D_png_image<unsigned char>(multiscale, argv[6]);

    // Transform the directional feature to be written in png images
    Image2D<unsigned char> vxChar(image.dimx(), image.dimy());
    Image2D<unsigned char> vyChar(image.dimx(), image.dimy());

    for (int i = 0; i < image.dimx() ; ++i){
        for (int j = 0; j < image.dimy() ; ++j){

            vxChar(i,j) = (unsigned char) round((vx(i,j) + 1) * 100);
            vyChar(i,j) = (unsigned char) round((vy(i,j) +1 )* 100);
        }
    }

    // Write the directional feature
    write_2D_png_image<unsigned char>(vxChar, vxPath);
    write_2D_png_image<unsigned char>(vyChar, vyPath);


  return 0;
}

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

#ifndef SORT_FUNCTIONS_HPP
#define SORT_FUNCTIONS_HPP

template<typename PixelType>
struct sort_indice
{
    const std::vector<PixelType>& vec;

    sort_indice(const std::vector<PixelType>& vec): vec(vec) {}

    bool operator()(int a, int b) const { return vec[a] < vec[b]; }
};


/* Sort and argsort, pixelwise, the input images (image1, image2, image3 and image4).
 * The sorted indices are output in indice1-4.
 *
 * Input: "image1", "image2", "image3", "image4" (images)
 * Output: "indice1", "indice2", "indice3", "indice4" (images of indices).
 */
template<typename PixelType>
void sort_argsort_images(Image2D<PixelType> &image1,
                                 Image2D<PixelType> &image2,
                                 Image2D<PixelType> &image3,
                                 Image2D<PixelType> &image4,
                                 Image2D<int> &indice1,
                                 Image2D<int> &indice2,
                                 Image2D<int> &indice3,
                                 Image2D<int> &indice4){

    for (int i = 0 ; i < image1.image_size() ; i++) {  // For each pixel of an image

        // Store the 4 intensities at the same position in the 4 images in vec
        std::vector<PixelType> vec(4);
        vec[0] = image1(i);
        vec[1] = image2(i);
        vec[2] = image3(i);
        vec[3] = image4(i);


        // Store the initial image indice
        std::vector<PixelType> indice(vec.size());
        for (int j = 0; j < vec.size() ; ++j){
            indice[j] = (PixelType) j;
        }

        // Sort the 4 indices according to their image value
        std::sort(  indice.begin(), indice.end(), sort_indice<PixelType>(vec));
        indice1(i) = indice[0]; // indice of the min value of vec
        indice2(i) = indice[1];
        indice3(i) = indice[2];
        indice4(i) = indice[3]; // indice of the max value of vec

        // Sort the image values
        image1(i) = vec[indice[0]]; // min value
        image2(i) = vec[indice[1]];
        image3(i) = vec[indice[2]];
        image4(i) = vec[indice[3]]; // max value
    }
}


/*
* i and j are memory adresses pointing to PixelType variables.
* Return true if the variable pointed by i is smaller than the variabled
* pointed by j
*/
template<typename PixelType>
bool my_sorting_function (const PixelType *i,const PixelType *j){
        return (*i<*j);
}

//  Return pixels index of image I sorted according to intensity
template<typename PixelType,typename IndexType>
std::vector<IndexType> sort_image_value(PixelType *image, int size)
{
    std::vector<IndexType> indexImage(size);
    std::vector<PixelType*>indexPointerAdress(size);
    IndexType it;
    typename std::vector<PixelType*>::iterator it2;
    typename std::vector<IndexType>::iterator it3;

    // Fill indexPointerAdress with memory adress of variables in image
    for (it=0,it2=indexPointerAdress.begin(); it!=size; ++it, ++it2)
    {
            *it2=&image[it];
    }

    // Sorting adresses according to intensity
    std::sort(indexPointerAdress.begin(),indexPointerAdress.end(),
              my_sorting_function<PixelType>);

    // Conversion from adresses to index of image
    for (it3=indexImage.begin(),it=0; it!=size; ++it,++it3)
    {
            *it3=static_cast<IndexType>(indexPointerAdress[it]-&image[0]);
    }
    return indexImage;
}


#endif // SORT_FUNCTIONS_HPP


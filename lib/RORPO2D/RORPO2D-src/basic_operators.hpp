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

#ifndef BASIC_OPERATORS_HPP
#define BASIC_OPERATORS_HPP

#include <iostream>
#include <vector>
#include <math.h>

template<typename PixelType>
float mean(std::vector<PixelType> vec){

    float meanResult = 0.0;

    typename std::vector<PixelType>::iterator it;
    for (it = vec.begin() ; it != vec.end() ; ++it){
        meanResult += *it;

    }

    meanResult /= vec.size();

    return meanResult;
}

template<typename PixelType>
float standard_deviation(std::vector<PixelType> vec){

    float stdResult = 0.0;

    float meanResult = mean(vec);
    typename std::vector<PixelType>::iterator it;
    for (it = vec.begin() ; it != vec.end() ; ++it){
        stdResult += pow((*it - meanResult ),2);

    }

    stdResult /= vec.size();
    stdResult = sqrt(stdResult);

    return stdResult;
}



#endif // BASIC_OPERATORS_HPP


# CMake generated Testfile for 
# Source directory: /Users/haifa/curvilinear-methods/lib/qhull-2015.2
# Build directory: /Users/haifa/curvilinear-methods/lib/qhull-2015.2/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(testqset "./testqset" "10000")
add_test(testqset_r "./testqset_r" "10000")
add_test(smoketest "sh" "-c" "./rbox D4 | ./qhull Tv")
add_test(rbox-10-qhull "sh" "-c" "./rbox 10 | ./qhull Tv")
add_test(rbox-10-qconvex "sh" "-c" "./rbox 10 | ./qconvex Tv")
add_test(rbox-10-qdelaunay "sh" "-c" "./rbox 10 | ./qdelaunay Tv")
add_test(rbox-10-qhalf "sh" "-c" "./rbox 10 | ./qconvex FQ FV n Tv | ./qhalf Tv")
add_test(rbox-10-qvoronoi "sh" "-c" "./rbox 10 | ./qvoronoi Tv")
add_test(user_eg "sh" "-c" "./user_eg")
add_test(user_eg2 "sh" "-c" "./user_eg2")
add_test(user_eg3 "sh" "-c" "./user_eg3 rbox '10 D2' '2 D2' qhull 's p' facets")

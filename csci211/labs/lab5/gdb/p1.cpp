// same as p1.cpp but the makefile compiles it with a -g

int
main()
{
    // create an integer pointer and
    // initialize it to an illegal address
    int *i = 0;

    // since i is pointing to an illegal address, 
    // this will cause a segmentation fault
    *i = 42;
}


void f(int b)
{
    // create an integer pointer and
    // initialize it to an illegal address
    int *i = 0;

    // since i is pointing to an illegal address, 
    // this will cause a segmentation fault
    *i = 42;
}

void g(int a)
{
    f(a+10);
}

int
main()
{
    g(42);
}

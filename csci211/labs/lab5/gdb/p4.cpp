
int
main()
{
    // create an integer pointer and initialize it to an illegal address
    int *i = (int *) 12345;

    *i = 42;
}

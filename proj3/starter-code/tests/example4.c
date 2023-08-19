long bar(long arg1)
{
    long temp1 = arg1 * 2;
    return temp1;
}

long foo(long arg1, long arg2) 
{
    long temp1 = bar(arg1);
    return temp1;
}

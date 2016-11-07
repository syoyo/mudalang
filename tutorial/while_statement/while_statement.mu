vec loop_func(vec a)
{
    int i = 0;

    vec ret = 0.0;

    while (i < 10) {

        ret = ret + a;
        

        i = i + 1;
    }

    return ret;

}

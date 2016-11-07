struct muda
{
    vec v;
};

static vec structarg_func(out muda m)
{

    m.v = 1.0;

    return m.v;
}

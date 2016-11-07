struct muda
{
    vec v;
};

static vec structarg_func(muda m)
{
    return m.v;
}

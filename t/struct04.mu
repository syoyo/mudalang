struct muda
{
    vec v;
    float f;
};

static vec func(inout muda arg)
{
    muda o;

    o.f = arg.v;

    return o.f;
}


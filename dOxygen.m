function dOx = dOxygen(a, f, o, c1, c2)
    if a + f == 0
        dOx = 0;
    else
        dOx = (100*(a - f*c1)/((a + f)*c2) - o);
    end
end
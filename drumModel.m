function e = drumModel(params)
    
    global steamFlow
    global feedWater
    global furnanceMaster
    global drumLVL

    testsize = 25000;

    constants = params(1:5);
    delays = params(6:9);
    delays(1) = floor(delays(1));
    delays(2) = floor(delays(2));
    delays(3) = floor(delays(3));
    delays(4) = floor(delays(4));
    delays(1) = max(delays(1), 0);
    delays(2) = max(delays(2), 0);
    delays(3) = max(delays(3), 0);
    delays(4) = max(delays(4), 0);
    shifts = [params(10:15)];
    extras = params(16:21);

    simTime = testsize + max(delays) + 1;
    u14 = zeros(1, simTime);
    u34 = zeros(1, simTime);
    u13 = u14;
    u33 = u34;
    y4in = zeros(1, simTime) + shifts(5); %ox
    y4 = zeros(1, simTime) + shifts(5); %ox
    y3 = zeros(1, simTime) + shifts(6);
    e = 0;
    for k = max(delays)+2:24000%k = max(delays) + 2:testsize + max(delays) + 2
       u14(k) =  constants(1) * furnanceMaster(k - delays(1)) + shifts(1) + extras(1) * u14(k-1);
       u34(k) =  constants(2) * feedWater(k - delays(2)) + shifts(2) + extras(2) * u34(k-1);
       u13(k) =  constants(3) * furnanceMaster(k - delays(3)) + shifts(3) + extras(3) * u13(k-1);
       u33(k) =  constants(4) * feedWater(k - delays(4)) + shifts(4) + extras(4) * u33(k-1);
       y4in(k) = u14(k) + u34(k) + extras(5) * y4in(k-1);
       
       y4(k) = y4in(k);
       y3(k) = 0*u13(k) + u33(k) + extras(6)*y3(k-1) + 0*constants(5)*y4(k);
       if k > 2*max(delays)
           e = e + (steamFlow(k) - y4(k))^2;
           e = e + (drumLVL(k) - y3(k))^2;
       end
    end
    
    
%good: 0.0017   -0.0327  452.3983  413.0461  390.6614   -0.1482  369.7400  335.6082    1.0000   -0.0021   -0.0681
%d1: 1.5444    0.0963    0.9998    0.9998    0.9998   99.9961   99.9967   99.9998    0.2667    0.2499   -0.4852
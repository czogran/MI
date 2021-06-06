function e = oxModel(params)
    
    global oxygen
    global airFlow
    global furnanceMaster


    testsize = 25001;

    constants = params(1:4);
    delays = params(5:7);
    delays(1) = floor(delays(1));
    delays(2) = floor(delays(2));
    delays(3) = floor(delays(3));
    delays(1) = max(delays(1), 0);
    delays(2) = max(delays(2), 0);
    delays(3) = max(delays(3), 0);
    shifts = params(8:10);
    extras = params(11:12);

    simTime = testsize + max(delays) + 1;
    u1 = zeros(1, simTime);
    u2 = zeros(1, simTime);
    y2in = zeros(1, simTime) + shifts(3); %ox
    y2 = zeros(1, simTime) + shifts(3); %ox
    e = 0;
    for k = max(delays) + 2: 24000%k = max(delays) + 2:testsize + max(delays) + 2
       u1(k) =  constants(1) * furnanceMaster(k - delays(1)) + shifts(1) + extras(1) * u1(k-1);
       u2(k) =  constants(2) * airFlow(k - delays(2)) + shifts(2) + extras(2) * u2(k-1);

       kO1 = dOxygen(u2(k-1), u1(k-1), y2in(k-1), constants(3), constants(4));
       kO2 = dOxygen(u2(k-1), u1(k-1), y2in(k-1) + 1/2*kO1, constants(3), constants(4));
       kO3 = dOxygen(u2(k-1), u1(k-1), y2in(k-1) + 1/2*kO2, constants(3), constants(4));
       kO4 = dOxygen(u2(k-1), u1(k-1), y2in(k-1) + kO3, constants(3), constants(4));
       
       dO=1/6*(kO1+2*kO2+2*kO3+kO4);
       
       y2in(k) = y2in(k-1) + dO;
       
       y2(k) = y2in(k - delays(3));
       e = e + (oxygen(k) - y2(k))^2;
    end
    plot(movmean(y2, 1))
    hold on
    plot(oxygen)
    e
end
%d1: 75.1713   97.1694   -4.3472   99.2886   76.9803   77.0000   76.9856  -16.7837   61.5493    2.3578
%d2: 77.6663   99.9941   -4.4816   99.9564   71.5856   88.0000   83.7811  -99.4734   99.3267    2.4019
%d3: 72.1272   93.1415   -4.4117   97.0573   32.0000   32.0000   32.0000   48.2912  -67.0519    2.2984
%da: 99.1764    0.3574    0.0009    0.0251   80.3682   80.3868   80.3732  -63.5253  -29.2179    2.6095
%in: 98.0151    0.2011    0.0003    0.0133   80.4428   80.4614   80.4478  -63.9406  -18.4127    2.6185    0.9871    0.9873
% call fmincon(@oxModel, [da, 0, 0], [], [], [], [], [-100, -100, -100, -100, 0, 0, 0, -100, -100, -100, -1, -1], [100, 100, 100, 100, 500, 500, 500, 100, 100, 100, 1, 1])
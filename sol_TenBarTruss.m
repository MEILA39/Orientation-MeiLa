function [sigma,Q] = sol_TenBarTruss(r1,r2)
    %定義各項參數
    E = 200*10^9;%GPA
    lo = 7860;%kg/m^3
    sigma_y = 250;%MPa
    node = [18.28 9.14;
            18.28 0;
            9.14 9.14;
            9.14 0;
            0 9.14; 
            0 0];
    L1 = 9.14;
    L2 = 9.14;
    L3 = 9.14;
    L4 = 9.14;
    L5 = 9.14;
    L6 = 9.14; 
    L7 = 9.14*2^0.5;
    L8 = 9.14*2^0.5;
    L9 = 9.14*2^0.5;
    L10 = 9.14*2^0.5;

    cos1 = (node(5,1)-node(3,1))/L1;
    cos2 = (node(3,1)-node(1,1))/L2;
    cos3 = (node(6,1)-node(4,1))/L3;
    cos4 = (node(4,1)-node(2,1))/L4;
    cos5 = (node(4,1)-node(3,1))/L5;
    cos6 = (node(2,1)-node(1,1))/L6;
    cos7 = (node(5,1)-node(4,1))/L7;
    cos8 = (node(6,1)-node(3,1))/L8;
    cos9 = (node(3,1)-node(2,1))/L9;
    cos10 = (node(4,1)-node(1,1))/L10;

    sin1 = (node(5,2)-node(3,2))/L1;
    sin2 = (node(3,2)-node(1,2))/L2;
    sin3 = (node(6,2)-node(4,2))/L3;
    sin4 = (node(4,2)-node(2,2))/L4;
    sin5 = (node(4,2)-node(3,2))/L5;
    sin6 = (node(2,2)-node(1,2))/L6;
    sin7 = (node(5,2)-node(4,2))/L7;
    sin8 = (node(6,2)-node(3,2))/L8;
    sin9 = (node(3,2)-node(2,2))/L9;
    sin10 = (node(4,2)-node(1,2))/L10;
    
    A1 = pi*r1^2;
    A2 = pi*r2^2;
    % 開一個空白的剛性矩陣 (stiffness matrix)
    K = zeros(12,12);
    % 計算 stiffness matrix (可使用 add_element 函數)
    K = add_element(K,A1,E,L1,sin1,cos1,3,5);%1
    K = add_element(K,A1,E,L2,sin2,cos2,1,3);%2
    K = add_element(K,A1,E,L3,sin3,cos3,4,6);%3
    K = add_element(K,A1,E,L4,sin4,cos4,2,4);%4
    K = add_element(K,A1,E,L5,sin5,cos5,3,4);%5
    K = add_element(K,A1,E,L6,sin6,cos6,1,2);%6
    K = add_element(K,A2,E,L7,sin7,cos7,4,5);%7
    K = add_element(K,A2,E,L8,sin8,cos8,3,6);%8
    K = add_element(K,A2,E,L9,sin9,cos9,2,3);%9
    K = add_element(K,A2,E,L10,sin10,cos10,1,4);%10
    
    K_reduce = K(1:8,1:8);
    % 建立力矩陣
    F = [0 ;0 ;0 ;-10^7 ;0 ;0 ;0 ;-10^7];           
    % 建立空白位移矩陣
    Q_reduce = zeros(8,1);
    Q = zeros(12,1);
    
    % 計算位移量 (F = KQ)
    Q_reduce = K_reduce\F;
    Q(1:8,1) = Q_reduce(1:8,1);
    % 建立空白應力矩陣
    sigma = zeros(10,1);
    
    % 計算應力 (stress) (可使用 compute_stress 函數)
    sigma(1) = compute_stress(Q, E, L1, sin1, cos1, 3, 5);
    sigma(2) = compute_stress(Q, E, L2, sin2, cos2, 1, 3);
    sigma(3) = compute_stress(Q, E, L3, sin3, cos3, 4, 6);
    sigma(4) = compute_stress(Q, E, L4, sin4, cos4, 2, 4);
    sigma(5) = compute_stress(Q, E, L5, sin5, cos5, 3, 4);
    sigma(6) = compute_stress(Q, E, L6, sin6, cos6, 1, 2);
    sigma(7) = compute_stress(Q, E, L7, sin7, cos7, 4, 5);
    sigma(8) = compute_stress(Q, E, L8, sin8, cos8, 3, 6);
    sigma(9) = compute_stress(Q, E, L9, sin9, cos9, 2, 3);
    sigma(10) = compute_stress(Q, E, L10, sin10, cos10, 1, 4);
end


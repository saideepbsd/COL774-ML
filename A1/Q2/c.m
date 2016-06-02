x = load('q3x.dat');
y = load('q3y.dat');

y1 =b(0.1);
y2 =b(0.3);
y3 =b(0.8);
y4 =b(2);
y5= b(10);
x1 = x(:,1);
p1 = plot(x1,y ,'.b');
hold on
p2 = plot(x1,y1,'.y');
p3 = plot(x1,y2,'.m');
p4 = plot(x1,y3,'.r');
p5 = plot(x1,y4,'.k');
p6 = plot(x1,y5,'.g');
legend([p1,p2,p3,p4,p5,p6],'Original Data', 'Tau=0.1','Tau=0.3','Tau=0.8','Tau=2','Tau=10','Location','south');
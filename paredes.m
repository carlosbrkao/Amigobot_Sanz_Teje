sonar_0=rossubscriber('/robot0/sonar_0');
sonar_1=rossubscriber('/robot0/sonar_1');
sonar_2=rossubscriber('/robot0/sonar_2');
sonar_3=rossubscriber('/robot0/sonar_3');
sonar_4=rossubscriber('/robot0/sonar_4');
sonar_5=rossubscriber('/robot0/sonar_5');
sonar_6=rossubscriber('/robot0/sonar_6');
sonar_7=rossubscriber('/robot0/sonar_7');
pause(1);
while (strcmp(sonar_1.LatestMessage.Header.FrameId,'robot0_sonar_1')~=1)
sonar_0.LatestMessage
end
while (strcmp(sonar_2.LatestMessage.Header.FrameId,'robot0_sonar_2')~=1)
sonar_0.LatestMessage
end
while (strcmp(sonar_3.LatestMessage.Header.FrameId,'robot0_sonar_3')~=1)
sonar_0.LatestMessage
end
while (strcmp(sonar_4.LatestMessage.Header.FrameId,'robot0_sonar_4')~=1)
sonar_0.LatestMessage
end
while (strcmp(sonar_5.LatestMessage.Header.FrameId,'robot0_sonar_5')~=1)
sonar_0.LatestMessage
end
while (strcmp(sonar_6.LatestMessage.Header.FrameId,'robot0_sonar_6')~=1)
sonar_0.LatestMessage
end
while (strcmp(sonar_7.LatestMessage.Header.FrameId,'robot0_sonar_7')~=1)
sonar_0.LatestMessage
end
while (strcmp(sonar_0.LatestMessage.Header.FrameId,'robot0_sonar_0')~=1)
sonar_0.LatestMessage
end


s0_Orientacion = 1.5708;
s1_Orientacion = 0.715585;
s2_Orientacion = 0.261799;
s3_Orientacion = -0.261799;
s4_Orientacion = -0.715585;
s5_Orientacion = -1.5708;
s6_Orientacion = -2.53073;
s7_Orientacion = 2.53073;



X = zeros(1,8);
Y = zeros(1,8);

dist = sonar_0.LatestMessage.Range_;
X(1)= cos(s0_Orientacion)*dist;
Y(1)= sin(s0_Orientacion)*dist;

dist = sonar_1.LatestMessage.Range_;
X(2)= cos(s1_Orientacion)*dist;
Y(2)= sin(s1_Orientacion)*dist;

dist = sonar_4.LatestMessage.Range_;
X(3)= cos(s4_Orientacion)*dist;
Y(3)= sin(s4_Orientacion)*dist;

dist = sonar_5.LatestMessage.Range_;
X(4)= cos(s5_Orientacion)*dist;
Y(4)= sin(s5_Orientacion)*dist;

dist = sonar_6.LatestMessage.Range_;
X(5)= cos(s6_Orientacion)*dist;
Y(5)= sin(s6_Orientacion)*dist;

dist = sonar_7.LatestMessage.Range_;
X(6)= cos(s7_Orientacion)*dist;
Y(6)= sin(s7_Orientacion)*dist;

dist = sonar_2.LatestMessage.Range_;
X(7)= cos(s2_Orientacion)*dist;
Y(7)= sin(s2_Orientacion)*dist;

dist = sonar_3.LatestMessage.Range_;
X(8)= cos(s3_Orientacion)*dist;
Y(8)= sin(s3_Orientacion)*dist;



figure
plot(X,Y,'-o','MarkerFaceColor',[1,0,0],'MarkerEdgeColor','r');
title('Paredes');
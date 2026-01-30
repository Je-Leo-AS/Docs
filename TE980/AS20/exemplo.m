circle = 0:0.1:2*pi;
waypoints = [cos(circle') sin(circle')] * 10;
% Define the total time and the sample rate
sampleTime = 0.05;               % Sample time [s]
tVec = 0:sampleTime:20;          % Time array
initPose = [waypoints(1,:)'; pi/2]; % Initial pose (x y theta)

goalPoints = [0 ; -5] ;
goalRadius = 1;

waypoints = [0 1; 0 10; 0 20; 10 20; 20 20; 20 10; 20 0; 10 0; 0 0];

sampleTime = 1.25 ;               % Sample time [s]
tVec = 0:sampleTime:20;          % Time array
initPose = [waypoints(1,:)'; 0]; % Initial pose (x y theta

goalPoints = [0 ; -1] ;
goalRadius = 1;

i = 1
n = size(waypoints)[1]
MSEx = 0
MSEy = 0

while i < n
    MSEx_unicycle(i) = (unicyclePose(i,1) - waypoints(i,1))^2;
    MSEy_unicycle(i) = (unicyclePose(i,2) - waypoints(i,2))^2;
    MSEx = MSEx +  MSEx_unicycle(i);
    MSEy = MSEy +  MSEy_unicycle(i);
    i = i+1;
end

MSE = (MSEx+MSEy)/n


i = 1
n = size(waypoints)[1]
MSEx = 0
MSEy = 0

while i < n
    MSEx_unicycle(i) = (unicyclePose(i,1) - waypoints(i,1))^2;
    MSEy_unicycle(i) = (unicyclePose(i,2) - waypoints(i,2))^2;
    MSEx = MSEx +  MSEx_unicycle(i);
    MSEy = MSEy +  MSEy_unicycle(i);
    i = i+1;
end

MSE = (MSEx+MSEy)/n

i = 1
n = size(waypoints)[1]
MSEx = 0
MSEy = 0

while i < n
    MSEx_bicycle(i) = (bicyclePose(i,1) - waypoints(i,1))^2;
    MSEy_bicycle(i) = (bicyclePose(i,2) - waypoints(i,2))^2;
    MSEx = MSEx +  MSEx_bicycle(i);
    MSEy = MSEy +  MSEy_bicycle(i);
    i = i+1;
end

MSE = (MSEx+MSEy)/n


i = 1
n = size(waypoints)[1]
MSEx = 0
MSEy = 0

while i < n
    MSEx_diff(i) = (diffDrivePose(i,1) - waypoints(i,1))^2;
    MSEy_diff(i) = (diffDrivePose(i,2) - waypoints(i,2))^2;
    MSEx = MSEx +  MSEx_diff(i);
    MSEy = MSEy +  MSEy_diff(i);
    i = i+1;
end

MSE = (MSEx+MSEy)/n

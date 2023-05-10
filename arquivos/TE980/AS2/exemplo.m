circle = 0:0.1:2*pi;
waypoints = [cos(circle') sin(circle')] * 10;
% Define the total time and the sample rate
sampleTime = 0.05;               % Sample time [s]
tVec = 0:sampleTime:20;          % Time array
initPose = [waypoints(1,:)'; pi/2]; % Initial pose (x y theta)

goalPoints = [0 ; -5] ;
goalRadius = 1;

waypoints = [0 1; 0 10; 0 20; 10 20; 20 20; 20 10; 20 0; 10 0; 0 0];
sampleTime = 0.05;               % Sample time [s]
tVec = 0:sampleTime:20;          % Time array
initPose = [waypoints(1,:)'; 0]; % Initial pose (x y theta

goalPoints = [0 ; -1] ;
goalRadius = 1;
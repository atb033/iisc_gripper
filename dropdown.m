function f = dropdown
global a armmotor wristmotor

%------- To drop the arm and lift up the object------
% To bring down the arm
a.analogWrite(armmotor(1),170);
a.analogWrite(armmotor(2),0);
pause(1.6);
a.analogWrite(armmotor(1),0);

% To drop the object
a.analogWrite(wristmotor(2),200);
a.analogWrite(wristmotor(1),0);
pause(1.4);
a.analogWrite(wristmotor(2),0);

% To bring up the arm 
a.analogWrite(armmotor(2),200);
pause(2);
a.analogWrite(armmotor(2),0);



end
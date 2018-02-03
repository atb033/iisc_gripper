function f = pickup
global a armmotor wristmotor

%------- To drop the arm and lift up the object------
% To bring down the arm
a.analogWrite(armmotor(1),170);
a.analogWrite(armmotor(2),0);
pause(1.5);
a.analogWrite(armmotor(1),0);

% To grip the object
a.analogWrite(wristmotor(1),200);
a.analogWrite(wristmotor(2),0);
pause(1);
a.analogWrite(wristmotor(1),0);

% To bring up the arm 
a.analogWrite(armmotor(2),200);
pause(2);
a.analogWrite(armmotor(2),0);



end
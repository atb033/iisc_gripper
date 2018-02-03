function f = moveleft(val)

global a gantrymotor

%------- To drop the arm and lift up the object------
% To bring down the arm
a.analogWrite(8,200);
a.analogWrite(9,0);
pause(val);
a.analogWrite(8,0);
end
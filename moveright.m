function f = moveright(val)

global a gantrymotor

%------- To drop the arm and lift up the object------
% To bring down the arm
a.analogWrite(gantrymotor(2),200);
a.analogWrite(gantrymotor(1),0);
pause(val);
a.analogWrite(gantrymotor(2),0);
end
function f = openwrist
global wristmotor a
% To drop the object
a.analogWrite(wristmotor(2),200);
a.analogWrite(wristmotor(1),0);
pause(1.2);
a.analogWrite(wristmotor(2),0);
end
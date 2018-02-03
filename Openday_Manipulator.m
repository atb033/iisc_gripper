% % %%
% clear all
% close all
%
% global a
% a = arduino('COM6');
%
% obj = videoinput('winvideo',2, 'RGB24_320x180');
% obj.ReturnedColorSpace = 'rgb';
% % Select the source to use for acquisition.
% set(obj, 'SelectedSourceName', 'input1')
%  preview(obj)


%%
global gantrymotor armmotor wristmotor
gantrymotor(1) = 8;
gantrymotor(2) = 9;
armmotor(1) = 10;
armmotor(2) = 11;
wristmotor(1) = 6;
wristmotor(2) = 7;
a.pinMode(gantrymotor(1),'output');
a.pinMode(gantrymotor(2),'output');
a.pinMode(armmotor(1),'output');
a.pinMode(armmotor(2),'output');
a.pinMode(wristmotor(1),'output');
a.pinMode(wristmotor(2),'output');
a.analogWrite(gantrymotor(1),0);
a.analogWrite(gantrymotor(2),0);
a.analogWrite(armmotor(1),0);
a.analogWrite(armmotor(2),0);
a.analogWrite(wristmotor(1),0);
a.analogWrite(wristmotor(2),0);
openwrist()
a.encoderAttach(0,2,3)

centroid_prev = [];
reply = [];
while isempty(reply)
    iter = 1;
flag = 0;
while iter<4
    
    %% This part of the code finds out where the wrist is located
    
    
    frame = getsnapshot(obj); % taking camera snapshot
    figure(1)
%     image(frame)
    [fx,fy,~]= size(frame);
     frame(1:40,:,:)=0;
    frame(80:180,:,:)=0;
    image(frame)
    filtered_frame = zeros(fx,fy,3);
    temp = [];
    for i = 1:fx
        for j = 1:fy
            if (frame(i,j,1)-frame(i,j,2)>55)&&(frame(i,j,1)-frame(i,j,3)>55)
                filtered_frame(i,j,1)=100;
                filtered_frame(i,j,2)=100;
                filtered_frame(i,j,3)=100;
                temp = [temp;[i j]];
            end
        end
    end
    % pause();
    figure(2)
    imshow(filtered_frame)
    centroid_wrist = mean(temp);
    
    %% TO find object
    
    
    frame = getsnapshot(obj); % taking camera snapshot
    figure(1)
%     image(frame)
    [fx,fy,~]= size(frame);
    filtered_frame = zeros(fx,fy,3);
    temp = [];
    frame(1:45,:,:)=0;
    frame(110:180,:,:)=0;
    image(frame)
    for i = 1:fx
        for j = 1:fy
            if (frame(i,j,1)-frame(i,j,2)<30)&&(frame(i,j,2)-frame(i,j,3)>30)
                filtered_frame(i,j,1)=100;
                filtered_frame(i,j,2)=100;
                filtered_frame(i,j,3)=100;
                temp = [temp;[i j]];
            end
        end
    end
    
    % pause();
    figure(2)
    imshow(filtered_frame)
    centroid_object = mean(temp);
%     centroid_prev = [centroid_prev; centroid_object];
    %% Find required position of wrist
    if length(centroid_object)== 2
        centroid_required = [53, round(307/241*(centroid_object(2)-40)+7)];
        movement_required = centroid_wrist(2)-centroid_required(2);
        if movement_required < 0
            moveleft(abs(movement_required*26/307));
        else
            moveright(abs(movement_required*26/307));
        end
    else
        
            
            if flag < 3
                iter = iter-1;
                moveleft(0.2);
                flag =flag+1;
            end
            
        
    end
    iter = iter+1
end
pickup();
centroid_required = [53, 295];
movement_required = centroid_wrist(2)-centroid_required(2);

if movement_required < 0
    moveleft(abs(movement_required*26/307));
else
    moveright(abs(movement_required*26/307));
end


dropdown

reply = input('continue?','s')
end

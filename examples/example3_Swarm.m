% Example - Swarm Formation control
% Shows how to easily create subplots and, how to make multiple copies of
% elements at once, customizing, and recording.
clear
load swarmData.mat


figure(1)
subplot(1,2,1)
ani1 = Animation();
ani1.addElement(AnimatedQuadcopter(),4)
ani1.build
axis([-21 21 -21 21 -10 10])
grid on
title('Without formation regulation')

subplot(1,2,2)
ani2 = Animation();
ani2.addElement(AnimatedQuadcopter(),4)
ani2.build
axis([-21 21 -21 21 -10 10])
grid on
title('With formation regulation')

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Play and/or record animation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recording = false;
if recording == true
    vid = VideoWriter('animation.mp4');
    vid.FrameRate = 16;
    vid.Quality = 100;
    open(vid);
end

for lv1 = 1:length(r1)/2
    C = cat(3,eye(3), eye(3), eye(3), eye(3));
    
    ani1.update(r1(:,:,lv1),C)
    ani2.update(r2(:,:,lv1),C)
    pause(eps)
    
    if recording == true
       frame = getframe(gcf);
       writeVideo(vid,frame);
    end
end

if recording == true
    close(vid);
end



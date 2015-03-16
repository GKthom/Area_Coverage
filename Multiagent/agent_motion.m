function [next_pos]=agent_motion(agent_pos,agent_action,xy,world)

orig_pos=agent_pos;

if agent_pos(1)>1&&agent_pos(2)>1&&agent_pos(1)<(xy)&&agent_pos(2)<(xy)

if agent_action==1
    agent_pos=agent_pos+[-1,-1];
elseif agent_action==2
    agent_pos=agent_pos+[-1,0];
elseif agent_action==3
    agent_pos=agent_pos+[-1,1];
elseif agent_action==4
    agent_pos=agent_pos+[0,-1];
elseif agent_action==5
    agent_pos=agent_pos+[0,0];
elseif agent_action==6
    agent_pos=agent_pos+[0,1];
elseif agent_action==7
    agent_pos=agent_pos+[1,-1];
elseif agent_action==8
    agent_pos=agent_pos+[1,0];
elseif agent_action==9
    agent_pos=agent_pos+[1,1];
end

else
    if agent_pos(1)<1||agent_pos(1)==1
        agent_pos(1)=2;
    end
    if agent_pos(2)<1||agent_pos(2)==1
        agent_pos(2)=2;
    end
    if agent_pos(1)>xy||agent_pos(1)==xy
        agent_pos(1)=xy-1;
    end
    if agent_pos(2)>xy||agent_pos(2)==xy
        agent_pos(2)=xy-1;
    end

end

next_pos=agent_pos;

% if world(next_pos(1),next_pos(2))>=100
%     next_pos=orig_pos;
% end
    
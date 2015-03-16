function [agent_sight,prob]=sight(agent_pos,world,sensor_accuracy,obstacle_cost,freespace_cost,visited_pts,agent_sight,agent_pos_log,xy,prob)


orig_agent_sight=agent_sight;
%Create a probability distribution- Assign a probability for each grid cell
for i=1:9
    moved_pos=agent_motion(agent_pos,i,xy,world);
        dist(moved_pos(1),moved_pos(2))=(0.01*sensor_accuracy/3)*0.5*eucl_dist(moved_pos(1),moved_pos(2),agent_pos(1),agent_pos(2));
        prob(moved_pos(1),moved_pos(2))=2.71^(-dist(moved_pos(1),moved_pos(2)));
end

% for i=1:s(1)
%     for j=1:s(2)
%         dist(i+agent_pos(1),j+agent_pos(2))=(0.01*sensor_accuracy/3)*0.5*eucl_dist(agent_pos(1),agent_pos(2),i,j);
%         prob(i,j)=2.71^(-dist(i,j));
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%Update Probabilities%%%%%%%%%%%%%%%%%%%
%basic idea is that if you have already visited a state, you have some idea of that state. Your sureness of the value of that state will not decrease 
%The sureness (or prob) will increase
ss=size(visited_pts);
if ss(1)~=0&&ss(2)~=0
for i=1:ss(1)
    for j=1:ss(2)
            prob(visited_pts{i,j}(1),visited_pts{i,j}(2))=max(visited_pts{i,j}(3),prob(visited_pts{i,j}(1),visited_pts{i,j}(2)));
    end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Take action as per the updated probability matrix%%%%%%%%%%%%
for i=1:9
    moved_pos=agent_motion(agent_pos,i,xy,world);
    if rand<prob(moved_pos(1),moved_pos(2))
            agent_sight(moved_pos(1),moved_pos(2))=world(moved_pos(1),moved_pos(2))*prob(moved_pos(1),moved_pos(2));
        else
            coin_flip=round(rand);
            if coin_flip==1
                guessed_cost=freespace_cost;
            else guessed_cost=obstacle_cost;
            end
            agent_sight(moved_pos(1),moved_pos(2))=guessed_cost*prob(moved_pos(1),moved_pos(2));
     end

end

% % 
% % for i=1:s(1)
% %     for j=1:s(2)
% %         if rand<prob(i,j)
% %             agent_sight(i,j)=world(i,j)*prob(i,j);
% %         else
% %             coin_flip=round(rand);
% %             if coin_flip==1
% %                 guessed_cost=freespace_cost;
% %             else guessed_cost=obstacle_cost;
% %             end
% %             agent_sight(i,j)=guessed_cost*prob(i,j);
% %         end
% % %         if agent_sight(i,j)<orig_agent_sight(i,j)
% % %             agent_sight(i,j)=orig_agent_sight(i,j);
% % %             
% % %         end
% %     end
% % end
 
if length(agent_pos_log)>2
for i=1:length(agent_pos_log)
    agent_sight(agent_pos_log(i,1),agent_pos_log(i,2))=orig_agent_sight(agent_pos_log(i,1),agent_pos_log(i,2));
end
end
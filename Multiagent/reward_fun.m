function [reward,action,fin_reward,world,agent_sight]=reward_fun(world,agent_pos,agent_sight,xy,obstacle_cost,gamma,update_fraction,agent_pos_log,exploration_reward,exp_freq,botnum,agent_poses)

%go through the 9 points around the bot, give the current position a -ve
%reward to mark that it has been visited
weighted_costs_x=0;
weighted_costs_y=0;
sum_costs=0;

for i=1:9
    next_pos=agent_motion(agent_pos,i,xy,world);
for j=1:9
    pos_reward(i,j) = agent_sight(agent_pos(1),agent_pos(2)) - norm(agent_pos-next_pos)+gamma*(agent_sight(next_pos(1),next_pos(2))-norm(next_pos-agent_motion(next_pos,j,xy,world)));% include rewards for being in that particular state, also include discounted rewards for being in the next state and for
end
    fin_reward(i)=min(pos_reward(i,:));%final reward for each state around the agent
end

%world(agent_pos(1),agent_pos(2))=world(agent_pos(1),agent_pos(2))+update_fraction*(obstacle_cost);
agent_sight(agent_pos(1),agent_pos(2))=agent_sight(agent_pos(1),agent_pos(2))+update_fraction*(obstacle_cost);
% agent_pos
% world
% agent_sight


unique_pos=unique(agent_pos_log,'rows');
% x_centr=agent_pos(2);%round(mean(unique_pos(:,2)));%x and y centroids
% y_centr=agent_pos(1);%round(mean(unique_pos(:,1)));
x_centr=round(mean(unique_pos(:,2)));%x and y centroids
y_centr=round(mean(unique_pos(:,1)));
scatter(x_centr,-y_centr,'m')
%To include surrounding cells for direction exploration
% % % s=size(unique_pos);
% % % k=1;
% % % for i=1:s(1)
% % %     for j=1:s(2)
% % %         for l=1:9
% % %             pos_log_all(k,:)=[agent_motion([i,j],l,xy,world)];
% % %             k=k+1;
% % %         end
% % %     end
% % % end
% % % 
% % % pos_log_all=unique(pos_log_all,'rows');
% % % unique_pos=pos_log_all;%includes all visited points and the points around them

for i=1:length(unique_pos)
    if length(unique_pos)>2
        u_p=unique_pos(i,:);
        weighted_costs_y=weighted_costs_y+(-u_p(1)+y_centr)*agent_sight(u_p(1),u_p(2));
        weighted_costs_x=weighted_costs_x+(-u_p(2)+x_centr)*agent_sight(u_p(1),u_p(2));
        sum_costs=sum_costs+agent_sight(u_p(1),u_p(2));
    end
end

if length(unique_pos)>2
    balance_x=length(unique_pos)*weighted_costs_x/sum_costs;
    balance_y=length(unique_pos)*weighted_costs_y/sum_costs;
else balance_x=x_centr;
    balance_y=y_centr;
end

%%%%%%%%%%%%%%%%%%%%For multiagents%%%%%%%%%%%%%%%%%%%%
% centr_dist=eucl_dist(balance_x,balance_y,x_centr,y_centr);
dir_angle=atan2((balance_y-y_centr),(balance_x-x_centr));
dir_step=(2*pi)/length(agent_poses);
r=eucl_dist(x_centr,y_centr,balance_x,balance_y);
for i=1:length(agent_poses)
    fake_balance_pt(i,:)=[x_centr+r*cos(dir_angle+dir_step*(i-1)) y_centr+r*sin(dir_angle+dir_step*(i-1))];
end
balance_x=fake_balance_pt(botnum,1);
balance_y=fake_balance_pt(botnum,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% scatter(balance_x,balance_y,'m')
for i=1:9
    moved_pos=agent_motion(agent_pos,i,xy,world);
    balance_dist(i)=eucl_dist(moved_pos(1),moved_pos(2),balance_y,balance_x);
end


min_balance_dir=find(balance_dist==min(balance_dist));
if length(min_balance_dir)>1
    min_balance_dir=min_balance_dir(randi(length(min_balance_dir)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% fin_reward(min_balance_dir)=fin_reward(min_balance_dir)-(exploration_reward*min(balance_dist));
% reward=min(fin_reward);
% action=find(fin_reward==reward);
% action=action(randi(length(action)));

if rand>exp_freq
    exploration_reward=0;
end
% agent_pos
% balance_x
% balance_y
% x_centr
% y_centr
% pause

for i=1:9
%     eucl_dist(balance_x,balance_y,x_centr,y_centr)
%     fr(i)=fin_reward(i)+exploration_reward*eucl_dist(balance_x,balance_y,x_centr,y_centr)/balance_dist(i);
%     fr(i)=fin_reward(i)+exploration_reward*eucl_dist(balance_x,balance_y,x_centr,y_centr)/balance_dist(i);
    fr(i)=fin_reward(i)+exploration_reward*eucl_dist(balance_x,balance_y,x_centr,y_centr)/balance_dist(i);
%         fr(i)=fin_reward(i)+exploration_reward*eucl_dist(balance_x,balance_y,agent_pos(2),agent_pos(1))/balance_dist(i);

end

reward=min(fr);
action=find(fr==min(fr));
action=action(randi(length(action)));

% 
% 
% action=randi(9);
% if rand>exp_freq
%     action=randi(9);
% end
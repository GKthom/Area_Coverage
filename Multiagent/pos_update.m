function [agent_pos,reward,fin_reward,world,action,agent_sight]=pos_update(botnum,agent_sight,agent_poses,world,xy,obstacle_cost,gamma,update_fraction,agent_pos_log,exploration_reward,exp_freq)
agent_pos=agent_poses{botnum};

%Add features like space classification, temporal memory, discount rate,
%exploration vs exploitation


[reward,action,fin_reward,world,agent_sight]=reward_fun(world,agent_pos,agent_sight,xy,obstacle_cost,gamma,update_fraction,agent_pos_log,exploration_reward,exp_freq,botnum,agent_poses);%Reward for finding food, penalty for hitting obstacles, penalty for energy wastage


next_pos=agent_motion(agent_pos,action,xy,world);
agent_pos=next_pos;

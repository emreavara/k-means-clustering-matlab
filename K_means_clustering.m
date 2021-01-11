clc 
clear all

number_of_individuals = 60;
range = 10;  
cluster_centers = [5 0 ; -2 -4 ; 2 4];
group=zeros(number_of_individuals,2);

group_1=[];
group_2=[];
group_3=[];
group_1_values=zeros(number_of_individuals,2);
group_2_values=zeros(number_of_individuals,2);
group_3_values=zeros(number_of_individuals,2);

% initilization of group

for i=1:3
    for j=1:number_of_individuals/3
        group((i-1)*number_of_individuals/3+j,1)= rand(1,1)*range + cluster_centers(i,1);
        group((i-1)*number_of_individuals/3+j,2)= rand(1,1)*range + cluster_centers(i,2);
    end
end

% plot(group(:,1),group(:,2),'or')
hold on


% creation of arbitrary centers 

new_centers = [randi([-2,6],1) randi([-2,10],1); randi([-2,10],1) randi([-2,10],1); randi([-2,10],1) randi([-2,10],1)];
plot(new_centers(:,1),new_centers(:,2),'*g')
hold on

% test groups for iteration

group_old=zeros(3,number_of_individuals);
group_new=zeros(3,number_of_individuals);
distances=zeros(3,number_of_individuals);


counter_iterations=0;

while(1)
    
    % calculation of distances
    % euclidean distances
    for i=1:3
        for j=1:number_of_individuals
%             distances(i,j)=euclidean_distance_f(new_centers(i,1),new_centers(i,2),group(j,1),group(j,2));
              distances(i,j)=sqrt(power((new_centers(i,1)-group(j,1)),2) + power((new_centers(i,2)-group(j,2)),2));
        end
    end

 
    min_value=0;
    for i=1:number_of_individuals
            min_value=min([distances(1,i) distances(2,i) distances(3,i)]);
            if(min_value==distances(1,i))
                distances(1,i)=1;
                distances(2,i)=0;
                distances(3,i)=0;
            elseif (min_value==distances(2,i))
                distances(1,i)=0;
                distances(2,i)=1;
                distances(3,i)=0;
            elseif (min_value==distances(3,i))
                distances(1,i)=0;
                distances(2,i)=0;
                distances(3,i)=1;
            end
    end
    
    group_new = distances % the new group to compare with old group
    
    group_1=distances(1,:) ;
    group_2=distances(2,:) ;
    group_3=distances(3,:) ;
    
    sum_x=0; % sum to find average value for centers 1
    sum_y=0;
    counter=0;
    
    for i=1:number_of_individuals
        if group_1(i)==1
            sum_x=sum_x+group(i,1);
            sum_y=sum_y+group(i,2);
            counter=counter+1;
        end
    end
    
    new_centers(1,1)=sum_x/counter;
    new_centers(1,2)=sum_y/counter;


    sum_x=0; % sum to find average value for centers 2
    sum_y=0;
    counter=0;
    
    for i=1:number_of_individuals
        if group_2(i)==1
            sum_x=sum_x+group(i,1);
            sum_y=sum_y+group(i,2);
            counter=counter+1;
        end
    end
    
    new_centers(2,1)=sum_x/counter;
    new_centers(2,2)=sum_y/counter;

    sum_x=0; % sum to find average value for centers 3
    sum_y=0;
    counter=0;
    
    for i=1:number_of_individuals
        if group_3(i)==1
            sum_x=sum_x+group(i,1);
            sum_y=sum_y+group(i,2);
            counter=counter+1;
        end
    end
    
    new_centers(3,1)=sum_x/counter;
    new_centers(3,2)=sum_y/counter;
    
    if (group_old == group_new)
        break
    else
        group_old=group_new
    end
    counter_iterations=counter_iterations+1;
end

for i=1:number_of_individuals
        if group_new(1,i)==1
            group_1_values(i,1)=group(i,1);
            group_1_values(i,2)=group(i,2);
        end
end

for i=1:number_of_individuals
        if group_new(2,i)==1
            group_2_values(i,1)=group(i,1);
            group_2_values(i,2)=group(i,2);
        end
end

for i=1:number_of_individuals
        if group_new(3,i)==1
            group_3_values(i,1)=group(i,1);
            group_3_values(i,2)=group(i,2);
        end
end


counter_iterations

plot(group_1_values(:,1),group_1_values(:,2),'or')
hold on
plot(group_2_values(:,1),group_2_values(:,2),'ob')
hold on
plot(group_3_values(:,1),group_3_values(:,2),'og')
hold on
plot(0,0,'ow')
hold on


plot(new_centers(:,1),new_centers(:,2),'*b')
hold on

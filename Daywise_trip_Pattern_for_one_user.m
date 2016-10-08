fid=fopen('gps.csv'); % input file
b = [];%matrix going to create.
j = 1;

%convert text line into matix form
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break
    end
    
    a=[];
    k=1;
    f=0;
    for i = 1:length(tline)
        if(tline(i)==9 && f==0)
            b(j,k)=str2double(a);
            k = k+1;
            a=[];
            f = 1;
        else if (tline(i)==9 && f==1)
                b(j,k)=NaN;
                k = k+1;
                f = 2;
            else if (tline(i)==9 && f==2)
                    f = 1;
                else
                    a=strcat(a,tline(i));
                    f = 0;
                end
            end
        end
    end
    b(j,k)=str2double(a);
    j = j+1;
end
fclose(fid);

%Subset only the required columns
a=b;
a(:,8:16)=[];
a(:,3:5)=[];
d=[];

%convert the time
for i=1:length(a);
    unix_time=a(i,2);
    unix_epoch = datenum(1970,1,1,0,0,0);
    matlab_time = unix_time/86400 + unix_epoch;
    d(i,1)=matlab_time;
end;
gps=[a(:,1) d a(:,3:4)];
c=[];
j=2;
c(1,1)=0;

% For each data point find the nearest locaiton of it
for i=1:length(gps);    %EDIT STARTED
   if ((gps(i,3)>6.558 && gps(i,3)<6.562) && (gps(i,4)>46.508 && gps(i,4)<46.512)),
       if c((j-1),1)==1;
       else c(j,1)=1;c(j,2)=gps(i,2);
           j=j+1;
       end;
   else if ((gps(i,3)>6.563 && gps(i,3)<6.567) && (gps(i,4)>46.519 && gps(i,4)<46.523)),
           if c((j-1),1)==2;
           else c(j,1)=2;c(j,2)=gps(i,2);
               j=j+1;
           end;
       else if ((gps(i,3)>6.107 && gps(i,3)<6.111) && (gps(i,4)>46.228 && gps(i,4)<46.232)),
               if c((j-1),1)==3;
               else c(j,1)=3;c(j,2)=gps(i,2);
                   j=j+1;
               end;
            
else if ((gps(i,3)>6.604 && gps(i,3)<6.608) && (gps(i,4)>46.535 && gps(i,4)<46.539)),
               if c((j-1),1)==4;
               else c(j,1)=4;c(j,2)=gps(i,2);
                   j=j+1;
               end;
               else if ((gps(i,3)>6.602 && gps(i,3)<6.606) && (gps(i,4)>46.521 && gps(i,4)<46.525)),
                       if c((j-1),1)==5;
                       else c(j,1)=5;c(j,2)=gps(i,2);
                           j=j+1;
                       end;
                   else if ((gps(i,3)>6.911 && gps(i,3)<6.918) && (gps(i,4)>46.477 && gps(i,4)<46.481)),
                           if c((j-1),1)==6;
                           else c(j,1)=6;c(j,2)=gps(i,2);
                               j=j+1;
                           end;
                           else if ((gps(i,3)>6.598 && gps(i,3)<6.602) && (gps(i,4)>46.526 && gps(i,4)<46.530)),
                           if c((j-1),1)==7;
                           else c(j,1)=7;c(j,2)=gps(i,2);
                               j=j+1;
                           end;
                           
                           else if ((gps(i,3)>6.631 && gps(i,3)<6.635) && (gps(i,4)>46.521 && gps(i,4)<46.525)),
                           if c((j-1),1)==8;
                           else c(j,1)=8;c(j,2)=gps(i,2);
                               j=j+1;
                           end;
                           
                           else if ((gps(i,3)>6.630 && gps(i,3)<6.634) && (gps(i,4)>46.518 && gps(i,4)<46.522)),
                           if c((j-1),1)==9;
                           else c(j,1)=9;c(j,2)=gps(i,2);
                               j=j+1;
                           end;
                           
                           else if ((gps(i,3)>6.623 && gps(i,3)<6.627) && (gps(i,4)>46.504 && gps(i,4)<46.508)),
                           if c((j-1),1)==10;
                           else c(j,1)=10;c(j,2)=gps(i,2);
                               j=j+1;
                           end;
                           
                           else if ((gps(i,3)>7.046 && gps(i,3)<6.050) && (gps(i,4)>46.139 && gps(i,4)<46.143)),
                           if c((j-1),1)==11;
                           else c(j,1)=11;c(j,2)=gps(i,2);
                               j=j+1;
                           end;
                       else
                       end;
                   end
               end;
           end;
           end;
   end;
end;
end;
end;
       end;
   end;
end;

%EDIT END
n=[c(:,1) datenum(datestr(c(:,2),1))];
m=[];
m(1,1)=n(2,2);
j=2;
k=1;
for i=2:length(n);
    if n(i,2)==m(k,1);
        m(k,j)=n(i,1);
        j=j+1;
    else
        k=k+1;
        m(k,1)=n(i,2);
        j=3;
        m(k,2)=n(i,1);
    end;
end;
p=[];
j=size(m);
p=[(m2xdate(m(:,1))) m(:,2:j(1,2))];
xlswrite('TripPatternDaywise.xls',p);

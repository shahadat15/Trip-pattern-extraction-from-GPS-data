fid=fopen('gps.csv'); %input file
b = [];%matrix going to create.
j = 1;

% process text line into matrix
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
a=b;
a(:,8:16)=[];
a(:,3:5)=[];
d=[];

% convert the time format
for i=1:length(a);
    unix_time=a(i,2);
    unix_epoch = datenum(1970,1,1,0,0,0);
    matlab_time = unix_time/86400 + unix_epoch;
    d(i,1)=matlab_time;
end;
gps=[a(:,1) d a(:,3:4)];

%convert the date
g=datenum(datestr(gps(1,2),2));
l=datenum(datestr((gps(size(gps,1),2)),2));
for m=g:l,
h=gps(find(gps(:,2)>=m & gps(:,2)<m+1),:);
if h>0;
    n=[];
    o=size(h);
    n=[h(:,1) (m2xdate(h(:,2))) h(:,3:o(1,2))];
    xlswrite(datestr(m),n);h=[];n=[];
end;
end;

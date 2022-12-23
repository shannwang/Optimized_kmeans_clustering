function ishwd=is_holiday_weekend(date)

% check if a date is a public holiday or not
holidays(1)=datetime([2017,1,1],'Format','eee dd-MMM-yyyy'); % new year's day
holidays(2)=datetime([2017,4,17],'Format','eee dd-MMM-yyyy'); % Easter Monday
holidays(3)=datetime([2017,5,1],'Format','eee dd-MMM-yyyy'); % Labour Day
holidays(4)=datetime([2017,5,25],'Format','eee dd-MMM-yyyy'); % Ascension Day
holidays(5)=datetime([2017,6,5],'Format','eee dd-MMM-yyyy'); % Whit Monday
holidays(6)=datetime([2017,10,3],'Format','eee dd-MMM-yyyy'); % Day of German Unity
holidays(7)=datetime([2017,10,31],'Format','eee dd-MMM-yyyy'); % Reformation Day
holidays(8)=datetime([2017,12,25],'Format','eee dd-MMM-yyyy'); % Christmas
holidays(9)=datetime([2017,12,26],'Format','eee dd-MMM-yyyy'); % Second Day of Christmas
holidays(10)=datetime([2017,6,15],'Format','eee dd-MMM-yyyy'); % Corpus Christi
holidays(11)=datetime([2017,11,1],'Format','eee dd-MMM-yyyy'); % All Saints' Day
holidays(12)=datetime([2016,12,25],'Format','eee dd-MMM-yyyy'); % Christmas
holidays(13)=datetime([2016,12,26],'Format','eee dd-MMM-yyyy'); % Second Day of Christmas


iswd=isweekend(date);
for i=1:length(holidays)
    ishd=isbetween(date,holidays(i),holidays(i));
    if ishd==1
        break;
    end
end
ishwd=(iswd||ishd);


end
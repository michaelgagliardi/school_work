#provides system specifics

#needed to make web requests
import requests

#store the data we get as a dataframe
import pandas as pd

#convert the response as a strcuctured json
import json

#mathematical operations on lists

#parse the datetimes we get from NOAA
from datetime import datetime
# convert the response as a strcuctured json
import json
# parse the datetimes we get from NOAA
from datetime import datetime

# store the data we get as a dataframe
import pandas as pd
# needed to make web requests
import requests

# mathematical operations on lists

#add the access token you got from NOAA
Token = 'QbUfrFiAhMCQJpobnyrIDvnbDycnanjZ'

#Long Beach Airport station
station_id = 'GHCND:USW00023129'

# Amherst Station
# station_id = 'GHCND:USC00190120'


# initialize lists to store data
dates_temp = []
dates_prcp = []

class QuestionThree(object):
    def highest_temp(self, alist):
        m = max(alist) ##finding max of list
        y = alist.index(m) ##finding index from list

        return m, y ##returning the two values

        """"
        This function receives an array of max. temperature data from a specified period
        and returns the highest temperature (highest T) in that period and the index on the array
        when that highest temperature occurred.
        :param alist: list with max. temp. data
        :return: highest temp and the index
        """

    def lowest_temp(self, alist):
        m = min(alist)
        y = alist.index(m)

        return m, y ##returning the two values
        """
        Similar to the previous method, this function receives an array with min. temp. data
        from a specific period and returns the lowest temp. (lowest T) and the index
        when this lowest temp. occurred.
        :param alist: list with min. temp. data
        :return: lowest temp. and the index
        """

    def average_high(self, alist):
        m= sum(alist)/len(alist) ##finding average
        return m
        """
        This function receives an array with max. temp. data from a specific period and
        returns the average temp.
        :param alist: list with max. temp. data
        :return: average max. temp.
        """

    def average_low(self, alist):
        m= sum(alist)/len(alist) ##finding average
        return m
        """
        This function receives an array with min. temp. data from a specific period and
        returns the average temp.
        :param alist: list with min. temp. data
        :return: average min. temp.
        """

# DO NOT MODIFY  THE CODE BELOW!!!!!!
def GetTemps(startyear, endyear, type):
    dates_temp = []
    tempsmax = []
    tempsmin = []
    for year in range(startyear, endyear):
        year = str(year)
        print('working on year ' + year)
        for type in type:
            print('working on Type:' + type)
            # make the api call
            r = requests.get(
                'https://www.ncdc.noaa.gov/cdo-web/api/v2/data?datasetid=GHCND&datatypeid=' + type + '&limit=1000&stationid=GHCND:USC00190120&startdate=' + year + '-01-01&enddate=' + year + '-12-31',
                # 'https://www.ncdc.noaa.gov/cdo-web/api/v2/data?datasetid=PRECIP_15&stationid=COOP:010008&units=metric&startdate=2010-05-01&enddate=2010-05-31',
                headers={'token': Token})
            # load the api response as a json
            d = json.loads(r.text)
            print(d)
            if type == 'TMAX':
                # get all items in the response which are average temperature readings
                max_temps = [item for item in d['results'] if item['datatype'] == 'TMAX']
                # get the date field from all average temperature readings
                dates_temp += [item['date'] for item in max_temps]
                # get the actual average temperature from all average temperature readings
                tempsmax += [item['value'] for item in max_temps]
                print(tempsmax)
            elif type == 'TMIN':
                # get all items in the response which are average temperature readings
                min_temps = [item for item in d['results'] if item['datatype'] == 'TMIN']
                # get the date field from all average temperature readings
                dates_temp += [item['date'] for item in min_temps]
                # get the actual average temperature from all average temperature readings
                tempsmin += [item['value'] for item in min_temps]
                print(tempsmin)
            else:
                print('Datatype not supported!!!')
    return tempsmax, tempsmin, dates_temp

maxTemps, minTemps, datesTemp = GetTemps(2010,2011,['TMAX', 'TMIN'])

statistics = QuestionThree()
max, maxindex = statistics.highest_temp(maxTemps)
min, minindex = statistics.lowest_temp(minTemps)
print('Max:', max , maxindex, ' Min:', min, minindex)
avg_max = statistics.average_high(maxTemps)
avg_min = statistics.average_low(minTemps)
print("Average high:", avg_max, " Average low:", avg_min)

#initialize dataframe
df_temp = pd.DataFrame()

#populate date and average temperature fields (cast string date to datetime and convert temperature from tenths of Celsius to Fahrenheit)
df_temp['date'] = [datetime.strptime(d, "%Y-%m-%dT%H:%M:%S") for d in dates_temp]
df_temp['avgTemp'] = [float(v)/10.0*1.8 + 32 for v in maxTemps]

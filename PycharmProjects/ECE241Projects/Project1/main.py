import numpy as np
import pandas as pd

class COV19Library:
    def __init__(self):
        self=self
    class City:
        def __init__(self, cid, cname, cstate, pop, cities):
            self.cid = cid
            self.cname = cname
            self.cstate = cstate
            self.pop = pop
            self.cities = cities
        def __str__(self):
            return (str(self.cid),str(self.cname),str(self.cstate),str(self.pop),str(self.cities))
    def LoadData(self, filename: str):
        self.filename=filename
        if filename == "cov19_city":
            df = pd.read_csv("/Users/michaelgagliardi/Documents/Sophomore Year/ECE 241/cov19_city.csv")
            city_ids = df['City_ID']
            city_name_states = df['City State']
            city_pops = df['POP10']
            cities = df['HHD10']
            ids = []
            name_states =[]
            pops = []
            hhd10 = []
            ids.append(city_ids)
            name_states.append(city_name_states)
            pops.append(city_pops)
            hhd10.append(cities)
            print(df)
        else:
            print("file not found")
    def linearSearch(self, city: str, attribute: str):
        self.city = city
        self.attribute = attribute
        if attribute == "id":
            x = input("Enter city ID:")




city = [int(ele) if ele.isdigit() else ele for ele in city]

a = COV19Library()
a.LoadData("cov19_city")


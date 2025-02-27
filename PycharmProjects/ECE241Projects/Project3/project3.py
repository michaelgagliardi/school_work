import numpy as np ##importing numpy for arrays
import matplotlib.pyplot as plt ##importing matplotlib for plotting
import sklearn.linear_model as sk ##importing sklearn for regression
import sklearn.metrics as skm ##importing sklearn for mse

class Town: #initializing class town to interpret given data
    def __init__(self, info):
        tokens = info.split(',') ##splitting the two columns on a comma
        self.pop = tokens[0] ##first column is population
        self.prof = tokens[1] ##second column is profit
        self.pop = float(self.pop) ##converting to float
        self.prof = float(self.prof)

class WalmartData: ##initializing walmart data class
    def __init__(self):
        self.towns = list() #creating a list of towns with both population and profit
        self.pops = list() #list with just population
        self.profs = list() #list with just profit
    def LoadData(self,filename): ##loading data
        with open(filename, 'r') as file:
            for line in file.readlines():
                town=Town(line)
                self.towns.append(town) #appending each line as a town in the towns list
                self.pops.append(town.pop) #appending the populations into the population list
                self.profs.append(town.prof) #appending the profits into the profit list
            self.np_pops = np.array(self.pops) ##converting to numpy array
            self.np_profs = np.array(self.profs) ##conveerting to numpy array
    def plot(self,pops = None): #plot command
        x = self.np_pops.reshape((-1,1)) ##reshaping for plotting, making it a 2D array
        y = self.np_profs #assigning variable
        plt.scatter(x,y) #plotting scatterplot
        model = sk.LinearRegression().fit(x,y) #modeling using linear regression
        m = float(model.coef_) #finding slope of trendline
        b = model.intercept_ #intercept of trendline
        y1 = np.array([m*self.np_pops+b]).flatten() #y values of trendline using population values, slope, and intercept
        plt.plot(x,y1) #plotting trendline
        plt.xlabel('Population (in 10,000)')
        plt.ylabel('Profit (in $10,000)')
        plt.title('Population vs. Profit for Walmart Locations')
        plt.show() #showing plot

        if pops != None: #if user inputs a list of populations
            pops = np.array(pops).reshape(-1,1) #reshaping and converting to np array
            y2 = model.predict(pops) #predicting profit based off model
            print('Predicted Profit of inputted list of populations:\n',y2) ##printing predicted profit
            y3 = model.predict(x) ##predicting profits for the entire population list using model
            mse = skm.mean_absolute_error(y, y3, multioutput='raw_values') #calculating mean square error
            print('Mean Square Error of Prediction Model: ',float(mse)) #printing preditction mse


##Question 1 D
##The line of regression is linear and appears to follow the positive correlation between population and proft fairly well.
##The error appears to be the greatest between x values of 5 and 7, where profit and population show generally little
##correlation. However, the error definietly decreases as the value of x decreases. A linear model looks like the best fit.

##Question 1 F
##The model appears to be fairly accurate, with a Mean Square Error of 2.19424, which is pretty good, considering the data
##and generally low correlation between population and profit between population values of 50,000 and 70,000.


if __name__=='__main__':
    townlib = WalmartData()
    townlib.LoadData('walmart_data.txt')
    x2 = [7.8,4.4,4.7,6.12,8.55,6.7,9.8,7.01]
    townlib.plot(x2)


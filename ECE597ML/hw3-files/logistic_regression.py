import numpy as np

def logistic(z):
    """
    The logistic function
    Input:
       z   numpy array (any shape)
    Output:
       p   numpy array with same shape as z, where p = logistic(z) entrywise
    """
    
    # REPLACE CODE BELOW WITH CORRECT CODE
    p = 1 / (1 + np.exp(-z))
    return p

def cost_function(X, y, theta):
    """
    Compute the cost function for a particular data set and hypothesis (weight vector)
    Inputs:
        X      data matrix (2d numpy array with shape m x n)
        y      label vector (1d numpy array -- length m)
        theta  parameter vector (1d numpy array -- length n)
    Output:
        cost   the value of the cost function (scalar)
    """
    
    # REPLACE CODE BELOW WITH CORRECT CODE
    m,n = X.shape
    h = logistic(np.dot(X, theta))
    cost = -np.sum(y*np.log(h) + (1-y)*np.log(1-h))
    return cost

def gradient_descent( X, y, theta, alpha, iters ):
    """
    Fit a logistic regression model by gradient descent.
    Inputs:
        X          data matrix (2d numpy array with shape m x n)
        y          label vector (1d numpy array -- length m)
        theta      initial parameter vector (1d numpy array -- length n)
        alpha      step size (scalar)
        iters      number of iterations (integer)
    Return (tuple):
        theta      learned parameter vector (1d numpy array -- length n)
        J_history  cost function in iteration (1d numpy array -- length iters)
    """

    # REPLACE CODE BELOW WITH CORRECT CODE
    m,n = X.shape
    J_history = np.zeros(iters)
    for i in range(iters):
        theta -= (alpha/m) * np.dot(X.T, (logistic(np.dot(X, theta))-y))
        J_history[i] = cost_function(X, y, theta)
    return theta, J_history
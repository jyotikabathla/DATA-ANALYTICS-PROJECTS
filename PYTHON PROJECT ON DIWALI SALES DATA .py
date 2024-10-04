#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
import seaborn as sns


# In[5]:


#import file df = pd.read_csv("dDiwali Sales Data11.csv")
df = pd.read_csv("diwali sales data112.csv")


# In[6]:


df


# In[7]:


df.shape


# In[8]:


df.head(10)


# In[9]:


df.tail(10)


# In[10]:


df.info()


# In[11]:


df.drop(['Status','unnamed1'], axis=1, inplace=True)


# In[12]:


#check for null values
pd.isnull(df).sum()


# In[13]:


df.dropna(inplace=True)#drop null values


# In[14]:


df["Amount"]=df["Amount"].astype('int')


# In[15]:


df["Amount"].dtypes


# In[16]:


df.columns


# In[17]:


df.describe


# In[18]:


df[['Age', 'Orders','Amount']].describe


# In[19]:


#EXPLORATORT DATA ANALYSIS 
#PLOTING BAR CHART FOR  ORDERS
ax = sns.countplot(x  = 'Gender' ,data = df) 




# In[21]:


ax = sns.countplot(data = df, x =  "Age Group"  , hue= 'Gender')

for bars in ax.containers:
    ax.bar_labels(bars)


# In[26]:


sales_gen = df.groupby(['Gender'], as_index=False)["Amount"].sum().sort_values(by="Amount",ascending=False)

sns.barplot(x = "Gender", y = "Amount", data= sales_gen)


# In[27]:


sales_age = df.groupby(["Age Group"], as_index= False)["Amount"].sum().sort_values(by="Amount", ascending=False)
sns.barplot(x="Age Group", y= "Amount", data= sales_age)


# In[32]:


Sales_state = df.groupby(["State"], as_index= False)["Orders"].sum().sort_values(by = "Orders", ascending= False).head(10)
sns.set(rc={"figure.figsize":(15,5)})
sns.barplot(data = Sales_state, x ="State", y = "Orders")


# In[33]:


Sales_state = df.groupby(["State"], as_index= False)["Amount"].sum().sort_values(by = "Amount", ascending= False).head(10)
sns.set(rc={"figure.figsize":(15,5)})
sns.barplot(data = Sales_state, x ="State", y = "Amount")


# In[37]:


ax  = sns.countplot(data = df, x = "Marital_Status")

sns.set(rc= {"figure.figsize":(7,5)}) 
for bars in ax.containers:
    ax.bar_label(bars)


# In[39]:


sns.set(rc={"figure.figsize":(20,5)})
ax =sns.countplot(data = df , x = "Occupation")
for bars in ax.containers:
    ax.bar_label(bars)


# In[40]:


sns.set(rc={"figure.figsize":(20,5)})
ax =sns.countplot(data = df , x = "Product_Category")
for bars in ax.containers:
    ax.bar_label(bars)


# In[42]:


Sales_state = df.groupby(["Product_Category"], as_index= False)["Amount"].sum().sort_values(by = "Amount", ascending= False).head(10)
sns.set(rc={"figure.figsize":(20,5)})
sns.barplot(data = Sales_state, x ="Product_Category", y = "Amount")


# In[43]:


Sales_state = df.groupby(["Product_Category"], as_index= False)["Orders"].sum().sort_values(by = "Orders", ascending= False).head(10)
sns.set(rc={"figure.figsize":(20,5)})
sns.barplot(data = Sales_state, x ="Product_Category", y = "Orders")


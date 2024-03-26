# Revolutionizing Cash Flow Forecasts - A Paradigm Shift in Purchase and Redemption Predictions

<p align="center">
  <img src="https://www.freshbooks.com/wp-content/uploads/2021/09/cash-inflow-vs-outflow.jpg" alt="Image" width="700" height="400">
</p>

## Background

> The investment funds of Yu'ebao are mainly used to purchase short-term, low-risk money market funds. These funds mainly invest in low-risk investment instruments such as government bonds, central bank bills, and bank deposits. Therefore, the risk is relatively low, making it suitable for users who have short-term capital management needs and are more conservative in their investment preferences.
>
> The main source of income for Yu'ebao comes from the money market fund it invests in. Investors can check their daily earnings through the Alipay app and withdraw funds to their Alipay account at any time for use. However, it should be noted that since money market funds are market investments, their returns are not stable and may be affected by factors such as market interest rates and economic conditions, which pose certain investment risks. When using Yu'ebao, investors should carefully understand the product's risk and return characteristics, and make wise investment decisions based on their own risk tolerance and investment goals. At the same time, the earnings of Yu'ebao are also subject to regulatory policies and product regulations, and investors should pay close attention to changes in relevant policies and regulations.

### Project Overview

Ant Financial Services Group (AFSG) manages the cash inflow and outflow of millions of members. Accurately predicting future cash flows based on historical data is vital to AFSG's operations. This project aims to leverage machine learning techniques to forecast future cash flows by analyzing users' historical purchase and redemption data. The insights gained will empower AFSG to enhance its funds management capabilities, ensuring efficient cash flow management.

### Project Objectives

1. **Cash Flow Forecasting:** Develop machine learning models to predict future cash inflows (purchases) and outflows (redemptions) based on historical user transaction data.
2. **Enhanced Funds Management:** Provide AFSG with actionable insights to optimize its funds management strategies and decision-making.
3. **Business Efficiency:** Improve operational efficiency by aligning cash inflow and outflow predictions with actual user behavior.

### Impact & Expected Results

#### Potential benefits

If we can accurately predict the daily inflows and outflows of currency funds such as Yu'EBao, it can bring the following potential benefits:

1. **Optimization of investment decisions:** Accurate predictions of fund inflows and outflows can help investors better understand market demand and redemption situations, thereby optimizing capital allocation and investment decisions. For example, if large inflows are predicted, investors can increase their subscription amount in a timely manner; if large outflows are predicted, investors can consider adjusting their redemption plan to avoid possible market risks.
2. **Improve capital operation efficiency:** Accurately predicting the inflow and outflow of funds can help fund managers better plan and manage funds, thereby improving capital operation efficiency. For example, based on the predicted results, a reasonable fund investment plan can be arranged to avoid the situation of idle or insufficient funds, thus maximizing the return and utilization of funds.
3. **Reduce risks:** The inflow and outflow of funds are crucial for the stable operation of currency funds. Accurate predictions can avoid potential risks caused by unstable inflows and outflows, such as redemption pressure and insufficient funds. At the same time, it can also help investors better cope with market volatility and risks, and make wiser investment decisions.
4. **Enhance competitive advantages:** Accurately predicting fund inflows and outflows can help financial institutions better understand market demand and investor behavior, thereby optimizing product design and service strategies, and enhancing competitive advantages. For example, based on predicted results, product subscription and redemption rules can be flexibly adjusted to attract more investors, increase fund size and management fee income.

#### Submission

| Attribute   | Type   | Description                     | Example  |
| ----------- | ------ | ------------------------------- | -------- |
| report_date | bigint | Date                            | 20140901 |
| purchase    | bigint | Prediction Amount of Purchase   | 40000000 |
| redeem      | bigint | Prediction Amount of Redemption | 30000000 |

### Description & Data inspection

#### 1. User profile table

We randomly selected a total number of 30,000 users. Those who appeared in September 2014 for the first time have been put into the test data set. So that the training data set includes about 28,000 users. The attributes info is shown in table 1:

**Table 1: User profile table: user_profile_table**

| Attribute     | Type   | Description                  | Example     |
| ------------- | ------ | ---------------------------- | ----------- |
| user_id       | bigint | User ID                      | 1234        |
| Sex           | bigint | Gender (1: male, 0: female)  | 0           |
| City          | bigint | Which city the user lives in | 6081949     |
| Constellation | string | Constellation                | Sagittarius |

#### 2. Purchase and redemption sheet

It contains about 2.8 million records, which include the purchase and redemption behaviors during 2013.07.01-2014.08.31, and the information of all sub categories. The data has been desensitized on the premise of basically keeping the original trend. The data includes operation time and operation record (in both purchase and redemption). Amount is measured by fen (i.e. CNY 0.01). If consume_amt  = 0, the catogory1 to catogory4 are null.

**Table 2: Purchase andredemption sheet: user_balance_table**

| Attribute           | Type   | Description                                                  | Example  |
| ------------------- | ------ | ------------------------------------------------------------ | -------- |
| user_id             | bigint | User ID                                                      | 1234     |
| report_date         | string | Date                                                         | 20140407 |
| tBalance            | bigint | Today' s closing balance                                     | 109004   |
| yBalance            | bigint | Yesterday's closing balance                                  | 97389    |
| total_purchase_amt  | bigint | Today total purchase = direct purchase + revenue             | 21876    |
| direct_purchase_amt | bigint | Today's direct purchase                                      | 21863    |
| purchase_bal_amt    | bigint | Today's purchase from Alipay balance                         | 0        |
| purchase_bank_amt   | bigint | Today's purchase from bank cards                             | 21863    |
| total_redeem_amt    | bigint | Today's total redemption amount = consumption + transfer amount | 10261    |
| consume_amt         | bigint | Today's total consumption                                    | 0        |
| transfer_amt        | bigint | Toda y ' s total transfer amount                             | 10261    |
| tftobal_amt         | bigint | Today's total transfer amount to Alipay balance              | 0        |
| tftocard_amt        | bigint | Today's total transfer amount into bank cards                | 10261    |
| share_amt           | bigint | Today's revenue                                              | 13       |
| category1           | bigint | Today's consumption for category 1                           | 0        |
| category2           | bigint | Today's consumption for category 2                           | 0        |
| category3           | bigint | Today's consumption for category 3                           | 0        |
| category4           | bigint | Today's consumption for category 4                           | 0        |

Note1: The above data has been desensitized. Revenue has been recalculated through as implified calculation approach. We describe it in Section 4.

Note2: The desensitized data ensures that: today's closing balance = yesterday's closing balance + today's total purchase - today's total redemption. There is no negative value.

#### 3. Yields ratetable

Yields rate table includes rate of revenue of Yu 'E Bao within 14 months. Detailed descriptions are shown in table 3:

**Table 3: mfd_day_share_interest**

| Attribute        | Type   | Description               | Example  |
| ---------------- | ------ | ------------------------- | -------- |
| mfd_date         | string | Date                      | 20140102 |
| mfd_daily_yield  | double | Revenue per 1000,000 fen  | 1.5787   |
| mfd_7daily_yield | double | 7-Day Annualized Yield(%) | 6.307    |

#### 4. Shanghai Interbank Offered Rate (Shibor) Table

Shanghai Interbank offered rate table includes 14-month lending rates per day among banks (all are annualized rates). Detailed descriptions are shown in table 4:

**Table 4 : mdf_bank_shilbor**

| Attribute      | Type   | Description          | Example  |
| -------------- | ------ | -------------------- | -------- |
| mfd_date       | string | Date                 | 20140102 |
| Interest _ O_N | double | Overnight SHIBOR (%) | 2.8      |
| Interest _ 1_W | double | 1-week SHIBOR (%)    | 4.25     |
| Interest _ 2_W | double | 2-week SHIBOR (%)    | 4.9      |
| Interest _ 1_M | double | 1-monthSHIBOR (%)    | 5.04     |
| Interest _ 3_M | double | 3-monthSHIBOR (%)    | 4.91     |
| Interest _ 6_M | double | 6-monthSHIBOR (%)    | 4.79     |
| Interest _ 9_M | double | 9-monthSHIBOR (%)    | 4.76     |
| Interest _ 1_Y | double | 1-YearSHIBOR (%)     | 4.78     |

### Evaluation 

We expect to gain accurate forecasting of the daily amount of purchase and redemption in the next 30 days. The higher accuracy is preferred. However, we need to take different situations into account. For instance, some participants may have a result that shows 29 days’ accurate predictions but one day’s inaccurate prediction. Some participants may have a result that 30 days’ predictions are not accurate enough, with an average error of delta (delta is some small value). Adopt absolute error as the evaluation metric may result in a poorer score for the former than that of the latter. However, we prefer the model of the former in the real-world business. Therefore, we use the following evaluation metric. The final score-counting method is given as follows: We use the relative error of purchase and redemption to compute the daily score based on a scoring function. Then, summarize the daily scores. Finally the scores are weighted according to the factors of real-world business. We provide the details of the evaluation metric as follows.

1) Calculating the relative error of purchase and redemption:



![img](https://gtms03.alicdn.com/tps/i3/TB1z6RVHVXXXXb1XXXX0yWmWVXX-525-141.png)

2) The scoring function f(*) (monotonous decreasing) is used to evaluate the purchase and redemption error. Purchase prediction score is related to the error Purchase i ; so does redemption. For example, if the purchase error $Purchase_i$ =0 on ith day, 10 points are obtained for this day. If $Purchase_i$ > 0.3 , the score is 0.

3) Finally, Total Score =

![img](https://gtms02.alicdn.com/tps/i2/TB11mksHFXXXXXpXVXX1Ze.NVXX-343-20.png)

The scoring function f(*) is not for public.

## Project Phases

### 1. Data Processing & EDA

- Time Series Analysis and Visualization

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/bd3aaba0-135c-475a-ba3b-c0681e29400f)


- Difference in Purchase and Redemption Total Amounts from Monday to Sunday

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/a66e9deb-b701-44c5-a5a7-fbd51769e5fb)


- Month Feature Analysis

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/d991c6ba-78e7-4f0e-abfc-6d296969d241)


- Date Feature Analysis

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/31d287e2-0b14-4e17-8114-98201596aa96)


- Holiday Analysis

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/2d5e37a9-8404-4afd-92f4-469ceb44dbe1)


- Analysis of Large Anomalous Transactions

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/a25f4db3-8f24-418b-b38e-bd642786573a)


- Correlation Analysis

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/f9fba23b-b652-4a7e-97d2-8359b32cdfee)


- Analysis of Bank and Alipay Interest Rates

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/511e17d5-c143-439d-818d-4b7fcd883324)


![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/5f89cb95-74c6-4425-b352-328eae65851b)


### 2. Model Baseline

Considering the pronounced cyclical patterns observed in the time series data of Yu'ebao, this project adopts a cyclical factor model for analysis.

**Calculation of Cyclical Factors (factors):** Involves the computation of cyclical factors that capture the periodic behavior present within the data.

**Calculation of Base (base):** Involves the determination of a baseline value (base) that represents the underlying trend of the data, independent of the cyclicality.

**Forecasting Process:** The forecasting of future values is achieved by multiplying the calculated base value with the corresponding cyclical factor (**forecast = base * factors**).

---

**Cycle Factor Model Baseline**

In view of the prominent cyclical patterns exhibited by the time series data of large anomalous transactions, this project adopts a cycle factor model for analysis.

**Calculating Cycle Factors (factors):** The first step involves computing cyclical factors to capture the inherent cyclic behavior within the data.

**Calculating Base (base):** The base value (base) representing the underlying trend of the data, irrespective of cyclic effects, is determined.

**Forecasting Process:** Predictions for future values are derived by multiplying the calculated base value with the corresponding cyclical factor (forecast = base * factors).

**Example Scenario:** Suppose we have the following data to predict the daily footfall for the fourth week:

| Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday | Weekly Average |
| ------ | ------- | --------- | -------- | ------ | -------- | ------ | -------------- |
| Week 1 | 20      | 10        | 70       | 50     | 250      | 200    | 100            |
| Week 2 | 26      | 18        | 66       | 50     | 180      | 140    | 80             |
| Week 3 | 15      | 8         | 67       | 60     | 270      | 160    | 120            |

**Steps:**

1. **Calculating Proportional Factors:** Divide each day's count by the weekly average to obtain proportions.
2. **Calculating Median:** Calculate the median for each day across weeks.
3. **Final Cyclical Factors:** The resulting median values serve as a robust set of cyclical factors.

**Forecasting:** To make predictions, simply multiply the cyclical factors with a base value. For instance, if the average footfall for the last week is 100, predictions for the next week can be calculated:

| Monday                 | Tuesday | Wednesday | Thursday | Friday | Saturday |
| ---------------------- | ------- | --------- | -------- | ------ | -------- |
| Median                 | 20      | 10        | 70       | 60     | 250      |
| Predictions (base=100) | 20      | 10        | 70       | 60     | 250      |

**Optimization:** While the median provides robust cyclical factors, other factors can be considered for optimization. One approach is to compute both the mean and median, and then blend them with proportions determined by test performance. Base optimization can involve considering a subset of recent days' averages (excluding cyclic effects) for better accuracy.

**Core Codes:**

```python
# Import necessary libraries
import pandas as pd  # Import pandas library for data processing
import numpy as np   # Import numpy library for numerical calculations
import datetime      # Import datetime library for date and time operations

# Define the method to generate base for time series forecast
def generate_base(df: pd.DataFrame, month_index: int) -> pd.DataFrame:
    # Select data for a fixed time period
    total_balance = df.copy()  # Copy the input DataFrame to avoid modifying the original data
    total_balance = total_balance[['date', 'total_purchase_amt', 'total_redeem_amt']]  # Select specific columns
    total_balance = total_balance[(total_balance['date'] >= pd.to_datetime('2014/3/1')) & (total_balance['date'] < pd.to_datetime('2014/{}/1'.format(month_index)))]  # Filter data for the specific time period
    
    # Add timestamp information
    total_balance['weekday'] = total_balance['date'].dt.weekday  # Add weekday information
    total_balance['day'] = total_balance['date'].dt.day          # Add day information
    total_balance['week'] = total_balance['date'].dt.week        # Add week information
    total_balance['month'] = total_balance['date'].dt.month      # Add month information
    
    # Calculate next-day factors
    mean_of_each_weekday = total_balance[['weekday'] + ['total_purchase_amt', 'total_redeem_amt']].groupby('weekday', as_index=False).mean()  # Calculate mean purchase and redeem amounts for each weekday
    for name in ['total_purchase_amt', 'total_redeem_amt']:
        mean_of_each_weekday = mean_of_each_weekday.rename(columns={name: name+'_weekdaymean'})  # Add suffix to differentiate next-day factors
    mean_of_each_weekday['total_purchase_amt_weekdaymean'] /= np.mean(total_balance['total_purchase_amt'])  # Calculate next-day factor for purchase amount
    mean_of_each_weekday['total_redeem_amt_weekdaymean'] /= np.mean(total_balance['total_redeem_amt'])    # Calculate next-day factor for redeem amount
    
    # Merge next-day factors into the original dataset
    total_balance = pd.merge(total_balance, mean_of_each_weekday, on='weekday', how='left')  # Merge next-day factors into the original dataset
    
    # Calculate frequency of next-days appearing on (1~31) days
    weekday_count = total_balance[['day', 'weekday', 'date']].groupby(['day', 'weekday'], as_index=False).count()  # Count occurrences of each day on different weekdays
    weekday_count = pd.merge(weekday_count, mean_of_each_weekday, on='weekday')  # Merge the results with next-day factors
    
    # Weight next-day factors based on frequency to obtain day factors
    weekday_count['total_purchase_amt_weekdaymean'] *= weekday_count['date'] / len(np.unique(total_balance['month']))  # Calculate weighted day factors for purchase amount
    weekday_count['total_redeem_amt_weekdaymean'] *= weekday_count['date'] / len(np.unique(total_balance['month']))    # Calculate weighted day factors for redeem amount
    day_rate = weekday_count.drop(['weekday', 'date'], axis=1).groupby('day', as_index=False).sum()  # Calculate the sum of weighted factors for each day
    
    # Obtain base by subtracting the date residuals from the mean of all dates in the training set
    day_mean = total_balance[['day'] + ['total_purchase_amt', 'total_redeem_amt']].groupby('day', as_index=False).mean()  # Calculate mean purchase and redeem amounts for each day
    day_pre = pd.merge(day_mean, day_rate, on='day', how='left')  # Merge the weighted factors with the mean for each day
    day_pre['total_purchase_amt'] /= day_pre['total_purchase_amt_weekdaymean']  # Adjust purchase amount by purchase next-day factor
    day_pre['total_redeem_amt'] /= day_pre['total_redeem_amt_weekdaymean']        # Adjust redeem amount by redeem next-day factor
    
    # Generate test set data
    for index, row in day_pre.iterrows():
        if month_index in (2, 4, 6, 9) and row['day'] == 31:
            break
        day_pre.loc[index, 'date'] = datetime.datetime(2014, month_index, int(row['day']), 0, 0, 0)  # Generate test set date based on month and day
    
    # Generate final forecast by multiplying base with next-day factors
    day_pre['weekday'] = day_pre['date'].dt.weekday  # Add weekday information
    day_pre = day_pre[['date', 'weekday'] + ['total_purchase_amt', 'total_redeem_amt']]  # Select necessary columns
    day_pre = pd.merge(day_pre, mean_of_each_weekday, on='weekday')  # Merge next-day factors
    day_pre['total_purchase_amt'] *= day_pre['total_purchase_amt_weekdaymean']  # Adjust purchase amount based on purchase next-day factor
    day_pre['total_redeem_amt'] *= day_pre['total_redeem_amt_weekdaymean']        # Adjust redeem amount based on redeem next-day factor
    
    day_pre = day_pre.sort_values('date')[['date'] + ['total_purchase_amt', 'total_redeem_amt']]  # Sort by date and select necessary columns
    return day_pre  # Return the generated time series forecast results DataFrame
```

### 3. Feature Engineering

**Static Feature Extraction Based on Date**

These "is" features capture different characteristics and conditions related to the dates, weekdays, and months in the dataset. 

The key "is" features extracted include:

- `is_weekend`: Indicates whether the day falls on a weekend (Saturday or Sunday).
- `is_holiday`: Indicates whether the day is a holiday.
- `is_firstday_of_holiday`: Indicates whether the day is the first day of a holiday period.
- `is_lastday_of_holiday`: Indicates whether the day is the last day of a holiday period.
- `is_firstday_of_work`: Indicates whether the day is the first workday after a holiday period.
- `is_work`: Indicates whether it's a workday (neither a holiday nor a weekend).
- `is_gonna_work_tomorrow`: Indicates whether the next day is a workday.
- `is_worked_yestday`: Indicates whether the previous day was a workday.
- `is_lastday_of_workday`: Indicates whether the day is the last workday before a holiday.
- `is_work_on_sunday`: Indicates whether it's a Sunday that requires working.
- `is_firstday_of_month`: Indicates whether the day is the first day of a month.
- `is_secday_of_month`: Indicates whether the day is the second day of a month.
- `is_premonth`, `is_midmonth`, `is_tailmonth`: Indicate whether the day belongs to the early, mid, or late period of a month, respectively.
- `is_first_week`, `is_second_week`, `is_third_week`, `is_fourth_week`: Indicate whether the week belongs to the first, second, third, or fourth week of the month, respectively.

<img src="https://ice.frostsky.com/2023/08/19/5b8b7f979b2bae65fd5c44c1f10016cd.png" alt="5b8b7f979b2bae65fd5c44c1f10016cd.png" border="0">

<img src="https://ice.frostsky.com/2023/08/19/8d90bcea2e91e43a4f45bc0ef8dfc28b.png" alt="8d90bcea2e91e43a4f45bc0ef8dfc28b.png" border="0">

**Distance-based Features Extraction**

These features capture various temporal distances between data points and certain reference points. 

- `dis_to_nowork` and `dis_from_nowork`: Calculate the distance to the next non-working day and the distance from the last non-working day for each data point.
- `dis_to_work` and `dis_from_work`: Calculate the distance to the next working day and the distance from the last working day for each data point.
- `dis_to_holiday` and `dis_from_holiday`: Calculate the distance to the next holiday and the distance from the last holiday for each data point.
- `dis_to_holiendday` and `dis_from_holiendday`: Calculate the distance to the next last day of holiday and the distance from the last last day of holiday for each data point.
- `dis_from_startofmonth`: Calculate the distance from the start of the month for each data point.
- `dis_from_middleofmonth`: Calculate the distance from the middle of the month (15th day) for each data point.
- `dis_from_middleofweek`: Calculate the distance from the middle of the week (Wednesday, represented by 3) for each data point.
- `dis_from_endofweek`: Calculate the distance from the end of the week (Sunday, represented by 6) for each data point.

we aim to enhance the dataset with features that capture temporal distances to various reference points, providing additional context and potentially useful insights for analysis and modeling.

<img src="https://ice.frostsky.com/2023/08/19/4a020d277668d41eb1392e3b1632390b.png" alt="4a020d277668d41eb1392e3b1632390b.png" border="0">

<img src="https://ice.frostsky.com/2023/08/19/017de87ec8dd269f5913c38143e0f7f4.png" alt="017de87ec8dd269f5913c38143e0f7f4.png" border="0">

**Peak-related Features Extraction**

<img src="https://ice.frostsky.com/2023/08/19/b610645440d57e55ffe92da6aae6a9bf.png" alt="b610645440d57e55ffe92da6aae6a9bf.png" border="0">

**Cycle-related Features Extraction**

We calculate purchase and redemption rates for different time intervals (weekdays and days of the month) within a given month. Also, we calculate average rates for each weekday and then calculate weighted rates based on the occurrence count of each weekday for each day of the month. This process helps uncover patterns in user purchase and redemption behaviors over specific time intervals within a month.

**Dynamic Behavior Features Extraction**

We aim to extract dynamic features related to purchase behavior over different time intervals within a month. It calculates various statistical measures (median, mean, min, max, standard deviation, skewness) of purchase amounts for each weekday leading up to a specific date in the dataset. These statistics are computed from the data starting on March 31, 2014. 

**Feature Selection**

We remove features that are not effective in splitting the dataset.

<img src="https://ice.frostsky.com/2023/08/19/5d82c469e0cbf7c618e62377df748ada.png" alt="5d82c469e0cbf7c618e62377df748ada.png" border="0">

We eliminated features that are highly correlated with each other. In other words, we remove multicollinear features by combining them and then checking the correlation between the combined feature and the original features. 

**Winning Features Selection**

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/c351acc8-1f84-4b97-97a4-953c1791455d)


<p align="center">
  <img src="https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/f0af7498-151d-4e32-8e2b-64afc4b6afdf" alt="Image" width="400" height="200">
</p>


### 4. Model Development & Comparison

Developed a diverse set of over 10 systematic forecasting models, including univariate and multivariate approaches, that delivered unparalleled predictive insights into future cash flows.

Utilized innovative techniques, such as weighted averaging of purchase and redemption errors, leading to the identification of the best-performing model—LSTM—exhibiting an impressive uplift in predictive accuracy.

![image](https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/bdaebde3-8af0-4c43-a9b1-05ee6a01887d)


<p align="center">
  <img src="https://ice.frostsky.com/2023/08/19/ebc04d85bdb7e8fb8da494e39a6c9b9d.png" alt="Image" width="600" height="310">
</p>


<p align="center">
  <img src="https://github.com/datoujinggzj/DS_Project_Portfolio/assets/99417740/ff60b0cf-40bf-46bb-a821-f570545e002d" alt="Image" width="600" height="310">
</p>


# Project Background
Eletra is a global e-commerce company, founded in 2018, that sells popular consumer electronics and accessories worldwide through its website and mobile app. 

The business has expanded steadily and, like many online retailers, has faced both heightened competition and pandemic-driven demand swings. The available eCommerce data spans various dimensions and metrics that include sales, products, the company’s loyalty program, and sales by region.

The key insights and recommendations focus on the following areas:

	
* **Sales trends**: Focusing on key metrics of Revenue, Order Volume, and Average Order Value (AOV).
* **Product performance**: An analysis of Eletra’s different product lines, understanding their impact on sales and returns.
* **Loyalty program evaluation**: Evaluating the effectiveness of the company’s loyalty program and providing recommendations to maximize customer engagement and retention.
* **Regional results**: An evaluation of sales and orders by region.

An interactive PowerBI dashboard can be downloaded [here](Eletra_dashboard.pbix?raw=1).

The SQL queries used to solve business related questions can be found [here](SQL%20Queries.sql).


# Data Structure and ERD (Entity relationship diagram)
Eletra’s database structure as seen below consists of four tables: orders, customers, geo_lookup, and order_status, with a total row count of 78,846 records.

<img width="1875" height="1114" alt="image" src="https://github.com/user-attachments/assets/d23213b7-3a8e-4910-bb79-41e40e85b79b" />

# Executive Summary
### Overview of findings
Since the late 2020 peak, sales have trended downward, with the sharpest declines in 2022. Year over year, every KPI moved lower: order volume by 40%, revenue by 46%, and average order value (AOV) by 10%. While much of this softening aligns with post-pandemic normalization, the following sections examine additional drivers and highlight key opportunity areas for improvement.

Below is an overview of the PowerBI dashboard used for this analysis. The dashboard can be downloaded [here](Eletra_dashboard.pbix?raw=1).

<img width="1169" height="655" alt="image" src="https://github.com/user-attachments/assets/a8b05239-d6b8-4163-82cb-c076d0b249a3" />

# Insights Deep Dive

### Sales Trends
* **The company’s sales peaked in May 2020 with 2,727 orders totaling about $797,247**. This was the height of the COVID-era demand spike, when volume and pricing were both elevated.

* **Beginning in March 2021, revenue began to decline for 22 consecutive months and never fully returned to 2020 levels**. Revenue would hit an all-time low in December of 2022 with the company just earning $180K.

* **Despite the downward trend, 2022 still finished well above the pre-2020 baseline**. Revenue in 2022 was still about **41% higher than 2019** and the decline was driven more by falling order volume than by pricing.

* Eletra’s strongest period is early spring through mid-year, especially March to May (with May 2020 as the overall peak), while the weakest stretch is late Q4, with October to December 2022 being the company’s lowest run in the 2019–2022 window.

<img width="1146" height="317" alt="image" src="https://github.com/user-attachments/assets/0bb803ec-b9a9-4b0c-bceb-478b8f0e6486" />

### Product Performance
* **The 27 Inch 4K Gaming Monitor** had consistently strong sales year over year **totaling $7,117,350**, and was the **top revenue driver** every year.

* **The second and third best-performing products** in terms of sales are the Apple Airpods Headphones ($5,650,174 total) and the Macbook Air Laptop ($4,511,340 total).

* The Bose SoundSport Headphones had extremely low sales ($2,792 total) compared to other products, as it contributed to **less than 1% in total revenue**. 

* **87% of Eletra’s orders are from just three products**, 27 Inch 4K Gaming Monitor, Apple Airpods Headphones, and Samsung Charging Cable Pack. These three products accounted for $2.6M in revenue in 2022 (70% of the company’s total), while all Samsung products only contributed 3% of revenue (under $600K).

* Eletra is also Apple-dependent, with the brand **accounting for 48% of total revenue in 2022**. Apple’s iPhone has yet to make an impact though, totaling less than 1% of orders in 2022 and $148,421 over the whole period.

<img width="984" height="421" alt="image" src="https://github.com/user-attachments/assets/31cfc04a-7050-415a-8422-cdb22bf4eeaf" />

<img width="984" height="307" alt="image" src="https://github.com/user-attachments/assets/de4205a8-e329-403c-a089-14179296d7b6" />

### Loyalty Program
* Loyalty members sustained AOV growth beyond the pandemic boom, with sales revenue rising from $0.2M in 2019 to $2.2M in 2022 and an overall **AOV increase of 14%** over that period. Loyalty members kept buying higher-priced products and placing more orders after the surge, up until August 2022.

* Non-loyalty members did not sustain that growth: their sales revenue fell from $2.5M in 2019 to $1.6M in 2022, and their **AOV declined by 6%** over the same period.

* In 2022, loyalty members spent $38 more per order than non-loyalty members ($248 vs. $209). AOV for loyalty members continued to rise year over year, **increasing 10% from 2021**, while non-loyalty members’ **AOV declined by 27.4%**.

<img width="1170" height="329" alt="image" src="https://github.com/user-attachments/assets/eca5946d-0c7b-4dce-bf80-d2b29f76111d" />

### Regional Results
* Sales and AOV declined across every region in 2022. **North America still had the highest AOV at $258, about 37% higher than Latin America, the weakest region**.

* North America became more dominant in 2022, raising its revenue share to 55% and its order share to 53% of all regional sales.

* Europe, the Middle East, and Africa (EMEA) grew their share of order volume in Q4 2022, moving from 26% to 30% quarter over quarter among known region sales.

<img width="1166" height="263" alt="image" src="https://github.com/user-attachments/assets/6b38819e-1455-4d86-8f74-5a6fbfc9aad9" />

### Recommendations:
Based on the uncovered insights, the following recommendations have been provided:
* **Broaden the product mix**. Since 85% of orders and 70% of revenue come from only three items, add more lines, especially within accessories like Apple charging cables, to create upsell paths and reduce concentration risk.

* **Boost iPhone performance**. Although Apple overall sells well, iPhone revenue is only 1% in 2022. Run targeted campaigns to past Apple buyers to lift iPhone conversions.

* **Expand Samsung offering**. Capture the growth in accessories, which account for 32% of order count in 2022, by introducing higher priced Samsung products in categories you already sell such as laptops and phones.

* **Reassess Bose SoundSport Headphones**. This product has never contributed more than 1% annually. Clear inventory through bundles and flash sales to non Apple loyalty segments, and discontinue if results remain weak.

* **Double down on loyalty**. Convert non members with a one time sign up incentive and personalized messaging on benefits and savings. Target previous buyers and time outreach to replacement cycles using post purchase data.

select * from car;
select * from customer;
select * from salesperson;
select * from sale;

-- I want to know the list of our customers and their spending.
select customer.customer_name,
       sum(sale.price) as "Customer Spending"
from sale
left join customer on customer.customer_id = sale.customer_id
group by customer.customer_name;

-- I want to find out the top 3 car manufacturers that customers bought by sales (quantity)
-- and the sales number for it in the current month.
select car.manufacturer,
       count(sale.customer_id) as quantity,
       sum(sale.price) as "Sales Number" from sale
left join car on sale.car_id = car.car_id
where extract (month FROM sale.date_sale) = extract (month FROM CURRENT_DATE)
group by car.manufacturer
order by count(sale.customer_id) desc,  sum(sale.price) desc
fetch first 3 rows only;
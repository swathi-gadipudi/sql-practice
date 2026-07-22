create database if not exists school_ranking;
use school_ranking;
select database();
show databases;


use emp_recd;
show tables;

use employee;
show tables;

select * from customer;
select * from passengers_on_flights;

select customer_id,aircraft_id,depart,arrival from passengers_on_flights
order by 1,2;

select * from passengers_on_flights;

alter table passengers_on_flights
rename to passenger;


-- 3.	Write a query to display all the passengers (customers) who have travelled in routes 01 to 25.
 -- Take data from the passengers_on_flights table.
 
 select * from passenger;
 
 select * from passenger
 where route_id between 1 and 25 order by 1,2;
 
 -- 4.	Write a query to identify the number of passengers and total revenue 
 -- in business class from the ticket_details table.
 
 select count(customer_id) as no_of_passengers,sum(price_per_ticket) as total_price
 from ticket_details where class_id = 'Bussiness';
 
 select * from ticket_details;
 select class_id, count(customer_id) as no_of_passengers, sum(price_per_ticket) as total_revenue
 from ticket_details
 group by class_id
 having class_id = 'Bussiness';
 
 -- 5.	Write a query to display the full name of the customer by extracting the 
 -- first name and last name from the customer table.
 
 select * from customer;
 
 select first_name,last_name,concat(first_name,' ',last_name) as full_name from customer;
 select first_name +' ' + last_name as full_name from customer;
 
 
 -- 6.	Write a query to extract the customers who have registered and booked a ticket. Use data from
 -- the customer and ticket_details tables.
 
 select customer.customer_id,first_name,last_name,aircraft_id from customer
 join ticket_details
 on customer.customer_id = ticket_details.customer_id;
 
 
 -- 7.	Write a query to identify the customer’s first name and last 
 -- based on their customer ID and brand (Emirates) 
 -- from the ticket_details table.
 
 select * from ticket_details;
 
 select c.customer_id,first_name,last_name,brand
 from customer c join ticket_details t
 on 
 c.customer_id = t.customer_id
 where brand = 'Emirates';
 
-- 8.	Write a query to identify the customers who have travelled by
 -- Economy Plus class using Group By and Having clause 
-- on the passengers_on_flights table.

select * from passenger; 
select count(*),class_id as no_of_customers
from passenger
group by class_id
having class_id = 'Economy Plus';

-- 9.	Write a query to identify whether the revenue has crossed 10000 
 -- using the IF clause on the ticket_details table.
 
 
 
/* 10.	Write a query to create and grant access to a new user
 to perform operations on a database.*/
 
 grant all privileges
 on employee
 to new_user;
 
 
 -- 11.	Write a query to find the maximum ticket price for each class
 -- using window functions on the ticket_details table. 
 
 select class_id,max(price_per_ticket) as max_ticket_price
 from ticket_details
 group by class_id;
 select class_id, max(price_per_ticket) over(partition by class_id)
 from ticket_details;
 
 
 -- 12.	Write a query to extract the passengers whose route ID is 4 by 
 -- improving the speed and performance of 
 -- the passengers_on_flights table
 
 create index passenger_det on passenger(route_id);
 select * from passenger where route_id=4;
 show index from passenger;
 
 

 
--  For the route ID 4, write a query to view the execution plan of
 -- the passengers_on_flights table
 
 create view pass_route 
 as
 select * from passenger
 where route_id = 4;
 
 select * from pass_route;
 
 create database if not exists care;
 
 -- 14.	Write a query to calculate the total price of all tickets booked by a customer
 -- across different aircraft IDs using rollup function. 
 
 
select customer_id,aircraft_id,sum(price_per_ticket) as total
 from ticket_details
 group by customer_id,aircraft_id
 with rollup;


-- 15.	Write a query to create a view with
--  only business class customers along with the brand of airlines.

create view bussiness_class
as
select customer.customer_id,first_name,brand
from customer join ticket_details
on
customer.customer_id = ticket_details.customer_id
where class_id = 'Bussiness';

drop view business_class;

select * from bussiness_class;

-- 16.	Write a query to create a stored procedure to get the details of all 
-- passengers flying between a range of routes defined in run time. 
-- Also, return an error message if the table doesn't exist.

call getpassengerdetails(4,10);

/* 17.	Write a query to create a stored procedure that extracts all
 the details from the routes table where the travelled distance is more than 2000 miles. */
 
 
call getdistancedetails(); 


/* 18.	Write a query to create a stored procedure 
that groups the distance travelled by each flight into three categories. 
The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, 
intermediate distance
 travel (IDT) for >2000 AND <=6500, and long-distance travel (LDT) for >6500. */
 
 select *, 
 case
    when distance_miles >=0 and distance_miles<=2000 then 'Short_distance'
    when distance_miles >=2000 and distance_miles <=6500 then 'intermediate_distance'
    else 'long_traveldistance'
End as ditsnace_travelled
from routes;

call distance_travelled();
    
    /*19.	Write a query to extract ticket purchase date,
    customer ID, class ID and specify if the complimentary services are provided for 
    the specific class using a stored function in stored procedure on the ticket_details table. 
Condition: 
●	If the class is Business and Economy Plu
s, then complimentary services are given as Yes, else it is No*/



select p_date,customer_id,class_id,
case
   when class_id = 'Business' then 'yes'
   when class_id = 'Economy_Plus' then 'yes'
   else 'No'
End as Complimentary_services
from ticket_details;

call class_id();

-- or

call getticketdetails();
select * from ticket_details;


 -- 20.	Write a query to extract the first record of the customer 
 -- whose last name ends with Scott using a cursor from the customer table.
 
 select * from customer;
 
 select * from customer where last_name like 'Scott';
 
 call getnamescott();


 
 


--  For the route ID 4, write a query to view the execution plan of
 -- the passengers_on_flights table
 
 create view pass_route 
 as
 select * from passenger
 where route_id = 4;
 
 

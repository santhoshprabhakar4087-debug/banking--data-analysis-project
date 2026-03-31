rtcreate table customers(
customer_id int primary key auto_increment,
customer_name varchar(50),
email varchar(50),
city varchar(50),
signup_date date 
);


insert into customers(customer_name,email,city,signup_date)values
('Arun','arun@gmail.com','Chennai','2024-01-10'),
('Priya','priya@gmail.com','Coimbatore','2024-02-15'),
('Rahul','rahul@gmail.com','Madurai','2024-03-05'),
('Sneha','sneha@gmail.com','Chennai','2024-03-20'),
('Vikram','vikram@gmail.com','Trichy','2024-04-12');

select * from customers;

set foreign_key_checks=0;

drop table customers;

set foreign_key_checks=1;

categories table:

create table categories(
category_id int primary key auto_increment,
category_name varchar(50)
);


insert data:

insert into categories(category_name)values 
("Electronics"),
("Clothing"),
("Books"),
("Home Appliances");


products table:

create table products(
product_id int primary key auto_increment,
product_name varchar(100),
category_id int,
price decimal(10,2),
foreign key(category_id) references categories(category_id)
);


insert data:

insert into products(product_name,category_id,price)values 
('Laptop',1,60000),
('Mobile',1,25000),
('T-Shirt',2,800),
('Novel Book',3,500),
('Microwave',4,7000);


orders table: 

create table orders(
order_id int primary key auto_increment,
customer_id int,
order_date DATE,
total_amout DECIMAL(10,2),
foreign key(customer_id) references customers(customer_id)
);



insert data:

insert into orders(customer_id,order_date,total_amout)values
(1,'2024-05-01',60000),
(2,'2024-05-02',25000),
(3,'2024-05-05',800),
(1,'2024-05-10',7000),
(4,'2024-05-12',500);


create order_item tables:

create table order_items(
order_item_id int primary key auto_increment,
order_id int,
product_id int,
quantity int,
price decimal(10,2),
foreign key(order_id)references orders(order_id),
foreign key(product_id)references products(product_id)
);


insert data:

insert into order_items(order_id,product_id,quantity,price)values
(1,1,1,60000),
(2,2,1,25000),
(3,3,1,800),
(4,5,1,7000),
(5,4,1,500);


payment tables:

create table payments(
payment_id int primary key auto_increment,
order_id int,
payment_method varchar(50),
payment_status varchar(50),
foreign key(order_id)references orders(order_id)
);


insert data:

insert into payments(order_id,payment_method,payment_status)values
(1,'Credit Card','Completed'),
(2,'UPI','Completed'),
(3,'Debit Card','Completed'),
(4,'UPI','Pending'),
(5,'Cash on Delivery','Completed'); 


REVIEWS TABLES:

create table reviews(
review_id int primary key auto_increment,
product_id int,
customer_id int,
rating int,
foreign key(product_id)references products(product_id),
foreign key(customer_id)references customers(customer_id)
);


insert data:

insert  into reviews(product_id,customer_id,rating)values
(1,1,5),
(2,2,4),
(3,3,4),
(4,4,5),
(5,1,3);


shipments table: 

create table shipments(
shipment_id int primary key auto_increment,
order_id int,
deliverery_status varchar(30),
delivery_date DATE,
foreign key(order_id) references orders(order_id)
);

insert data:

insert into shipments(order_id,deliverery_status,delivery_date)values
(1,'Delivered','2024-05-05'),
(2,'Delivered','2024-05-06'),
(3,'Shipped','2024-05-07'),
(4,'Processing',NULL),
(5,'Delivered','2024-05-15');


select * from customer;



TOP CUSTOMERS (Windows Function)

SELECT customer_name, time_spent,
rank() over(total_spent desc)as rank,
from(
   select c.customer_name,
   sum(o.customer_amount)AS total_spent
   from customer c
   join customer o on c.customer_id=o.customer_id
   GROUP BY c.customer_name
)t;


RUNNING REVENUE (Trend Analysis)

select order_date,  
sum(total_amount) over (order by order_date)AS running_total
from orders;


3. REPEAT VS NEW CUSTOMERS

  select customer_id,
  count(order_id)AS order_count,
  case
    WHEN COUNT(order_id)> 1 THEN 'repeat'
    else 'new'
   end as customer_type
   FROM ORDERS
   GROUP BY costumer_id;


4. Top Rated Products

 select p.product_name,
 AVG(r.rating)AS avg_rating
 from products p
 JOIN REVIEWS r on p.product_id=r.product_id
 GROUP BY p.product_name
 ORDER BY avg_rating DESC;
 
 
5. Delayed shipments

  select*
  from shipments
  WHERE delivery_status='delayed';
  
  
4. INDEXING (very important for interview)

CREATE INDEX idx_customer_id ON ORDERS(customer_id);
CREATE INDEX idx_product_id on order_items(product_id);



5. VIEWS (PROFFESIONAL TOUCH)

CREATE VIEWSsales_summary AS
SELECT order_id,c.customer_name,o.total_amount,
from orders o
join customers c on o.customer_id=c.customer_id;

REVENUE:

select sum(price) as revenue from products;

ORDERS COUNT:

select count(order_id) from orders;

CUSTOMERS:

select distinct count(customer_id) from customers;

AVG RATING:

select avg(rating) from reviews;

create view v1 as select sum(price) as revenue from products;



select * from v1;

create view v2 as select count(order_id) from orders;

create view v3 as select distinct count(customer_id) from customers;
 
create view v4 as select avg(rating) from reviews;
  


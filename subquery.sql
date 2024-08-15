select rental_id, sum(amount) as AmountSpent
into temp payment_agg
from payment
group by 1;


select a.*, b.AmountSpent 
into temp rental_joined2
from rental as a
left join payment_agg as b
on a.rental_id = b.rental_id;

create view rental_joined3 as
select *,
	extract(day from return_date - rental_date) as days_rented,
	case
	when extract(hour from rental_date) < 4 then 'Late Night'
	when extract(hour from rental_date) < 12 then 'Morning'
	when extract(hour from rental_date) < 17 then 'Afternoon'
	when extract(hour from rental_date) < 22 then 'Evening'
	else 'Late Night'
	end
	as Time_of_rental
from rental_joined2;




select a.*, b.AmountSpent 
from rental_joined as a
left join
	(
	select rental_id, sum(amount) as AmountSpent
	from payment
	group by 1
	)
as b on a.rental_id = b.rental_id;



/* 1) Llista quants productes de categoria 'Begudes' s'han venut en una determinada localitat.*/

SELECT count(*) FROM product_has_Order pho 
	join product p on p.product_id = pho.product_id 
		join pizzeria.order od on od.order_id = pho.order_id 
			join customer c on c.customer_id = od.customer_customer_id  
				join town t on c.town_id = t.town_id 

					where p.type_product_id 

					= (select type_product_id 
						from type_product 
						where type_product_name = "Bebidas") 
					and t.name_town = "Sebastopol";

/* 2) Llista quantes comandes ha efectuat un determinat empleat/da.*/

/* Version A */ 

select count(*) from pizzeria.order od where employee_employee_id = 1;

/* Version B */

select count(*) from pizzeria.order od 

where employee_employee_id = 

	( select employee_id from employee 
		where name_employee = "Segismundo" 
		and surname_employee = "Copón" );

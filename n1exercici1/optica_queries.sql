/*
Llista el total de factures d'un client/a en un període determinat.*/

select count(*) from sales s join customer c 
	on s.customer_customer_id = c.customer_id 
		where year(s.date_sale) = 2021;

/* Llista els diferents models d'ulleres que ha venut un empleat/da durant un any.*/

select distinct(b.name) as "Marca d'Olleres" from sales s 
	join employee e on s.employee_id = e.employed_id 
	join sale_details sd on sd.sales_sale_id  = s.sales_id 
	join eyeglass eg on eg.eyeglass_id = sd.eyeglass_eyeglass_id 
	join brand b on b.brand_id = eg.brand_brand_id 
		where year(s.date_sale) = 2021 and e.employee_name = 'pako';

/* Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.*/

select distinct(su.name) as "Proveïdors" from sales s 
	join sale_details sd on sd.sales_sale_id = s.sales_id 
		join eyeglass eg on eg.eyeglass_id = sd.eyeglass_eyeglass_id 
			join brand b on b.brand_id = eg.brand_brand_id 
				join supplier su on su.supplier_id = b.supplier_supplier_id;

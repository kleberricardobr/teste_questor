--2. Quantidade de vendas do carro Marea
select count(1) as qtd 
from venda vd
  inner join carro ca on (ca.id = vd.carro_id)
  inner join modelo md on (md.id = ca.modelo_id)
where md.modelo ilike 'marea'


--3. A quantidade de vendas do carro Uno por cliente
select ci.id || ' - ' || ci.nome as cliente,
       count(1) as qtd
from venda vd
  inner join cliente ci on (ci.id = vd.cliente_id)
  inner join carro ca on (ca.id = vd.carro_id)
  inner join modelo md on (md.id = ca.modelo_id)
where md.modelo ilike 'uno'
group by ci.id,
         ci.nome

--4. A quantidade de clientes que não efetuaram venda
select count(1)
from cliente cl
  left join venda vd on (vd.cliente_id = cl.id)
where vd.id is null


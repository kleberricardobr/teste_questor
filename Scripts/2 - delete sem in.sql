-- Delete sem IN; EXISTS é mais performático quanto o resultado da subquery é maior
delete from venda v1
where not exists( select 1
                  from venda vd
                    inner join cliente cl on (cl.id = vd.cliente_id)
                    inner join carro ca on (ca.id = vd.carro_id)
                    inner join modelo md on (md.id = ca.modelo_id)
                  where v1.cliente_id = vd.cliente_id
                    and cl.cpf like '0%'  
                    and extract(year from ca.dt_lancamento) = 2021
                    and md.modelo ilike 'marea' /* Nos critérios não diz que o sorteio é válido apenas para quem comprou Marea,
                                                   porém para mim ficou subentendido que sim, uma vez que os clientes prejudicados
                                                   foram estes, além de que se não colocar o filtro, haverá o risco de sortear somente
                                                   clientes não prejudicados, fugindo do objetivo do sorteio */
                    and not exists ( select 1
                                     from venda v2
                                       inner join carro ca2 on (ca2.id = v2.carro_id) 
                                       inner join modelo m2 on (m2.id = ca2.modelo_id)
                                     where m2.modelo ilike 'marea'
                                       and v2.cliente_id = vd.cliente_id
                                     group by v2.cliente_id
                                     having count(1) >= 2 )
                  order by vd.dh_venda                  
                  limit 15 )

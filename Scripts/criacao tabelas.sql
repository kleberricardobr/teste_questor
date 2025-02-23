--tabela de clientes
create table cliente(
  id serial,
  nome varchar(200) not null,
  telefone varchar(30) not null,
  cpf varchar(11) not null,
  constraint pk_cliente primary key(id),
  constraint idx_cliente_cpf unique(cpf)  
);

--tabela modelos de carro
create table modelo(
  id serial,
  modelo varchar(100) not null,
  constraint pk_modelo primary key(id),
  constraint idx_modelo unique(modelo)
);

--tabela de carros
create table carro(
  id serial,
  modelo_id int not null,
  dt_lancamento date not null,
  preco numeric(10, 5) not null,
  constraint fk_carro_modelo foreign key(modelo_id) references modelo(id),
  constraint pk_carro primary key(id),
  constraint idx_carro_modelo unique(modelo_id, dt_lancamento)
);

--tabela de vendas
create table venda(
  id serial,
  cliente_id int not null,
  carro_id int not null,
  total numeric(10,5) not null,
  dh_venda date,
  constraint fk_venda_cliente foreign key(cliente_id) references cliente(id),
  constraint fk_venda_carro foreign key(carro_id) references carro(id),
  constraint pk_venda primary key(id) 
);

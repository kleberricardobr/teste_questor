# Teste Técnico QUESTOR
## Estrutura
### Questões SQL
 - Banco de dados utilizado: Postgres
 - Script de criação da tabelas encontra-se em: .\Scripts\criacao tabelas.sql
 - Consultas SQL referente a questões 2, 3, 4 estão no arquivo: .\Scripts\consultas.sql
 - Questão 5 (SQL do Sorteio) está no arquivo: .\Scripts\sorteio.sql
 - Deleção de vendas de clientes não sorteados (SEM IN) - usando **using**: .\Scripts\1 - delete sem in.sql
 - Deleção de vendas de clientes não sorteados (SEM IN) - usando **not exists**: .\Scripts\2 - delete sem in.sql

### Questões Delphi
- Versão do Delphi utilizada: 12 Community
- Executável para simulação: .\Win32\Debug\TesteQuestor.exe
- Pasta com as Units das classes representando cada tabela: .\Models
- Units responsáveis pela inserção de 5 clientes: .\Services\Services.ClienteServices.pas; .\Daos\Daos.ClienteDao.pas 
- Units responsáveis pela inserção de 5 modelos de carros: .\Services\Services.CarroServices.pas; .\Daos\Daos.CarroDao.pas 
- Units responsáveis por inserir uma venda para os 5 clientes x carros cadastrados: .\Services\Services.VendaServices.pas; .\Daos\Daos.VendaDao.pas

**ESTRUTURA DO CÓDIGO - DELPHI**
- A unit Principal.pas da tela de teste é responsável por acionar o Services para realizar os cadastros.
- Cada Service aciona seu Dao respectivo, simulando o acesso a um banco de dados.
- Dentro das classes Dao, existem os métodos fictícios InserirDadosBD (responsável por simular o cadastro) e 
ExecutarSql (responsável por simular o carregamento de informações) 
- Para simular a persistência dos dados, foram utilizadas Listas (ObjectList), as quais permanecem coms dados carregados 
até o objeto Dao ser destruído
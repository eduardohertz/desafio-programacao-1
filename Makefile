help:
	@echo "=============================================="
	@echo "==     Ajuda para configurar a aplicação    =="
	@echo "=============================================="
	@echo ""
	@echo "Requerimentos:"
	@echo "1. Ruby 1.9+"
	@echo "2. RubyGems 1.8+"
	@echo "3. MySQL 5.5"
	@echo "4. Editar o arquivo config/database.yml com os dados corretos."
	@echo ""
	@echo ""
	@echo "Comandos:"
	@echo "1. make run"
	@echo "   Instala as gems, inicializa o banco, compila os assets e inicializa o servidor em produção."
	@echo "2. make database"
	@echo "   Recria o banco de dados de produção. (!!! OS DADOS SERÃO REMOVIDOS !!!)."
	@echo "3. make test"
	@echo "   Cria o banco de dados (test environment) e roda os testes."
	@echo "4. make help"
	@echo "   Visualiza este texto de ajuda."

run:
	@rm -Rf .bundle/
	@rm -Rf public/assets
	@echo ""
	@echo "==========================="
	@echo "==    Instalando gems    =="
	@echo "==========================="
	@echo ""
	@bundle install
	@echo ""
	@echo "=================================="
	@echo "==    Criando banco de dados    =="
	@echo "=================================="
	@echo ""
	@rake db:drop db:create db:migrate db:seed RAILS_ENV=production
	@echo ""
	@echo "================================"
	@echo "==    Compilando os assets    =="
	@echo "================================"
	@echo ""
	@rake assets:precompile
	@echo ""
	@echo "=================================="
	@echo "==    Inicializando servidor    =="
	@echo "=================================="
	@echo ""
	@echo ""
	@echo "=================================="
	@echo "Usuário padrão criado"
	@echo "Login: user@base.com"
	@echo "Senha: 123456"
	@echo "=================================="
	@echo ""
	@echo ""
	@rails s -e production

database:
	@echo ""
	@echo "=================================="
	@echo "==    Criando banco de dados    =="
	@echo "=================================="
	@echo ""
	@rake db:drop db:create db:migrate RAILS_ENV=production

test:
	@echo "================================================="
	@echo "== Inicializando banco de dados para os testes =="
	@echo "================================================="
	@echo ""
	@rake db:create db:migrate db:test:prepare
	@echo ""
	@echo "============================="
	@echo "==    Rodando os testes    =="
	@echo "============================="
	@echo ""
	@rspec spec/

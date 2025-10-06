# apirest-python
Aulas Tecnicas Avancadas Fatec Taquairitinga

## Tecnicas Avançada de Programação
Carlos 

## Turma : Ams Fatec Taquaritinga 2025

### como baixar o projeto
copie o link do repositorio, link aqui: https://github.com/carloscastrofilho/apirest-python.git

acesse a pasta de destino do projeto e execute um git clone:

`git clone https://github.com/carloscastrofilho/apirest-python.git`


### criar o ambiente virtual
vamos utilizar a bliblioteca `venv`, para criar o ambiente utilize o comando abaixo:
`python -m venv myvenv`

ativar o ambiente virtual:
`source ./myvenv/Scripts/activate`

fazer instalação das dependencias no ambiente virtual
```bash
    pip install -r requirements.txt
``` 

comando geralmente indica a rodar para atualizar a versão do pip no nosso ambiente virutal
``` bash
    python.exe -m pip install --upgrade pip
```

comando utilizado para a instalação de uma dependencia do python

pip install <dependencia>

exemplo
``` bash
    pip install flask
```

para exportar  um arquivo das dependencias instaladas no seu ambiente virtual ou python :

1- vamos informar ao pip que pretendemos exportar a lista de dependencias, utilizando o comando:
* pip freeze

exemplo de uso:
```bash
    pip freeze
```
2- executamos o comando freeze com a indicação do nome arquivo que vai conter a lista de dependencias:

* pip freeze > <"nome-arquivo-dependencias">

exemplo comando:
```bash
    pip freeze > requirements.txt
```



### rotina comandos git para trabalhar com projetos gerenciados pelo git

git clone <link-do-repositorio-gethub>

git pull
git fetch --all

git checkout -b <nome-branch>

git add .

git commit -m "<descrição-do-commit>"

git push

git push --set-upstream origin [branch]



## drive

pip install mysql-connector-python

```python
def get_mysql_connection():
    conn = mysql.connector.connect(
        host=app.config['MYSQL_HOST'],
        user=app.config['MYSQL_USER'],
        password=app.config['MYSQL_PASSWORD'],
        database=app.config['MYSQL_DB']
    )
    return conn

@app.route('/')
def index():
    conn = get_mysql_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM sua_tabela")
    results = cursor.fetchall()
    cursor.close()
    conn.close()
    return str(results)
```
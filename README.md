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

python.exe -m pip install --upgrade pip



pip install flask

pip freeze

pip freeze > requirements.txt

pip install -r requirements.txt

### rotina comandos git

pip install flask_cors

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
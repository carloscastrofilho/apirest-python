from flask import jsonify, request
from sqlalchemy import  text
from  src.db import database

db_connect = database.get_db_connection()
tableName = "roles"

def get():    
    try:
        conn = db_connect.connect()
        # Não há dados do usuário aqui, mas usamos text() para uniformidade
        query_text = text(f'SELECT * FROM {tableName} ORDER BY id DESC')
        result = conn.execute(query_text)
            
        # Mapeia os resultados para uma lista de dicionários
        data = [dict(zip(result.keys(), row)) for row in result]
            
        return jsonify(data), 200
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500


def getBy(idValue):
    """Retorna um contato específico pelo ID."""
    try:
        with db_connect.connect() as conn:
            # Segurança: Usando ':id' como parâmetro vinculado
            query_text = text(f'SELECT * FROM {tableName} WHERE id = :id')
            
            # Executa a query passando o valor do ID
            result = conn.execute(query_text, {"id": idValue})
            data = [dict(zip(result.keys(), row)) for row in result]
            
            if not data:
                 return jsonify({"error": f"Registro com ID {idValue} não encontrado"}), 404
            
            return jsonify(data[0]), 200 # Retorna apenas o objeto, não a lista
            
    except Exception as e:
       return jsonify({"error": f"Erro ao buscar contato: {str(e)}"}), 500

def post():
    """Cria um novo contato com dados do JSON do request."""
    try:
        # Pega os dados do corpo JSON. Usar get_json() é mais seguro.
        dataBody = request.get_json(force=True)
        
        # Mapeia os dados esperados do corpo
        login = dataBody.get('login')
        password = dataBody.get('password')
        name = dataBody.get('name')
        
        
        if not login:
            return jsonify({"error": "O campo 'login' é obrigatório."}), 400
            
        with db_connect.connect() as conn:
            # SEGURANÇA: Usando parâmetros vinculados (:nome, :apelido, etc.)
            query_text = text(f"""
                INSERT INTO {tableName} (login, password ,name )
                VALUES (:login , :password , :name )
            """)
            
            # Executa a query com um dicionário de parâmetros
            result = conn.execute(query_text, {
                "login": login, 
                "password": password, 
                "name": name
            })
            
            conn.commit()
            
            # Retorna o ID do novo contato
            new_id = result.lastrowid
            return jsonify({"message": "registro criado com sucesso", "id": new_id}), 201
            
    except Exception as e:
        return jsonify({"error": f"Erro ao criar contato: {str(e)}"}), 500


def put(idValue):
    """Atualiza um contato existente pelo ID."""
    try:
        dataBody = request.get_json(force=True)
        
        # Cria a lista de campos a serem atualizados dinamicamente
        updates = []
        params = {"id": idValue}
        
        for key, value in dataBody.items():
            # A chave é o nome da coluna, o valor é o parâmetro vinculado (ex: :nome)
            updates.append(f"{key} = :{key}")
            params[key] = value
            
        if not updates:
            return jsonify({"error": "Nenhum dado fornecido para atualização"}), 400

        with db_connect.connect() as conn:
            # Constrói a query de forma segura usando join e WHERE com bind parameter
            query_text = text(f"""
                UPDATE {tableName} SET {', '.join(updates)} WHERE id = :id
            """)
            
            result = conn.execute(query_text, params)
            conn.commit()
            
            if result.rowcount == 0:
                 return jsonify({"error": f"Registro com ID {idValue} não encontrado para atualização"}), 404
                 
            return jsonify({"message": f"Registro ID {idValue} atualizado com sucesso"}), 200
            
    except Exception as e:
        return jsonify({"error": f"Erro ao atualizar registro: {str(e)}"}), 500
    

def delete(idValue):
    """Deleta um contato específico pelo ID."""
    try:
        with db_connect.connect() as conn:
            # SEGURANÇA: Usando ':id' como parâmetro vinculado
            query_text = text(f'DELETE FROM {tableName} WHERE id = :id')
            result = conn.execute(query_text, {"id": idValue})
            conn.commit()
            
            if result.rowcount == 0:
                 return jsonify({"error": f"registro com ID {idValue} não encontrado para exclusão"}), 404
                 
            # 204 No Content é o status padrão para deleção bem-sucedida sem corpo de resposta
            return jsonify({"message": f"registro ID {idValue} excluído com sucesso"}), 204
            
    except Exception as e:
        return jsonify({"error": f"Erro ao deletar registro: {str(e)}"}), 500

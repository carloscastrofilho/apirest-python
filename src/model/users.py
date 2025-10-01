from flask import jsonify, request
from sqlalchemy import  text
from  src.db import database

db_connect = database.get_db_connection()
tableName = "users"

def get():
    try:
       # recebe uma conexão com o banco 
       db = db_connect.connect()
       query_text = text( f"SELECT * FROM {tableName} ORDER BY id DESC")       
       # data recebe resultado da consulta
       data = db.execute(query_text)       
       # Mapeia os resultados para uma lista de dicionários
       result = [dict(zip(data.keys(), row)) for row in data]            
       return jsonify(result), 200   
    except Exception as e:
        return jsonify({"error": str(e)}), 500 
    
def getBy(value):  
    try:
       # recebe uma conexão com o banco 
       db = db_connect.connect()
       query_text = text( f"SELECT * FROM {tableName} WHERE id = :id ORDER BY id DESC")       
       # data recebe resultado da consulta
       data = db.execute(query_text, {"id": value} )       
       # Mapeia os resultados para uma lista de dicionários
       result = [dict(zip(data.keys(), row)) for row in data]  
       if not result:
            return jsonify({"error": f"Registro com ID {value} não encontrado"}), 404          
        
       return jsonify(result), 200  
    except Exception as e:
        return jsonify({"error": str(e)}), 500    



def delete(value):  
    try:
       # recebe uma conexão com o banco 
       db = db_connect.connect()
       query_text = text( f"DELETE FROM {tableName} WHERE id = :id")       
       # data recebe resultado da consulta
       data = db.execute(query_text, {"id": value} )  
       db.commit()  
       if data.rowcount == 0 :
            return jsonify({"error": f"Registro com ID {value} não encontrado"}), 404          
        
       return jsonify({"sucesso": f"Registro apagado com sucesso"}), 204          
   
    except Exception as e:
        return jsonify({"error": str(e)}), 500    

def post():  
    try:
        # recebe uma conexão com o banco 
        db = db_connect.connect()       
        payload = request.get_json(force=True)
        
        login = payload.get('login')
        password = payload.get('password')
        name = payload.get('name')
        
        
        query_text = text( f"""INSERT INTO {tableName} 
                          ( login, password, name 
                           ) VALUES (
                            :login, :password, :name )
                         """)       
        # data recebe resultado da consulta
        data = db.execute(query_text, {"login": login , "password": password , "name": name } )          
        db.commit()          
        new_id = data.lastrowid        
        return jsonify({"message": "registro criado com sucesso", "id": new_id}), 201
            
    except Exception as e:
        return jsonify({"error": str(e)}), 500    
       

def put(idvalue):  
    try:
        # recebe uma conexão com o banco 
        db = db_connect.connect()       
        payload = request.get_json(force=True)
        
        login = payload.get('login')
        password = payload.get('password')
        name = payload.get('name')
        active = payload.get('active')
        
        
        query_text = text( f"""UPDATE {tableName} 
                          SET login = :login , password = :password, name = :name , active  = :active
                        WHERE id = :id  
                         """)       
        # data recebe resultado da consulta
        data = db.execute(query_text, {"login": login , "password": password , "name": name , "id": idvalue , "active": active } )          
        db.commit()
                  
        if data.rowcount == 0:
            return jsonify({"error": f"Registro com ID {idvalue} não encontrado para atualização"}), 403
                 
        return jsonify({"message": f"Registro ID {idvalue} atualizado com sucesso"}), 203
            
    except Exception as e:
        return jsonify({"error": str(e)}), 500    


# def get():
#     try:
#        #codigo metodo
#        return 
#     except Exception as e:
#         return jsonify({"error": str(e)}), 500
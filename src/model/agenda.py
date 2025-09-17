from flask import jsonify, request
from sqlalchemy import  text
from  src.db import database

db_connect = database.get_db_connection()

def get():    
    try:
        conn = db_connect.connect()
        result = conn.execute(text('SELECT * FROM users ORDER BY id DESC'))
        data = [dict(zip(result.keys(), row)) for row in result]
        conn.close()
        return jsonify(data), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


def getBy(item_id):
    item = next((item for item in listAgenda if item['id'] == item_id), None)
    if item:
        return jsonify(item)
    return jsonify({"message": "Item não encontrado"}), 404

def post():
    new_item = request.json
    if not new_item or 'nome' not in new_item:
        return jsonify({"message": "Dados inválidos"}), 400
        
    # Atribui um novo ID (simples, para exemplo)
    new_item['id'] = len(listAgenda) + 1 
    listAgenda.append(new_item)
    return jsonify(new_item), 201

def put(item_id):
    item_data = request.json
    item = next((item for item in listAgenda if item['id'] == item_id), None)
    if item:
        item.update(item_data)
        return jsonify(item)
    return jsonify({"message": "Registro não encontrado"}), 404

def delete(item_id):
    global listAgenda # Permite modificar a lista global
    original_len = len(listAgenda)
    listAgenda = [item for item in listAgenda if item['id'] != item_id]
    if len(listAgenda) < original_len:
        return jsonify({"message": " registro deletado com sucesso"}), 200
    return jsonify({"message": "registro não encontrado"}), 404
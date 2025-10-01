from flask import Flask, jsonify, request
from flask_cors import CORS

# Imports proprios
from src.model import users
from src.model import contacts 
from src.model import roles
 
app = Flask(__name__)

# Configuração do CORS
CORS(app, resources={r"/*": {"origins": "*"}})

# Mapeamento de rotas
route_map = {
    'users': users,
    'contacts': contacts, 
    'roles': roles
}

@app.route('/<resource>', methods=["GET", "POST"])
@app.route('/<resource>/<int:id>', methods=["GET", "PUT", "DELETE"])
def handle_resource(resource, id=None):
    if resource in route_map:
        if request.method == "GET":
            if id is not None:
                return route_map[resource].getBy(id)
            return route_map[resource].get() 
        
        elif request.method == "POST":
            return route_map[resource].post()
        
        elif request.method == "PUT":
            return route_map[resource].put(id)
        
        elif request.method == "DELETE":
            return route_map[resource].delete(id)
            
    return jsonify({"error": "Resource not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)

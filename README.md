<h1> API de Games</h1>

<h3> API para visualizar, adicionar, alterar e apagar dados de games.
Esta API esta sendo consumida aqui: https://github.com/faalbuquerque/games-api-cli</h3>


### Endpoint para visualizar todos os games:

```
Rota: GET https://fabi-games-api.herokuapp.com/api/v1/games/

Output:

{
  "games": [
    {
      "id": 3,
      "name": "Portal",
      "description": "Um jogo dificil",
      "genre": "Puzzle",
      "grade": 10
    },
    {
      "id": 4,
      "name": "Demons Souls",
      "description": "Jogo Dificil demais",
      "genre": "RPG",
      "grade": 10
    },
    {
      "id": 19,
      "name": "Skyrim",
      "description": "Um jogo medieval",
      "genre": "RPG",
      "grade": 10
    }
  ]
}
```

### Endpoint para visualizar um game:

```
Rota: GET https://fabi-games-api.herokuapp.com/api/v1/games/#{id}

Output:

{
  "game": {
    "id": 19,
    "name": "Skyrim",
    "description": "Um jogo medieval",
    "genre": "RPG",
    "grade": 10
  }
}

Output em caso de falha(Dados inválidos):

{
  "message": "Dado inexiste"
}
```

### Endpoint para adicionar games:

```
Rota:  POST https://fabi-games-api.herokuapp.com/api/v1/games/

Input:

{
  "game": {
    "name":"Skyrim",
    "description":"Um jogo medieval",
    "genre":"RPG",
    "grade":10
  }
}

Output em caso de sucesso:

{
  "game": {
    "id": 21,
    "name": "Skyrim",
    "description": "Um jogo medieval",
    "genre": "RPG",
    "grade": 10
  }
}

Output em caso de falha(campos em branco):

{
    "message": [
        "Description can't be blank"
    ]
}

Output em caso de falha(dados inválidos):

{
  "message": "Dados inválidos"
}

```

### Endpoint para alterar game:

```
Rota:  PUT https://fabi-games-api.herokuapp.com/api/v1/games/#{id}

Input:

{
  "game": {
    "name": "Oblivion",
    "description": "Um jogo online",
    "genre": "RPG",
    "grade": 8
  }
}

Output em caso de sucesso:

{
  "game": {
    "name": "Oblivion",
    "description": "Um jogo online",
    "genre": "RPG",
    "grade": 8,
    "id": 21
  }
}

Output em caso de falha(campos em branco):

{
    "message": [
        "Description can't be blank"
    ]
}

Em caso de falha(dados inválidos): Status 400 Bad Request

```

### Endpoint para apagar game:

```
Rota:  DELETE https://fabi-games-api.herokuapp.com/api/v1/games/#{id}

Output em caso de sucesso:

{
  "message": "Game apagado"
}

Output em caso de falha(Dados inválidos):

{
  "message": "Dado inexiste"
}
```
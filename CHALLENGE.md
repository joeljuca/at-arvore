# The Challenge

## Objetivo

Construir uma API usando Phoenix (Elixir) e o banco de dados MySQL, visando permitir que parceiros da Árvore possam replicar a sua estrutura de Redes, Escolas e Turmas, e administrá-la conforme necessário. O acesso a esta API deve ser restrito com um mecanismo de autenticação usando uma ou mais chaves de acesso, às quais devem estar vinculadas ao parceiro.

A modelagem deverá utilizar apenas uma entidade (`Entity`), que poderá representar qualquer nível da estrutura hierárquica.

## Tarefas

- [ ] Repositório Git
  - [x] Documentação
  - [ ] CI/CD (eg.: `test`, `style`, `analysis`, etc.)
- [ ] Schema de entidades
  - [x] Campos `name`, `entity_type`, `inep`, e `parent_id`
  - [x] Validação via `Entity.changeset/2`
    - [ ] Entidades do tipo `network` não têm `parent`/`parent_id`
    - [x] Campos obrigatórios: `type` e `name`
    - [x] Campo `parent` (e `parent_id`) referenciam schema `Entity`
      - [x] Entidades não podem ser parent/child de si mesmas
    - [ ] Campo `inep` aceito apenas em entidades do tipo `school`
- [x] Endpoints de entidades
  - [x] `POST /api/v2/partners/entities`
  - [x] `GET /api/v2/partners/entities`
  - [x] `PATCH /api/v2/partners/entities`
  - [x] `DELETE /api/v2/partners/entities`
- [ ] Testes E2E
  - [ ] `POST /api/v2/partners/entities`
  - [ ] `GET /api/v2/partners/entities`
  - [ ] `PATCH /api/v2/partners/entities`
  - [ ] `DELETE /api/v2/partners/entities`
- [ ] Deploy
  - [ ] Fly?

## Entidades

As entidades serão segmentadas pelos seguintes tipos:

- **Network:** é o mais alto nível permitido para criação de entidades, representando uma rede de escolas (opcional)
- **School:** representa uma escola, podendo ou não estar relacionada a uma rede
- **Class:** representa uma turma e deve obrigatoriamente ser relacionado a uma escola

### Atributos

- `name`
- `entity_type`
- `inep` (código INEP, usado apenas para `entity_type` com valor `school`)
- `parent_id` (identificador da entidade antecessora na hierarquia)
  - A entidade mais alta da hierarquia (`network` ou `school`), terá `parent_id` nulo

Alguns exemplos de requisições e retornos esperados seguem a seguir.

## REST API

### Endpoints de entidade

Alguns exemplos de requisições e retornos esperados seguem a seguir.

#### `POST /api/v2/partners/entities`

No exemplo abaixo uma escola sem um antecessor hierárquico está sendo criado.

**Request:**

```
POST /api/v2/partners/entities
Content-Type: application/json

{
  "entity_type": "school",
  "inep": "123456",
  "name": "Escolinha do Professor Raimundo"
}
```

**Response:**

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

{
  "data": {
    "id": 1,
    "type": "school",
    "inep": null,
    "name": "Escolinha do Professor Raimundo",
    "subtree_ids": []
  }
}
```

**Obs:**

- `subtree_ids` deverá trazer uma lista com os IDs de todas as entidades relacionadas à entidade retornada

#### `GET /api/v2/partners/entities/:id`

**Request:**

```
GET /api/v2/partners/entities/1
```

**Response:**

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

{
  "data": {
    "id": 1,
    "type": "school",
    "inep": null,
    "name": "Escolinha do Professor Raimundo",
    "subtree_ids": []
  }
}
```

**Obs:**

- `subtree_ids` deverá trazer uma lista com os IDs de todas as entidades relacionadas à entidade retornada

#### `PATCH /api/v2/partners/entities/:id`

**Request:**

```
PATCH /api/v2/partners/entities/1

{
  "entity_type": "network",
  "name": "Rede do Professor Raimundo"
}
```

**Response:**

```
HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

{
  "data": {
    "id": 1,
    "type": "network",
    "inep": null,
    "name": "Rede do Professor Raimundo",
    "subtree_ids": []
  }
}
```

**Obs:**

- `subtree_ids` deverá trazer uma lista com os IDs de todas as entidades relacionadas à entidade retornada

## Requisitos mínimos

- Documentação no repositório Git
- Deploy em qualquer serviço para consumo durante avaliação
- Testes E2E
- Integração contínua (CI)

### Requisitos desejáveis

- GraphQL (schema pode refletir a mesma estrutura acima)
- Testes de carga

### Prazos

- Consegue fazer até dia 27/09?
- Caso entregue antes, pontos extras!
- Em caso de dúvidas, basta responder a todos neste e-mail

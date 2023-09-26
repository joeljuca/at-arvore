# Notes

I'll be taking notes as I work on this problem.

- In HTTP/REST, the PATCH verb should be used for partial updates. What the PUT verb does is a full replacement of a HTTP resource, which isn't what the challenge proposes. So, I've changed the docs to mention PATCH instead of PUT
  - I'll leave both verbs working as partial update mechanisms, but it definitely devies from the REST standard
- I've named a field `type` when it was supposed to be `entity_type`. I do think `type` is a better name because the `entity_` part goes duplicated when you're accessing it with an entity variable - commonly named `entity`, which results in statements like `entity.entity_type`. But in the end, it's just a nitchpick so I'm leaving it this way
- Sorry, but I'm not implementing a GraphQL setup here (too much work already)
  - No load tests too :( but tests and CI are on its way

--  
Joel Jucá

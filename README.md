# joeljuca/at-arvore

[![quality](https://github.com/joeljuca/at-arvore/actions/workflows/quality.yml/badge.svg)](https://github.com/joeljuca/at-arvore/actions/workflows/quality.yml)

My code at the technical assessment for the [back-end engineering position](https://arvore.gupy.io/jobs/5196898) at [Árvore](https://www.arvore.com.br).

## Challenge

See [`CHALLENGE.md`](CHALLENGE.md) (personal notes available in [`NOTES.md`](NOTES.md)).

## Setup

This project is built with Elixir, Phoenix, and MySQL, so it has the following system dependencies:

- [Erlang](https://www.erlang.org) v25 or newer (required by Elixir)
- [Elixir](https://elixir-lang.org) v1.14 or newer
- [MySQL](https://www.mysql.com) v8.1 or newer

In order to run this project in your system the dependencies above must be installed and available in your system.

With system dependencies in place, run:

```
make setup
```

If everything went well, it should be ready to run.

> 💡 This project makes use of [`Makefile`](makefile) to provide CLI shortcuts for common tasks.

## Usage

To run it locally, use the following command:

```
make run
```

It should be available in [localhost:4000](http://localhost:4000).

## License

[![Creative Commons Attribution 4.0 International License](https://i.creativecommons.org/l/by/4.0/80x15.png "Creative Commons Attribution 4.0 International License")](https://creativecommons.org/licenses/by/4.0/ "Creative Commons Attribution 4.0 International License")

Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

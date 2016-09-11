![GitHub Logo](/misc/logo.png)

## About

YALWEE - yet another lightweight execution environment.

The project is divided into multiple parts:
  1. interpreter parts (written in x86_64 assembly)
  2. interpreter builder scripts
  3. embedding API
  4. useful utilities and scripts (tooling)

The user writes an *specification* which selects parts
to be included into execution environment (interpreter).
Specification can be used to build interpreter and associated
bindings/extensions for programming languages.

For example, one can create some interpreter and embed it
into *Ruby* programming language.
Once embedded, generated API can be used to emit wordcode
(2-byte wide bytecode) at run time. Emitted code can be
evaluated by embedded interpreter.



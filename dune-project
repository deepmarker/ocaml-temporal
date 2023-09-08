(lang dune 3.10)

(name temporal)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name temporal)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   ocaml
   dune
   ocaml-protoc-plugin
 )
 (tags
  (topics "to describe" your project)))

(package
 (name temporal-async)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   ocaml
   dune
   temporal
   core
   async
 )
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project

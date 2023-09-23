(lang dune 3.10)

(name temporal)

(generate_opam_files true)

(source
 (github deepmarker/ocaml-temporal))

(authors "Vincent Bernardoff")

(maintainers "Vincent Bernardoff")

(license ISC)

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

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project

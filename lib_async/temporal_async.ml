open Core
open Async
open Ocaml_protoc_plugin

(*
   Temporal has 2 services: Workflow Service and Operator Service
*)

(* TODO: Use this to make permament connections. *)
let dial (hp : Host_and_port.t) =
  let%bind socket =
    let%bind addresses =
      Unix.Addr_info.get
        ~host:hp.host
        ~service:(Int.to_string hp.port)
        [ Unix.Addr_info.AI_FAMILY Unix.PF_INET ]
    in
    let socket = Unix.Socket.create Unix.Socket.Type.tcp in
    let address =
      let sockaddr =
        match addresses with
        | hd :: _ -> hd.Unix.Addr_info.ai_addr
        | [] -> Format.kasprintf failwith "No address for %a" Host_and_port.pp hp
      in
      match sockaddr with
      | Unix.ADDR_INET (a, i) -> `Inet (a, i)
      | ADDR_UNIX _ ->
        (* Cannot happen. *)
        assert false
    in
    Unix.Socket.connect socket address
  in
  let error_handler = function
    | `Invalid_response_body_length _resp -> printf "invalid response body length\n%!"
    | `Exn _exn -> printf "exception!\n%!"
    | `Malformed_response s -> printf "malformed response: %s\n%!" s
    | `Protocol_error (code, s) ->
      printf "protocol error: %s, %s\n" (H2.Error_code.to_string code) s
  in
  H2_async.Client.create_connection ~error_handler socket
  >>| fun conn -> conn, error_handler
;;

let call connection error_handler ?(scheme = "http") ~service ~rpc client_funs req =
  (* code generation *)
  printf "CONNECTED!\n";
  let encode, decode = Service.make_client_functions client_funs in
  let enc = encode req |> Writer.contents in
  let response_handler = function
    | None -> assert false
    | Some response ->
      let response =
        Reader.create response
        |> decode
        |> function
        | Ok v -> v
        | Error e ->
          failwith
            (Printf.sprintf
               "Could not decode request: %s"
               (Ocaml_protoc_plugin.Result.show_error e))
      in
      return response
  in
  let handler =
    Grpc_async.Client.Rpc.unary ~encoded_request:enc ~handler:response_handler
  in
  let headers =
    H2.Headers.of_list
      [ "te", "trailers"
      ; "content-type", "application/grpc"
      ; "grpc-accept-encoding", "identity"
      ; ":authority", "127.0.0.1:9100"
      ]
  in
  let do_request = H2_async.Client.request connection ~error_handler in
  Grpc_async.Client.call ~headers ~scheme ~service ~rpc ~do_request ~handler ()
;;

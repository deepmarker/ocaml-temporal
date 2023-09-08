open Core
open Async
open Ocaml_protoc_plugin
open H2
open H2_async

val dial
  :  Host_and_port.t
  -> (Socket.Address.Inet.t Client.t * Client_connection.error_handler) Deferred.t

val call
  :  [< Socket.Address.t ] Client.t
  -> Client_connection.error_handler
  -> ?scheme:string
  -> service:string
  -> rpc:string
  -> (module Service.Message with type t = 'a) * (module Service.Message with type t = 'b)
  -> 'a
  -> ('b * Grpc.Status.t, Grpc.Status.t) result Deferred.t

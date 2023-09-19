module Batch = TemporalApiBatchV1Message

module Command = struct
  include TemporalApiCommandV1Message
  open TemporalApiEnumsV1Command_type.CommandType

  (* timers *)

  let start_timer arg =
    Command.make
      ~command_type:COMMAND_TYPE_START_TIMER
      ~attributes:(`Start_timer_command_attributes arg)
      ()
  ;;

  let cancel_timer arg =
    Command.make
      ~command_type:COMMAND_TYPE_CANCEL_TIMER
      ~attributes:(`Cancel_timer_command_attributes arg)
      ()
  ;;

  (* workflow tasks *)

  let complete_workflow_execution arg =
    Command.make
      ~command_type:COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
      ~attributes:(`Complete_workflow_execution_command_attributes arg)
      ()
  ;;

  let fail_workflow_execution arg =
    Command.make
      ~command_type:COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
      ~attributes:(`Fail_workflow_execution_command_attributes arg)
      ()
  ;;

  let cancel_workflow_execution arg =
    Command.make
      ~command_type:COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
      ~attributes:(`Cancel_workflow_execution_command_attributes arg)
      ()
  ;;

  let continue_as_new_workflow_execution arg =
    Command.make
      ~command_type:COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
      ~attributes:(`Continue_as_new_workflow_execution_command_attributes arg)
      ()
  ;;

  (* external workflows *)

  let request_cancel_external_workflow_execution arg =
    Command.make
      ~command_type:COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
      ~attributes:(`Request_cancel_external_workflow_execution_command_attributes arg)
      ()
  ;;

  let signal_external_workflow_execution arg =
    Command.make
      ~command_type:COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
      ~attributes:(`Signal_external_workflow_execution_command_attributes arg)
      ()
  ;;

  (* child workflows *)

  let start_child_workflow_execution arg =
    Command.make
      ~command_type:COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
      ~attributes:(`Start_child_workflow_execution_command_attributes arg)
      ()
  ;;

  (* activity tasks *)

  let schedule_activity_task arg =
    Command.make
      ~command_type:COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
      ~attributes:(`Schedule_activity_task_command_attributes arg)
      ()
  ;;

  let request_cancel_activity_task arg =
    Command.make
      ~command_type:COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
      ~attributes:(`Request_cancel_activity_task_command_attributes arg)
      ()
  ;;

  (* misc. *)

  let record_marker arg =
    Command.make
      ~command_type:COMMAND_TYPE_RECORD_MARKER
      ~attributes:(`Record_marker_command_attributes arg)
      ()
  ;;

  let upsert_workflow_search_attributes arg =
    Command.make
      ~command_type:COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
      ~attributes:(`Upsert_workflow_search_attributes_command_attributes arg)
      ()
  ;;

  let modify_workflow_properties arg =
    Command.make
      ~command_type:COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
      ~attributes:(`Modify_workflow_properties_command_attributes arg)
      ()
  ;;
end

module Common = TemporalApiCommonV1Message

module Enums = struct
  include TemporalApiEnumsV1Batch_operation
  include TemporalApiEnumsV1Command_type
  include TemporalApiEnumsV1Common
  include TemporalApiEnumsV1Event_type
  include TemporalApiEnumsV1Failed_cause
  include TemporalApiEnumsV1Namespace
  include TemporalApiEnumsV1Query
  include TemporalApiEnumsV1Reset
  include TemporalApiEnumsV1Schedule
  include TemporalApiEnumsV1Task_queue
  include TemporalApiEnumsV1Update
  include TemporalApiEnumsV1Workflow
end

module ErrorDetails = TemporalApiErrordetailsV1Message
module Failure = TemporalApiFailureV1Message
module Filter = TemporalApiFilterV1Message
module History = TemporalApiHistoryV1Message
module Namespace = TemporalApiNamespaceV1Message

module OperatorService = struct
  include TemporalApiOperatorserviceV1Request_response
  include TemporalApiOperatorserviceV1Service
end

module Protocol = TemporalApiProtocolV1Message
module Query = TemporalApiQueryV1Message
module Replication = TemporalApiReplicationV1Message
module Schedule = TemporalApiScheduleV1Message
module SDK = TemporalApiSdkV1Task_complete_metadata
module TaskQueue = TemporalApiTaskqueueV1Message
module Update = TemporalApiUpdateV1Message
module Version = TemporalApiVersionV1Message
module Workflow = TemporalApiWorkflowV1Message

module WorkflowService = struct
  include TemporalApiWorkflowserviceV1Request_response
  include TemporalApiWorkflowserviceV1Service
end

module Batch = TemporalApiBatchV1Message

module Command = struct
  include TemporalApiCommandV1Message
  open TemporalApiEnumsV1Command_type.CommandType

  (* timers *)

  let start_timer arg =
    Command.create
      ~command_type:COMMAND_TYPE_START_TIMER
      ~attributes:(`Start_timer_command_attributes arg)
      ()
  ;;

  let cancel_timer arg =
    Command.create
      ~command_type:COMMAND_TYPE_CANCEL_TIMER
      ~attributes:(`Cancel_timer_command_attributes arg)
      ()
  ;;

  (* workflow tasks *)

  let complete_workflow_execution arg =
    Command.create
      ~command_type:COMMAND_TYPE_COMPLETE_WORKFLOW_EXECUTION
      ~attributes:(`Complete_workflow_execution_command_attributes arg)
      ()
  ;;

  let fail_workflow_execution arg =
    Command.create
      ~command_type:COMMAND_TYPE_FAIL_WORKFLOW_EXECUTION
      ~attributes:(`Fail_workflow_execution_command_attributes arg)
      ()
  ;;

  let cancel_workflow_execution arg =
    Command.create
      ~command_type:COMMAND_TYPE_CANCEL_WORKFLOW_EXECUTION
      ~attributes:(`Cancel_workflow_execution_command_attributes arg)
      ()
  ;;

  let continue_as_new_workflow_execution arg =
    Command.create
      ~command_type:COMMAND_TYPE_CONTINUE_AS_NEW_WORKFLOW_EXECUTION
      ~attributes:(`Continue_as_new_workflow_execution_command_attributes arg)
      ()
  ;;

  (* external workflows *)

  let request_cancel_external_workflow_execution arg =
    Command.create
      ~command_type:COMMAND_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION
      ~attributes:(`Request_cancel_external_workflow_execution_command_attributes arg)
      ()
  ;;

  let signal_external_workflow_execution arg =
    Command.create
      ~command_type:COMMAND_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION
      ~attributes:(`Signal_external_workflow_execution_command_attributes arg)
      ()
  ;;

  (* child workflows *)

  let start_child_workflow_execution arg =
    Command.create
      ~command_type:COMMAND_TYPE_START_CHILD_WORKFLOW_EXECUTION
      ~attributes:(`Start_child_workflow_execution_command_attributes arg)
      ()
  ;;

  (* activity tasks *)

  let schedule_activity_task arg =
    Command.create
      ~command_type:COMMAND_TYPE_SCHEDULE_ACTIVITY_TASK
      ~attributes:(`Schedule_activity_task_command_attributes arg)
      ()
  ;;

  let request_cancel_activity_task arg =
    Command.create
      ~command_type:COMMAND_TYPE_REQUEST_CANCEL_ACTIVITY_TASK
      ~attributes:(`Request_cancel_activity_task_command_attributes arg)
      ()
  ;;

  (* misc. *)

  let record_marker arg =
    Command.create
      ~command_type:COMMAND_TYPE_RECORD_MARKER
      ~attributes:(`Record_marker_command_attributes arg)
      ()
  ;;

  let upsert_workflow_search_attributes arg =
    Command.create
      ~command_type:COMMAND_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
      ~attributes:(`Upsert_workflow_search_attributes_command_attributes arg)
      ()
  ;;

  let modify_workflow_properties arg =
    Command.create
      ~command_type:COMMAND_TYPE_MODIFY_WORKFLOW_PROPERTIES
      ~attributes:(`Modify_workflow_properties_command_attributes arg)
      ()
  ;;
end

module Common = struct
  include TemporalApiCommonV1Message

  module WorkflowExecution = struct
    module T = struct
      include WorkflowExecution

      let equal x y =
        String.(equal x.workflow_id y.workflow_id && equal x.run_id y.run_id)
      ;;

      let hash x =
        let open Base.Hash in
        let h = create () in
        let h = fold_string h x.workflow_id in
        fold_string h x.run_id |> get_hash_value
      ;;
    end

    include T
    module Table = Hashtbl.Make (T)
  end
end

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

module History = struct
  include TemporalApiHistoryV1Message

  type history_event =
    (* Workflow Execution *)
    | WorkflowExecutionStarted of WorkflowExecutionStartedEventAttributes.t
    | WorkflowExecutionCompleted of WorkflowExecutionCompletedEventAttributes.t
    | WorkflowExecutionFailed of WorkflowExecutionFailedEventAttributes.t
    | WorkflowExecutionTimedOut of WorkflowExecutionTimedOutEventAttributes.t
    | WorkflowExecutionCancelRequested of
        WorkflowExecutionCancelRequestedEventAttributes.t
    | WorkflowExecutionCanceled of WorkflowExecutionCanceledEventAttributes.t
    | WorkflowExecutionSignaled of WorkflowExecutionSignaledEventAttributes.t
    | WorkflowExecutionTerminated of WorkflowExecutionTerminatedEventAttributes.t
    | WorkflowExecutionContinuedAsNew of WorkflowExecutionContinuedAsNewEventAttributes.t
    | WorkflowExecutionUpdateAccepted of WorkflowExecutionUpdateAcceptedEventAttributes.t
    | WorkflowExecutionUpdateRejected of WorkflowExecutionUpdateRejectedEventAttributes.t
    | WorkflowExecutionUpdateCompleted of
        WorkflowExecutionUpdateCompletedEventAttributes.t
    (* Workflow Task *)
    | WorkflowTaskScheduled of WorkflowTaskScheduledEventAttributes.t
    | WorkflowTaskStarted of WorkflowTaskStartedEventAttributes.t
    | WorkflowTaskCompleted of WorkflowTaskCompletedEventAttributes.t
    | WorkflowTaskTimedOut of WorkflowTaskTimedOutEventAttributes.t
    | WorkflowTaskFailed of WorkflowTaskFailedEventAttributes.t
    (* Activity Task *)
    | ActivityTaskScheduled of ActivityTaskScheduledEventAttributes.t
    | ActivityTaskStarted of ActivityTaskStartedEventAttributes.t
    | ActivityTaskCompleted of ActivityTaskCompletedEventAttributes.t
    | ActivityTaskFailed of ActivityTaskFailedEventAttributes.t
    | ActivityTaskTimedOut of ActivityTaskTimedOutEventAttributes.t
    | ActivityTaskCancelRequested of ActivityTaskCancelRequestedEventAttributes.t
    | ActivityTaskCanceled of ActivityTaskCanceledEventAttributes.t
    (* Timer *)
    | TimerStarted of TimerStartedEventAttributes.t
    | TimerFired of TimerFiredEventAttributes.t
    | TimerCanceled of TimerCanceledEventAttributes.t
    (* Marker Recorded *)
    | MarkerRecorded of MarkerRecordedEventAttributes.t
    (* Child Workflows *)
    | StartChildWorkflowExecutionInitiated of
        StartChildWorkflowExecutionInitiatedEventAttributes.t
    | StartChildWorkflowExecutionFailed of
        StartChildWorkflowExecutionFailedEventAttributes.t
    | ChildWorkflowExecutionStarted of ChildWorkflowExecutionStartedEventAttributes.t
    | ChildWorkflowExecutionCompleted of ChildWorkflowExecutionCompletedEventAttributes.t
    | ChildWorkflowExecutionFailed of ChildWorkflowExecutionFailedEventAttributes.t
    | ChildWorkflowExecutionCanceled of ChildWorkflowExecutionCanceledEventAttributes.t
    | ChildWorkflowExecutionTimedOut of ChildWorkflowExecutionTimedOutEventAttributes.t
    | ChildWorkflowExecutionTerminated of
        ChildWorkflowExecutionTerminatedEventAttributes.t
    | RequestCancelExternalWorkflowExecutionInitiated of
        RequestCancelExternalWorkflowExecutionInitiatedEventAttributes.t
    | RequestCancelExternalWorkflowExecutionFailed of
        RequestCancelExternalWorkflowExecutionFailedEventAttributes.t
    | ExternalWorkflowExecutionCancelRequested of
        ExternalWorkflowExecutionCancelRequestedEventAttributes.t
    | SignalExternalWorkflowExecutionInitiated of
        SignalExternalWorkflowExecutionInitiatedEventAttributes.t
    | SignalExternalWorkflowExecutionFailed of
        SignalExternalWorkflowExecutionFailedEventAttributes.t
    | ExternalWorkflowExecutionSignaled of
        ExternalWorkflowExecutionSignaledEventAttributes.t
    | UpsertWorkflowSearchAttributes of UpsertWorkflowSearchAttributesEventAttributes.t
    | WorkflowPropertiesModifiedExternally of
        WorkflowPropertiesModifiedExternallyEventAttributes.t
    | ActivityPropertiesModifiedExternally of
        ActivityPropertiesModifiedExternallyEventAttributes.t
    | WorkflowPropertiesModified of WorkflowPropertiesModifiedEventAttributes.t

  let history_event (x : HistoryEvent.t) =
    match x.event_type, x.attributes with
    | TemporalApiEnumsV1Event_type.EventType.EVENT_TYPE_UNSPECIFIED, _ ->
      invalid_arg "unspecified"
    (* Workflow Execution events *)
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_STARTED
      , `Workflow_execution_started_event_attributes attr ) ->
      WorkflowExecutionStarted attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED
      , `Workflow_execution_completed_event_attributes attr ) ->
      WorkflowExecutionCompleted attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_FAILED
      , `Workflow_execution_failed_event_attributes attr ) -> WorkflowExecutionFailed attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_TIMED_OUT
      , `Workflow_execution_timed_out_event_attributes attr ) ->
      WorkflowExecutionTimedOut attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_CANCEL_REQUESTED
      , `Workflow_execution_cancel_requested_event_attributes attr ) ->
      WorkflowExecutionCancelRequested attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_CANCELED
      , `Workflow_execution_canceled_event_attributes attr ) ->
      WorkflowExecutionCanceled attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_SIGNALED
      , `Workflow_execution_signaled_event_attributes attr ) ->
      WorkflowExecutionSignaled attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_TERMINATED
      , `Workflow_execution_terminated_event_attributes attr ) ->
      WorkflowExecutionTerminated attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_CONTINUED_AS_NEW
      , `Workflow_execution_continued_as_new_event_attributes attr ) ->
      WorkflowExecutionContinuedAsNew attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_ACCEPTED
      , `Workflow_execution_update_accepted_event_attributes attr ) ->
      WorkflowExecutionUpdateAccepted attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_REJECTED
      , `Workflow_execution_update_rejected_event_attributes attr ) ->
      WorkflowExecutionUpdateRejected attr
    | ( EVENT_TYPE_WORKFLOW_EXECUTION_UPDATE_COMPLETED
      , `Workflow_execution_update_completed_event_attributes attr ) ->
      WorkflowExecutionUpdateCompleted attr
    (* Workflow Tasks events *)
    | EVENT_TYPE_WORKFLOW_TASK_SCHEDULED, `Workflow_task_scheduled_event_attributes attr
      -> WorkflowTaskScheduled attr
    | EVENT_TYPE_WORKFLOW_TASK_STARTED, `Workflow_task_started_event_attributes attr ->
      WorkflowTaskStarted attr
    | EVENT_TYPE_WORKFLOW_TASK_COMPLETED, `Workflow_task_completed_event_attributes attr
      -> WorkflowTaskCompleted attr
    | EVENT_TYPE_WORKFLOW_TASK_TIMED_OUT, `Workflow_task_timed_out_event_attributes attr
      -> WorkflowTaskTimedOut attr
    | EVENT_TYPE_WORKFLOW_TASK_FAILED, `Workflow_task_failed_event_attributes attr ->
      WorkflowTaskFailed attr
    (* Activity Tasks events *)
    | EVENT_TYPE_ACTIVITY_TASK_SCHEDULED, `Activity_task_scheduled_event_attributes attr
      -> ActivityTaskScheduled attr
    | EVENT_TYPE_ACTIVITY_TASK_STARTED, `Activity_task_started_event_attributes attr ->
      ActivityTaskStarted attr
    | EVENT_TYPE_ACTIVITY_TASK_COMPLETED, `Activity_task_completed_event_attributes attr
      -> ActivityTaskCompleted attr
    | EVENT_TYPE_ACTIVITY_TASK_FAILED, `Activity_task_failed_event_attributes attr ->
      ActivityTaskFailed attr
    | EVENT_TYPE_ACTIVITY_TASK_TIMED_OUT, `Activity_task_timed_out_event_attributes attr
      -> ActivityTaskTimedOut attr
    | ( EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED
      , `Activity_task_cancel_requested_event_attributes attr ) ->
      ActivityTaskCancelRequested attr
    | EVENT_TYPE_ACTIVITY_TASK_CANCELED, `Activity_task_canceled_event_attributes attr ->
      ActivityTaskCanceled attr
    (* Timer events *)
    | EVENT_TYPE_TIMER_STARTED, `Timer_started_event_attributes attr -> TimerStarted attr
    | EVENT_TYPE_TIMER_FIRED, `Timer_fired_event_attributes attr -> TimerFired attr
    | EVENT_TYPE_TIMER_CANCELED, `Timer_canceled_event_attributes attr ->
      TimerCanceled attr
    (* Marker Recorded *)
    | EVENT_TYPE_MARKER_RECORDED, `Marker_recorded_event_attributes attr ->
      MarkerRecorded attr
    (* Child workflows *)
    | ( EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_INITIATED
      , `Start_child_workflow_execution_initiated_event_attributes attr ) ->
      StartChildWorkflowExecutionInitiated attr
    | ( EVENT_TYPE_START_CHILD_WORKFLOW_EXECUTION_FAILED
      , `Start_child_workflow_execution_failed_event_attributes attr ) ->
      StartChildWorkflowExecutionFailed attr
    | ( EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_STARTED
      , `Child_workflow_execution_started_event_attributes attr ) ->
      ChildWorkflowExecutionStarted attr
    | ( EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_COMPLETED
      , `Child_workflow_execution_completed_event_attributes attr ) ->
      ChildWorkflowExecutionCompleted attr
    | ( EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_FAILED
      , `Child_workflow_execution_failed_event_attributes attr ) ->
      ChildWorkflowExecutionFailed attr
    | ( EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_CANCELED
      , `Child_workflow_execution_canceled_event_attributes attr ) ->
      ChildWorkflowExecutionCanceled attr
    | ( EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TIMED_OUT
      , `Child_workflow_execution_timed_out_event_attributes attr ) ->
      ChildWorkflowExecutionTimedOut attr
    | ( EVENT_TYPE_CHILD_WORKFLOW_EXECUTION_TERMINATED
      , `Child_workflow_execution_terminated_event_attributes attr ) ->
      ChildWorkflowExecutionTerminated attr
    (* External workflows *)
    | ( EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
      , `Request_cancel_external_workflow_execution_initiated_event_attributes attr ) ->
      RequestCancelExternalWorkflowExecutionInitiated attr
    | ( EVENT_TYPE_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
      , `Request_cancel_external_workflow_execution_failed_event_attributes attr ) ->
      RequestCancelExternalWorkflowExecutionFailed attr
    | ( EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_CANCEL_REQUESTED
      , `External_workflow_execution_cancel_requested_event_attributes attr ) ->
      ExternalWorkflowExecutionCancelRequested attr
    | ( EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_INITIATED
      , `Signal_external_workflow_execution_initiated_event_attributes attr ) ->
      SignalExternalWorkflowExecutionInitiated attr
    | ( EVENT_TYPE_SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED
      , `Signal_external_workflow_execution_failed_event_attributes attr ) ->
      SignalExternalWorkflowExecutionFailed attr
    | ( EVENT_TYPE_EXTERNAL_WORKFLOW_EXECUTION_SIGNALED
      , `External_workflow_execution_signaled_event_attributes attr ) ->
      ExternalWorkflowExecutionSignaled attr
    | ( EVENT_TYPE_UPSERT_WORKFLOW_SEARCH_ATTRIBUTES
      , `Upsert_workflow_search_attributes_event_attributes attr ) ->
      UpsertWorkflowSearchAttributes attr
    (* Workflow/Activity properties *)
    | ( EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED_EXTERNALLY
      , `Workflow_properties_modified_externally_event_attributes attr ) ->
      WorkflowPropertiesModifiedExternally attr
    | ( EVENT_TYPE_ACTIVITY_PROPERTIES_MODIFIED_EXTERNALLY
      , `Activity_properties_modified_externally_event_attributes attr ) ->
      ActivityPropertiesModifiedExternally attr
    | ( EVENT_TYPE_WORKFLOW_PROPERTIES_MODIFIED
      , `Workflow_properties_modified_event_attributes attr ) ->
      WorkflowPropertiesModified attr
    | _ -> assert false
  ;;

  let history_event x =
    match history_event x with
    | exception Invalid_argument _ -> None
    | x -> Some x
  ;;
end

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

module Batch = TemporalApiBatchV1Message
module Command = TemporalApiCommandV1Message
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

%%======================================================================
%%
%% Leo S3 Auth
%%
%% Copyright (c) 2012-2014 Rakuten, Inc.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% ---------------------------------------------------------------------
%% Leo S3 Auth
%% @doc
%% @end
%%======================================================================
%% @doc Credential data
%%
-record(credential, {
          access_key_id     :: binary(),
          secret_access_key :: binary(),
          created_at        :: integer()
         }).

%% @doc Authentication Info
%%
-record(auth_info, {
          db            :: atom(), %% db-type:[ets | mnesia]
          provider = [] :: list()  %% auth-info provides
         }).

%% @doc AMZ-S3-API related
%%
-record(sign_params, {
          http_verb    = <<>> :: binary(),
          content_md5  = <<>> :: binary(),
          content_type = <<>> :: binary(),
          date         = <<>> :: binary(),
          bucket       = <<>> :: binary(),
          uri          = <<>> :: binary(),
          query_str    = <<>> :: binary(),
          sub_resource = <<>> :: binary(), %% [?acl" | "?location" | "?logging" | "?torrent"]
          amz_headers  = []   :: list()
         }).


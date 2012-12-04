%%======================================================================
%%
%% Leo S3 User
%%
%% Copyright (c) 2012 Rakuten, Inc.
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
%% Leo S3 User
%% @doc
%% @end
%%======================================================================
-define(ROLE_GENERAL, 1).
-define(ROLE_ADMIN,   9).

-record(user, {
          id              :: binary(),
          password = <<>> :: binary(),
          role_id = 0     :: integer(),
          created_at = 0  :: integer()
         }).
-record(user_credential, {
          user_id         :: binary(),
          access_key_id   :: binary(),
          created_at = 0  :: integer()
         }).

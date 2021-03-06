#
# Copyright 2014 John Bellone <jbellone@bloomberg.net>
# Copyright 2014 Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

use_inline_resources if defined? use_inline_resources

def set_updated
  r = yield
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end

action :create do
  set_updated do
    file new_resource.path do
      user node['consul']['service_user']
      group node['consul']['service_group']
      mode 0600
      content new_resource.to_json
      action :create
    end
  end
end

action :delete do
  set_updated do
    file new_resource.path do
      action :delete
    end
  end
end

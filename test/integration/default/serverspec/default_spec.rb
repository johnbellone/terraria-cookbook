require 'serverspec'
set :backend, :exec

describe group('terraria') do
  it { should exist }
end


describe user('terraria') do
  it { should exist }
end

describe service('terraria') do
  it { should be_enabled }
  it { should be_running }
end

describe file('c:\Program Files\Apache Software Foundation\Apache2.4\bin\httpd.exe') do
  it { should exist }
end

describe command('cmd /c "c:\Program Files\Apache Software Foundation\Apache2.4\bin\httpd.exe" -v') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match %r{Server version: Apache/2.4.28} }
  its('stdout') { should match %r{Server version: Apache/2.4.28 \(Win64\)} }
end

describe file('c:\Program Files\Apache Software Foundation\Apache2.4\ssl\server.crt') do
  it { should exist }
  its('content') { should match(/--BEGIN CERTIFICATE--/) }
  its('content') { should match(/--END CERTIFICATE--/) }
end

describe file('c:\Program Files\Apache Software Foundation\Apache2.4\ssl\server.key') do
  it { should exist }
  its('content') { should match(/--BEGIN PRIVATE KEY--/) }
  its('content') { should match(/--END PRIVATE KEY--/) }
end

describe http('http://localhost') do
  its('status') { should eq 200 }
  its('body') { should match(/It works!/) }
end

describe http('https://localhost', ssl_verify: false) do
  its('status') { should eq 200 }
  its('body') { should match(/It works!/) }
end

describe file('c:\Program Files\Apache Software Foundation\Apache2.4\vhosts.d\server1.conf') do
  it { should exist }
  its(:content) { should match(/ServerName server1/) }
end

describe file('c:\Program Files\Apache Software Foundation\Apache2.4\vhosts.d\server2.conf') do
  it { should exist }
  its(:content) { should match(/ServerName server2/) }
end

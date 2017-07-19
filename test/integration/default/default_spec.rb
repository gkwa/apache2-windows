describe file('c:\Program Files (x86)\Apache Software Foundation\Apache2.4\bin\httpd.exe') do
  it { should exist }
end

describe command('cmd /c "c:\Program Files (x86)\Apache Software Foundation\Apache2.4\bin\httpd.exe" -v') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match %r{Server version: Apache/2.4.27} }
end

describe http('http://localhost') do
  its('status') { should eq 200 }
  its('body') { should eq "<html><body><h1>It works!</h1></body></html>\r\n" }
end

describe file('c:\Program Files (x86)\Apache Software Foundation\Apache2.4\vhosts.d\server1.conf') do
  it { should exist }
  its(:content) { should match(/ServerName server1/) }
end

describe file('c:\Program Files (x86)\Apache Software Foundation\Apache2.4\vhosts.d\server2.conf') do
  it { should exist }
  its(:content) { should match(/ServerName server2/) }
end

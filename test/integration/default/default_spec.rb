describe file('c:\Program Files (x86)\Apache Software Foundation\Apache2.2\bin\httpd.exe') do
  it { should exist }
end

describe command('cmd /c "c:\Program Files (x86)\Apache Software Foundation\Apache2.2\bin\httpd.exe" -v') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match %r{Server version: Apache/2.2.25} }
end

describe file('c:\Program Files (x86)\Apache Software Foundation\Apache2.2\vhosts.d\server1.conf') do
  it { should exist }
  its(:content) { should match(/ServerName server1/) }
end

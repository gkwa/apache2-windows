describe file('c:\Program Files\Apache Software Foundation\Apache2.4\conf.d\php.conf') do
  it { should exist }
end

describe command('cmd /c "c:\Program Files\Apache Software Foundation\Apache2.4\bin\httpd.exe" -t -D DUMP_INCLUDES') do
  its('stdout') { should match %r{\(\d+\) C:/Program Files/Apache Software Foundation/Apache2.4/conf.d/php.conf} }
end

describe command('cmd /c "c:\Program Files\Apache Software Foundation\Apache2.4\bin\httpd.exe" -t -D DUMP_INCLUDES') do
  its('stdout') { should match %r{\(\d+\) C:/Program Files/Apache Software Foundation/Apache2.4/conf.d/some_other.conf} }
end

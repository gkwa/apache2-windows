source=~/Downloads/httpd-2.4.27-Win64-VC15/Apache24/conf/original

cp $source/httpd.conf templates/default/httpd.conf.erb
cp $source/extra/httpd-autoindex.conf templates/default/httpd-autoindex.conf.erb
cp $source/extra/httpd-dav.conf templates/default/httpd-dav.conf.erb
cp $source/extra/httpd-default.conf templates/default/httpd-default.conf.erb
cp $source/extra/httpd-info.conf templates/default/httpd-info.conf.erb
cp $source/extra/httpd-languages.conf templates/default/httpd-languages.conf.erb
cp $source/extra/httpd-manual.conf templates/default/httpd-manual.conf.erb
cp $source/extra/httpd-mpm.conf templates/default/httpd-mpm.conf.erb
cp $source/extra/httpd-multilang-errordoc.conf templates/default/httpd-multilang-errordoc.conf.erb
cp $source/extra/httpd-ssl.conf templates/default/httpd-ssl.conf.erb
cp $source/extra/httpd-userdir.conf templates/default/httpd-userdir.conf.erb
cp $source/extra/httpd-vhosts.conf templates/default/httpd-vhosts.conf.erb
cp $source/extra/proxy-html.conf templates/default/proxy-html.conf.erb

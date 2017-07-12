FROM centos:6

MAINTAINER "HaiDV" <haidv6773@co-well.com.vn>

RUN yum -y install httpd php php-cli mod_security jq
RUN /sbin/chkconfig httpd on

ADD php.info /var/www/html/php.info
#ADD test.php /var/www/html/test.php
#ADD www /var/www/html/www

EXPOSE 80

# Start the service
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

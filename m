Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlL8p-0001lY-0J for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 20:47:59 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AlL8o-0002fd-4j
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 20:47:58 -0800
Received: from localhost ([127.0.0.1]:36258 helo=shearer.org)
	by shearer.org with esmtp (Dan's MTA 1.0) id 1AlLB1-00008B-A8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 15:20:15 +1030
Received: from dan by erizo.shearer.org with local (Spammer Slammer 3.141)
	id 1AlLB0-000088-7G for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 15:20:14 +1030
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040127045014.GZ4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
Subject: [uml-devel] PATCH check for sys_sendfile() in port_user.c
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 27 Jan 2004 15:20:14 +1030
To: user-mode-linux-devel@lists.sourceforge.net



--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Some kernels (including SuSE 2.4.20, according to
http://marc.theaimsgroup.com/?l=user-mode-linux-user&m=107437381718023&w=2)
don't have sys_sendfile, in which case the port console driver should
refuse to start up because there is no way for telnetd to get the fd.
This might not be obvious to debug.

NOTE! Not tested because it doesn't bite me! Beyond the fact that it
works on systems *with* sendfile() :-)

Should be the final word in anyone who wants to throw out commandline
parameter passing for xterm in favour of fd passing.

(And one more tiny little portability aid.)

-- 
Dan Shearer
dan@shearer.org

--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=sendfile_patch

--- port_user.c.orig	2004-01-24 15:48:53.000000000 +1030
+++ port_user.c	2004-01-27 15:05:40.000000000 +1030
@@ -35,6 +35,11 @@
 	char *end;
 	int port;
 
+	if(sys_sendfile() == -1){
+		printk("port_init : host kernel doesn't support sendfile()\n");
+		return(NULL);
+	}
+
 	if(*str != ':'){
 		printk("port_init : channel type 'port' must specify a "
 		       "port number\n");

--1ccMZA6j1vT5UqiK--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

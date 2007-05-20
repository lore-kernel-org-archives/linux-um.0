Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HplnX-0006it-Mx for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 May 2007 06:50:11 -0700
Received: from smtp6-g19.free.fr ([212.27.42.36])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HplnW-0007SF-9P
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 May 2007 06:50:11 -0700
Message-ID: <465052A5.9020602@free.fr>
Date: Sun, 20 May 2007 15:52:37 +0200
From: "Jean-Yves Didier" <jydidier@free.fr>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] User-mode Linux: Port driver host system
	independence strengthened.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@karaya.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


Port driver no longer need a telnet daemon and port-helper at fixed 
locations on the host system. Fixed locations are still checked. If 
detection failed, it will look for links or programs named uml.telnetd 
and port-helper in user pathes list.

Signed-off-by: Jean-Yves Didier <jydidier@free.fr>
---
--- linux-2.6.21.1/arch/um/drivers/port_user.c.orig     2007-05-20 
13:57:31.000000000 +0200
+++ linux-2.6.21.1/arch/um/drivers/port_user.c  2007-05-20 
13:59:23.000000000 +0200
@@ -177,6 +177,12 @@ int port_connection(int fd, int *socket,
                         "/usr/lib/uml/port-helper", NULL };
        struct port_pre_exec_data data;

+       if(os_access(argv[0], OS_ACC_X_OK) < 0)
+               argv[0] = "uml.telnetd";
+
+       if(os_access(argv[2], OS_ACC_X_OK) < 0)
+               argv[2] = "port-helper";
+
        new = os_accept_connection(fd);
        if(new < 0)
                return new;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

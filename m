Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7TdJ-0001MK-3T for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 22:18:57 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B7TdI-0000JC-BH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 22:18:56 -0800
Received: from tuxrocks.com (localhost.localdomain [127.0.0.1])
	by tuxrocks.com (8.12.8/8.12.8) with ESMTP id i2S6IuF0002048
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 27 Mar 2004 23:18:56 -0700
Received: from localhost (frank@localhost)
	by tuxrocks.com (8.12.8/8.12.8/Submit) with ESMTP id i2S6ItiR002045
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 27 Mar 2004 23:18:55 -0700
From: Frank Sorenson <frank@tuxrocks.com>
Message-ID: <Pine.LNX.4.44.0403272104170.1544-100000@tuxrocks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Patch to show status of UML
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
Date: Sat, 27 Mar 2004 23:18:55 -0700 (MST)
To: user-mode-linux-devel@lists.sourceforge.net

Here is a patch to UML to allow uml_mconsole to report the 'status' of the
UML (whether the UML is Stopped or Running).  The 'status' command could
easily be extended to add other information.  This patch should apply to 
the 2.4.24 kernel, after the standard UML patch.

Frank
frank@tuxrocks.com
http://sco.tuxrocks.com



##### uml-status-patch #####
diff -Naur orig/arch/um/drivers/mconsole_kern.c linux-2.4.24/arch/um/drivers/mconsole_kern.c
--- orig/arch/um/drivers/mconsole_kern.c	2004-03-27 02:00:28.000000000 -0700
+++ linux-2.4.24/arch/um/drivers/mconsole_kern.c	2004-03-27 02:10:11.000000000 -0700
@@ -216,6 +216,7 @@
     sysrq <letter> - Performs the SysRq action controlled by the letter \n\
     cad - invoke the Ctl-Alt-Del handler \n\
     stop - pause the UML; it will do nothing until it receives a 'go' \n\
+    status - check to see if the UML is stopped or running\n\
     go - continue the UML after a 'stop' \n\
     log <string> - make UML enter <string> into the kernel log\n\
     proc <file> - returns the contents of the UML's /proc/<file>\n\
@@ -251,15 +252,39 @@
 	mconsole_reply(req, "Not stopped", 1, 0);
 }
 
+void mconsole_status(struct mc_request *req)
+{
+	/* CurrentStatus of 'R' indicates running */
+	/* CurrentStatus of 'S' indicates a stopped UML */
+	static char CurrentStatus = 'R';
+
+	if (req->cmd->handler == mconsole_status)
+	{
+		if (CurrentStatus == 'S') mconsole_reply(req, "Stopped", 0, 0);
+		else mconsole_reply(req, "Running", 0, 0);
+	}
+	else if (req->cmd->handler == mconsole_stop)
+	{
+		CurrentStatus = 'S';
+	}
+	else if (req->cmd->handler == mconsole_go)
+	{
+		CurrentStatus = 'R';
+	}
+	else mconsole_reply(req, "", 1, 0);
+}
+
 void mconsole_stop(struct mc_request *req)
 {
 	deactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	os_set_fd_block(req->originating_fd, 1);
+	mconsole_status(req); /* change the status to stopped */
 	mconsole_reply(req, "", 0, 0);
 	while(mconsole_get_request(req->originating_fd, req)){
 		if(req->cmd->handler == mconsole_go) break;
 		(*req->cmd->handler)(req);
 	}
+	mconsole_status(req); /* change the status back to running */
 	os_set_fd_block(req->originating_fd, 0);
 	reactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	mconsole_reply(req, "", 0, 0);
diff -Naur orig/arch/um/drivers/mconsole_user.c linux-2.4.24/arch/um/drivers/mconsole_user.c
--- orig/arch/um/drivers/mconsole_user.c	2004-03-27 02:00:28.000000000 -0700
+++ linux-2.4.24/arch/um/drivers/mconsole_user.c	2004-03-27 02:11:09.000000000 -0700
@@ -28,6 +28,7 @@
 	{ "cad", mconsole_cad, MCONSOLE_INTR },
 	{ "stop", mconsole_stop, MCONSOLE_PROC },
 	{ "go", mconsole_go, MCONSOLE_INTR },
+	{ "status", mconsole_status, MCONSOLE_PROC },
 	{ "log", mconsole_log, MCONSOLE_INTR },
 	{ "proc", mconsole_proc, MCONSOLE_PROC },
 };
diff -Naur orig/arch/um/include/mconsole.h linux-2.4.24/arch/um/include/mconsole.h
--- orig/arch/um/include/mconsole.h	2004-03-27 02:00:28.000000000 -0700
+++ linux-2.4.24/arch/um/include/mconsole.h	2004-03-27 02:11:30.000000000 -0700
@@ -79,6 +79,7 @@
 extern void mconsole_cad(struct mc_request *req);
 extern void mconsole_stop(struct mc_request *req);
 extern void mconsole_go(struct mc_request *req);
+extern void mconsole_status(struct mc_request *req);
 extern void mconsole_log(struct mc_request *req);
 extern void mconsole_proc(struct mc_request *req);
 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

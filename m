Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2FJN-0005SI-FN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Dec 2007 16:18:53 -0800
Received: from an-out-0708.google.com ([209.85.132.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J2FJM-0007NF-3h
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Dec 2007 16:18:53 -0800
Received: by an-out-0708.google.com with SMTP id b38so6392ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 11 Dec 2007 16:18:51 -0800 (PST)
Message-ID: <ea9232d10712111618i652ed952s6c6545bec24e05e6@mail.gmail.com>
Date: Wed, 12 Dec 2007 01:18:51 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: Fix unintentional resumes in mconsole stop
	code.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch takes care of a problem with the stopping code.

The function inside the while condition returns 0 to signify a problem.
A problem could be for example a bad command or a bad version of the
mconsole client.
A bad command would terminate the stopping loop and resume the kernel.
This is a problem.

A better solution is to make the loop infinite and don't leave it
until we are explicitly told to.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
diff -rupN linux-2.6.24-rc4.orig/arch/um/drivers/mconsole_kern.c
linux-2.6.24-rc4/arch/um/drivers/mconsole_kern.c
--- linux-2.6.24-rc4.orig/arch/um/drivers/mconsole_kern.c	2007-12-12
00:58:17.000000000 +0100
+++ linux-2.6.24-rc4/arch/um/drivers/mconsole_kern.c	2007-12-12
01:00:33.000000000 +0100
@@ -305,7 +305,9 @@ void mconsole_stop(struct mc_request *re
 	deactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	os_set_fd_block(req->originating_fd, 1);
 	mconsole_reply(req, "stopped", 0, 0);
-	while (mconsole_get_request(req->originating_fd, req)) {
+	for (;;) {
+		if (!mconsole_get_request(req->originating_fd, req))
+			continue;
 		if (req->cmd->handler == mconsole_go)
 			break;
 		if (req->cmd->handler == mconsole_stop) {

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

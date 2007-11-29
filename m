Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ixlf1-0005ZX-NN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 07:50:43 -0800
Received: from nz-out-0506.google.com ([64.233.162.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ixlf0-0002oc-Eh
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 07:50:43 -0800
Received: by nz-out-0506.google.com with SMTP id f1so5681639nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Nov 2007 07:50:42 -0800 (PST)
Message-ID: <ea9232d10711290750u5368e696qeb6c41a6da64637a@mail.gmail.com>
Date: Thu, 29 Nov 2007 16:50:41 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: Remove an unused variable from mconsole_stack
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

This patch removes one more unused variable from the uml code.
This time the variable is removed from mconsole_stack.

I tested this together with my mconsole stopping patch, so it should
work just fine.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>

---
diff -rupN orig/arch/um/drivers/mconsole_kern.c
linux-2.6.24-rc3-mm2/arch/um/drivers/mconsole_kern.c
--- orig/arch/um/drivers/mconsole_kern.c	2007-11-29 12:56:06.000000000 +0100
+++ linux-2.6.24-rc3-mm2/arch/um/drivers/mconsole_kern.c	2007-11-29
16:35:39.000000000 +0100
@@ -741,7 +753,6 @@ void mconsole_stack(struct mc_request *r
 {
 	char *ptr = req->request.data;
 	int pid_requested= -1;
-	struct task_struct *from = NULL;
 	struct task_struct *to = NULL;

 	/*
@@ -763,8 +774,6 @@ void mconsole_stack(struct mc_request *r
 		return;
 	}

-	from = current;
-
 	to = find_task_by_pid(pid_requested);
 	if ((to == NULL) || (pid_requested == 0)) {
 		mconsole_reply(req, "Couldn't find that pid", 1, 0);

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuFjV-0006M0-G0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:45 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuFjU-0005Ok-Sh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:45 -0800
Message-Id: <200601042152.k04Lq6ud009257@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/9] UML - Fix whitespace in mconsole driver
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
Date: Wed, 04 Jan 2006 16:52:06 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix up some bogus spacing in the mconsole driver.  Also delete the
emacs formatting comment at the end.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-04 14:53:02.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-04 14:55:31.000000000 -0500
@@ -422,7 +422,7 @@ void mconsole_remove(struct mc_request *
 {
 	struct mc_device *dev;
 	char *ptr = req->request.data, *err_msg = "";
-        char error[256];
+	char error[256];
 	int err, start, end, n;
 
 	ptr += strlen("remove");
@@ -433,33 +433,33 @@ void mconsole_remove(struct mc_request *
 		return;
 	}
 
-        ptr = &ptr[strlen(dev->name)];
+	ptr = &ptr[strlen(dev->name)];
 
-        err = 1;
-        n = (*dev->id)(&ptr, &start, &end);
-        if(n < 0){
-                err_msg = "Couldn't parse device number";
-                goto out;
-        }
-        else if((n < start) || (n > end)){
-                sprintf(error, "Invalid device number - must be between "
-                        "%d and %d", start, end);
-                err_msg = error;
-                goto out;
-        }
+	err = 1;
+	n = (*dev->id)(&ptr, &start, &end);
+	if(n < 0){
+		err_msg = "Couldn't parse device number";
+		goto out;
+	}
+	else if((n < start) || (n > end)){
+		sprintf(error, "Invalid device number - must be between "
+			"%d and %d", start, end);
+		err_msg = error;
+		goto out;
+	}
 
 	err = (*dev->remove)(n);
-        switch(err){
-        case -ENODEV:
-                err_msg = "Device doesn't exist";
-                break;
-        case -EBUSY:
-                err_msg = "Device is currently open";
-                break;
-        default:
-                break;
-        }
- out:
+	switch(err){
+	case -ENODEV:
+		err_msg = "Device doesn't exist";
+		break;
+	case -EBUSY:
+		err_msg = "Device is currently open";
+		break;
+	default:
+		break;
+	}
+out:
 	mconsole_reply(req, err_msg, err, 0);
 }
 
@@ -576,34 +576,33 @@ static void stack_proc(void *arg)
  */
 void do_stack(struct mc_request *req)
 {
-        char *ptr = req->request.data;
-        int pid_requested= -1;
+	char *ptr = req->request.data;
+	int pid_requested= -1;
 	struct task_struct *from = NULL;
 	struct task_struct *to = NULL;
 
-        /* Would be nice:
-         * 1) Send showregs output to mconsole.
+	/* Would be nice:
+	 * 1) Send showregs output to mconsole.
 	 * 2) Add a way to stack dump all pids.
 	 */
 
-        ptr += strlen("stack");
-        while(isspace(*ptr)) ptr++;
+	ptr += strlen("stack");
+	while(isspace(*ptr)) ptr++;
 
-        /* Should really check for multiple pids or reject bad args here */
-        /* What do the arguments in mconsole_reply mean? */
-        if(sscanf(ptr, "%d", &pid_requested) == 0){
-                mconsole_reply(req, "Please specify a pid", 1, 0);
-                return;
-        }
+	/* Should really check for multiple pids or reject bad args here */
+	/* What do the arguments in mconsole_reply mean? */
+	if(sscanf(ptr, "%d", &pid_requested) == 0){
+		mconsole_reply(req, "Please specify a pid", 1, 0);
+		return;
+	}
 
 	from = current;
 
 	to = find_task_by_pid(pid_requested);
-        if((to == NULL) || (pid_requested == 0)) {
-                mconsole_reply(req, "Couldn't find that pid", 1, 0);
-                return;
-        }
-
+	if((to == NULL) || (pid_requested == 0)) {
+		mconsole_reply(req, "Couldn't find that pid", 1, 0);
+		return;
+	}
 	with_console(req, stack_proc, to);
 }
 
@@ -772,14 +771,3 @@ char *mconsole_notify_socket(void)
 }
 
 EXPORT_SYMBOL(mconsole_notify_socket);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

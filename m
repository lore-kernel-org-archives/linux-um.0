Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuFjQ-0006LW-Tl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:40 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuFjQ-0005NA-Km
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:41 -0800
Message-Id: <200601042152.k04Lq0nc009242@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/9] UML - add mconsole_reply variant with length
	param
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
Date: Wed, 04 Jan 2006 16:52:00 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is needed for the console output patch, since we have a
possibly non-NULL-terminated string there.  So, the new interface
takes a string and a length, and the old interface calls strlen on
its string and calls the new interface with the length.

There's also a bit of whitespace cleanup.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_user.c	2005-11-30 12:48:57.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_user.c	2005-12-28 23:22:37.000000000 -0500
@@ -122,12 +122,12 @@ int mconsole_get_request(int fd, struct 
 	return(1);
 }
 
-int mconsole_reply(struct mc_request *req, char *str, int err, int more)
+int mconsole_reply_len(struct mc_request *req, const char *str, int total,
+		       int err, int more)
 {
 	struct mconsole_reply reply;
-	int total, len, n;
+	int len, n;
 
-	total = strlen(str);
 	do {
 		reply.err = err;
 
@@ -155,6 +155,12 @@ int mconsole_reply(struct mc_request *re
 	return(0);
 }
 
+int mconsole_reply(struct mc_request *req, const char *str, int err, int more)
+{
+	return mconsole_reply_len(req, str, strlen(str), err, more);
+}
+
+
 int mconsole_unlink_socket(void)
 {
 	unlink(mconsole_socket_name);
Index: linux-2.6.15/arch/um/include/mconsole.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/mconsole.h	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/include/mconsole.h	2005-12-29 11:52:19.000000000 -0500
@@ -32,7 +32,7 @@ struct mconsole_reply {
 
 struct mconsole_notify {
 	u32 magic;
-	u32 version;	
+	u32 version;
 	enum { MCONSOLE_SOCKET, MCONSOLE_PANIC, MCONSOLE_HANG,
 	       MCONSOLE_USER_NOTIFY } type;
 	u32 len;
@@ -66,7 +66,9 @@ struct mc_request
 extern char mconsole_socket_name[];
 
 extern int mconsole_unlink_socket(void);
-extern int mconsole_reply(struct mc_request *req, char *reply, int err,
+extern int mconsole_reply_len(struct mc_request *req, const char *reply,
+			      int len, int err, int more);
+extern int mconsole_reply(struct mc_request *req, const char *str, int err,
 			  int more);
 
 extern void mconsole_version(struct mc_request *req);
@@ -84,7 +86,7 @@ extern void mconsole_proc(struct mc_requ
 extern void mconsole_stack(struct mc_request *req);
 
 extern int mconsole_get_request(int fd, struct mc_request *req);
-extern int mconsole_notify(char *sock_name, int type, const void *data, 
+extern int mconsole_notify(char *sock_name, int type, const void *data,
 			   int len);
 extern char *mconsole_notify_socket(void);
 extern void lock_notify(void);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

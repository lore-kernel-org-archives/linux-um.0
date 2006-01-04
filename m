Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Etvq5-000470-T3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:13 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Etvq5-0001GN-6Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:14 -0800
Message-Id: <200601040037.k040bSjg012523@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/12] UML - use kstrdup
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
Date: Tue, 03 Jan 2006 19:37:27 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

There were a bunch of calls to uml_strdup dating from before kstrdup
was introduced.  This changes those calls.  It doesn't eliminate the
definition since there is still a couple of calls in userspace code (which
should probably call the libc strdup).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2005-12-19 21:20:32.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2005-12-19 21:24:25.000000000 -0500
@@ -562,10 +562,11 @@ int line_setup(struct line *lines, unsig
 
 int line_config(struct line *lines, unsigned int num, char *str)
 {
-	char *new = uml_strdup(str);
+	char *new;
 
+	new = kstrdup(str, GFP_KERNEL);
 	if(new == NULL){
-		printk("line_config - uml_strdup failed\n");
+		printk("line_config - kstrdup failed\n");
 		return -ENOMEM;
 	}
 	return !line_setup(lines, num, new, 0);
@@ -677,10 +678,9 @@ void lines_init(struct line *lines, int 
 		INIT_LIST_HEAD(&line->chan_list);
 		spin_lock_init(&line->lock);
 		if(line->init_str != NULL){
-			line->init_str = uml_strdup(line->init_str);
+			line->init_str = kstrdup(line->init_str, GFP_KERNEL);
 			if(line->init_str == NULL)
-				printk("lines_init - uml_strdup returned "
-				       "NULL\n");
+				printk("lines_init - kstrdup returned NULL\n");
 		}
 	}
 }
Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2005-12-19 21:20:28.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2005-12-19 21:21:29.000000000 -0500
@@ -563,7 +563,7 @@ int mconsole_init(void)
 	}
 
 	if(notify_socket != NULL){
-		notify_socket = uml_strdup(notify_socket);
+		notify_socket = kstrdup(notify_socket, GFP_KERNEL);
 		if(notify_socket != NULL)
 			mconsole_notify(notify_socket, MCONSOLE_SOCKET,
 					mconsole_socket_name, 
Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2005-12-19 21:20:28.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2005-12-19 21:21:47.000000000 -0500
@@ -586,7 +586,7 @@ static int net_config(char *str)
 	err = eth_parse(str, &n, &str);
 	if(err) return(err);
 
-	str = uml_strdup(str);
+	str = kstrdup(str, GFP_KERNEL);
 	if(str == NULL){
 		printk(KERN_ERR "net_config failed to strdup string\n");
 		return(-1);
Index: linux-2.6.15/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ubd_kern.c	2005-12-19 21:20:32.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ubd_kern.c	2005-12-19 21:22:00.000000000 -0500
@@ -706,7 +706,7 @@ static int ubd_config(char *str)
 {
 	int n, err;
 
-	str = uml_strdup(str);
+	str = kstrdup(str, GFP_KERNEL);
 	if(str == NULL){
 		printk(KERN_ERR "ubd_config failed to strdup string\n");
 		return(1);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtvqC-00047j-Tp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:20 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EtvqC-0001Q5-JS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:21 -0800
Message-Id: <200601040037.k040bgcf012560@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/12] UML - line_setup interface change
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
Date: Tue, 03 Jan 2006 19:37:42 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

line_setup is changed to return the device which it set up, rather
than just success or failure.  This will be important in the
line-config patch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:32:25.000000000 -0500
@@ -555,12 +555,13 @@ int line_setup(struct line *lines, unsig
 			}
 		}
 	}
-	return 1;
+	return n == -1 ? num : n;
 }
 
 int line_config(struct line *lines, unsigned int num, char *str)
 {
 	char *new;
+	int n;
 
 	if(*str == '='){
 		printk("line_config - can't configure all devices from "
@@ -573,7 +574,8 @@ int line_config(struct line *lines, unsi
 		printk("line_config - kstrdup failed\n");
 		return -ENOMEM;
 	}
-	return !line_setup(lines, num, new);
+	n = line_setup(lines, num, new);
+	return n < 0 ? n : 0;
 }
 
 int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
@@ -624,10 +626,14 @@ int line_id(char **str, int *start_out, 
 
 int line_remove(struct line *lines, unsigned int num, int n)
 {
+	int err;
 	char config[sizeof("conxxxx=none\0")];
 
 	sprintf(config, "%d=none", n);
-	return !line_setup(lines, num, config);
+	err = line_setup(lines, num, config);
+	if(err >= 0)
+		err = 0;
+	return err;
 }
 
 struct tty_driver *line_register_devfs(struct lines *set,



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

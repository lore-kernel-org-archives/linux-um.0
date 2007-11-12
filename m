Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IrhGv-0007gh-Bn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 13:56:49 -0800
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IrhGu-0003DM-DI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 13:56:44 -0800
Received: by wa-out-1112.google.com with SMTP id k22so2002448waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Nov 2007 13:56:43 -0800 (PST)
Message-ID: <ea9232d10711121356v5e6076dcs7d94b2ecab0add5c@mail.gmail.com>
Date: Mon, 12 Nov 2007 22:56:43 +0100
From: Magotari <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Remove an unused variable.
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
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

This patch gets rid of an unused variable in a few functions.
Compile and run tested.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
diff -rupN linux-2.6.24-rc2.orig/arch/um/drivers/chan_kern.c
linux-2.6.24-rc2/arch/um/drivers/chan_kern.c
--- linux-2.6.24-rc2.orig/arch/um/drivers/chan_kern.c	2007-11-06
22:57:46.000000000 +0100
+++ linux-2.6.24-rc2/arch/um/drivers/chan_kern.c	2007-11-12
22:15:51.000000000 +0100
@@ -383,8 +382,7 @@ static void free_chan(struct list_head *
 	}
 }

-static int one_chan_config_string(struct chan *chan, char *str, int size,
-				  char **error_out)
+static int one_chan_config_string(struct chan *chan, char *str, int size)
 {
 	int n = 0;

@@ -407,11 +405,11 @@ static int one_chan_config_string(struct
 }

 static int chan_pair_config_string(struct chan *in, struct chan *out,
-				   char *str, int size, char **error_out)
+				   char *str, int size)
 {
 	int n;

-	n = one_chan_config_string(in, str, size, error_out);
+	n = one_chan_config_string(in, str, size);
 	str += n;
 	size -= n;

@@ -421,7 +419,7 @@ static int chan_pair_config_string(struc
 	}

 	CONFIG_CHUNK(str, size, n, ",", 1);
-	n = one_chan_config_string(out, str, size, error_out);
+	n = one_chan_config_string(out, str, size);
 	str += n;
 	size -= n;
 	CONFIG_CHUNK(str, size, n, "", 1);
@@ -429,8 +427,7 @@ static int chan_pair_config_string(struc
 	return n;
 }

-int chan_config_string(struct list_head *chans, char *str, int size,
-		       char **error_out)
+int chan_config_string(struct list_head *chans, char *str, int size)
 {
 	struct list_head *ele;
 	struct chan *chan, *in = NULL, *out = NULL;
@@ -445,7 +442,7 @@ int chan_config_string(struct list_head
 			out = chan;
 	}

-	return chan_pair_config_string(in, out, str, size, error_out);
+	return chan_pair_config_string(in, out, str, size);
 }

 struct chan_type {
diff -rupN linux-2.6.24-rc2.orig/arch/um/drivers/line.c
linux-2.6.24-rc2/arch/um/drivers/line.c
--- linux-2.6.24-rc2.orig/arch/um/drivers/line.c	2007-11-06
22:57:46.000000000 +0100
+++ linux-2.6.24-rc2/arch/um/drivers/line.c	2007-11-12 22:42:35.000000000 +0100
@@ -642,7 +642,8 @@ int line_get_config(char *name, struct l
 		CONFIG_CHUNK(str, size, n, "none", 1);
 	else if (line->tty == NULL)
 		CONFIG_CHUNK(str, size, n, line->init_str, 1);
-	else n = chan_config_string(&line->chan_list, str, size, error_out);
+	else
+		n = chan_config_string(&line->chan_list, str, size);
 	spin_unlock(&line->count_lock);

 	return n;
diff -rupN linux-2.6.24-rc2.orig/arch/um/include/chan_kern.h
linux-2.6.24-rc2/arch/um/include/chan_kern.h
--- linux-2.6.24-rc2.orig/arch/um/include/chan_kern.h	2007-11-06
22:57:46.000000000 +0100
+++ linux-2.6.24-rc2/arch/um/include/chan_kern.h	2007-11-12
22:17:15.000000000 +0100
@@ -46,7 +46,6 @@ extern int chan_window_size(struct list_
 			     unsigned short *rows_out,
 			     unsigned short *cols_out);
 extern int chan_out_fd(struct list_head *chans);
-extern int chan_config_string(struct list_head *chans, char *str, int size,
-			      char **error_out);
+extern int chan_config_string(struct list_head *chans, char *str, int size);

 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

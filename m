Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Etvq6-000473-Sv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:14 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Etvq5-0001GR-Gq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:15 -0800
Message-Id: <200601040037.k040bUod012529@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/12] UML - non-void functions should return
	something
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
Date: Tue, 03 Jan 2006 19:37:30 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

There are a few functions which are declared to return something,
but don't.  These are actually infinite loops which are forced to be
declared as non-void.  This makes them all return 0.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ubd_kern.c	2005-12-20 00:24:55.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ubd_kern.c	2005-12-20 00:34:45.000000000 -0500
@@ -1387,15 +1387,6 @@ int io_thread(void *arg)
 			printk("io_thread - write failed, fd = %d, err = %d\n",
 			       kernel_fd, -n);
 	}
-}
 
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
+	return 0;
+}
Index: linux-2.6.15/arch/um/kernel/sigio_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/sigio_user.c	2005-12-20 00:24:54.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/sigio_user.c	2005-12-20 00:33:38.000000000 -0500
@@ -216,6 +216,8 @@ static int write_sigio_thread(void *unus
 				       "err = %d\n", -n);
 		}
 	}
+
+	return 0;
 }
 
 static int need_poll(int n)
Index: linux-2.6.15/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/aio.c	2005-12-19 21:34:12.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/aio.c	2005-12-20 00:34:25.000000000 -0500
@@ -210,6 +210,8 @@ static int not_aio_thread(void *arg)
                         printk("not_aio_thread - write failed, fd = %d, "
                                "err = %d\n", aio_req_fd_r, -err);
         }
+
+	return 0;
 }
 
 static int aio_pid = -1;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

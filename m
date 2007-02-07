Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEssc-0003s8-Na for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEssZ-0002zI-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:58 -0800
Message-Id: <200702071947.l17JlqLf006630@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 07 Feb 2007 14:47:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/7] UML - AIO locking and tidying
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Comment the lack of locking of data that's set up once at boot time.

Also fixed a couple of bogus printks.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/os-Linux/aio.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6.18-mm/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/aio.c	2007-01-09 17:08:52.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/aio.c	2007-01-09 17:10:54.000000000 -0500
@@ -24,9 +24,6 @@ struct aio_thread_req {
 	struct aio_context *aio;
 };
 
-static int aio_req_fd_r = -1;
-static int aio_req_fd_w = -1;
-
 #if defined(HAVE_AIO_ABI)
 #include <linux/aio_abi.h>
 
@@ -111,6 +108,7 @@ static int do_aio(aio_context_t ctx, enu
 	return err;
 }
 
+/* Initialized in an initcall and unchanged thereafter */
 static aio_context_t ctx = 0;
 
 static int aio_thread(void *arg)
@@ -137,7 +135,7 @@ static int aio_thread(void *arg)
 			err = os_write_file(reply_fd, &reply, sizeof(reply));
 			if(err != sizeof(reply))
 				printk("aio_thread - write failed, fd = %d, "
-				       "err = %d\n", aio_req_fd_r, -err);
+				       "err = %d\n", reply_fd, -err);
 		}
 	}
 	return 0;
@@ -182,6 +180,11 @@ out:
 	return err;
 }
 
+/* These are initialized in initcalls and not changed */
+static int aio_req_fd_r = -1;
+static int aio_req_fd_w = -1;
+static int aio_pid = -1;
+
 static int not_aio_thread(void *arg)
 {
 	struct aio_thread_req req;
@@ -208,14 +211,12 @@ static int not_aio_thread(void *arg)
 		err = os_write_file(req.aio->reply_fd, &reply, sizeof(reply));
 		if(err != sizeof(reply))
 			printk("not_aio_thread - write failed, fd = %d, "
-			       "err = %d\n", aio_req_fd_r, -err);
+			       "err = %d\n", req.aio->reply_fd, -err);
 	}
 
 	return 0;
 }
 
-static int aio_pid = -1;
-
 static int init_aio_24(void)
 {
 	unsigned long stack;
@@ -308,6 +309,7 @@ static int submit_aio_26(enum aio_type t
 }
 #endif
 
+/* Initialized in an initcall and unchanged thereafter */
 static int aio_24 = DEFAULT_24_AIO;
 
 static int __init set_aio_24(char *name, int *add)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

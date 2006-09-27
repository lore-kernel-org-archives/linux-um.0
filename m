Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSdgT-0001HL-Am for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 10:59:01 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GSdgR-0004LD-Ig
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 10:59:01 -0700
Message-Id: <200609271757.k8RHvsX1005737@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 27 Sep 2006 13:57:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/5] UML - Locking documentation
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

Some locking documentation and a cleanup.  uml_exitcode is copied
into a local before sprintf sees it, in case sprintf does anything
non-atomic with it.

The rest are comments about why certain globals don't need any kind
of locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/null.c           |    1 +
 arch/um/drivers/random.c         |    4 ++++
 arch/um/drivers/stderr_console.c |    2 ++
 arch/um/drivers/stdio_console.c  |    1 +
 arch/um/kernel/exitcode.c        |    8 ++++++--
 5 files changed, 14 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/exitcode.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/exitcode.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/exitcode.c	2006-09-26 16:29:14.000000000 -0400
@@ -16,9 +16,13 @@ int uml_exitcode = 0;
 static int read_proc_exitcode(char *page, char **start, off_t off,
 			      int count, int *eof, void *data)
 {
-	int len;
+	int len, val;
 
-	len = sprintf(page, "%d\n", uml_exitcode);
+	/* Save uml_exitcode in a local so that we don't need to guarantee
+	 * that sprintf accesses it atomically.
+	 */
+	val = uml_exitcode;
+	len = sprintf(page, "%d\n", val);
 	len -= off;
 	if(len <= off+count) *eof = 1;
 	*start = page + off;
Index: linux-2.6.18-mm/arch/um/drivers/null.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/null.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/null.c	2006-09-26 16:29:39.000000000 -0400
@@ -8,6 +8,7 @@
 #include "chan_user.h"
 #include "os.h"
 
+/* This address is used only as a unique identifer */
 static int null_chan;
 
 static void *null_init(char *str, int device, const struct chan_opts *opts)
Index: linux-2.6.18-mm/arch/um/drivers/random.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/random.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/random.c	2006-09-26 16:29:39.000000000 -0400
@@ -20,6 +20,10 @@
 
 #define RNG_MISCDEV_MINOR		183 /* official */
 
+/* Changed at init time, in the non-modular case, and at module load
+ * time, in the module case.  Presumably, the module subsystem
+ * protects against a module being loaded twice at the same time.
+ */
 static int random_fd = -1;
 
 static int rng_dev_open (struct inode *inode, struct file *filp)
Index: linux-2.6.18-mm/arch/um/drivers/stderr_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stderr_console.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/stderr_console.c	2006-09-26 16:29:39.000000000 -0400
@@ -9,6 +9,8 @@
 /*
  * Don't register by default -- as this registeres very early in the
  * boot process it becomes the default console.
+ *
+ * Initialized at init time.
  */
 static int use_stderr_console = 0;
 
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2006-09-26 16:29:39.000000000 -0400
@@ -107,6 +107,7 @@ static int con_open(struct tty_struct *t
 	return line_open(vts, tty);
 }
 
+/* Set in an initcall, checked in an exitcall */
 static int con_init_done = 0;
 
 static const struct tty_operations console_ops = {


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

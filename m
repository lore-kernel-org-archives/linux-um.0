Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEssW-0003rw-J9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:52 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HEssT-000643-3k
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:54:52 -0800
Message-Id: <200702071947.l17JlgoC006600@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 07 Feb 2007 14:47:42 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/7] UML - IRQ handler tidying
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

Tidying the irq code -
	make a variable static
	activate_fd can call kmalloc directly since it's now kernel code
	added a no-locking comment
	fixed a style violation

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/irq.c   |    7 +++----
 arch/um/os-Linux/irq.c |    6 +++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/irq.c	2007-01-09 17:08:58.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/irq.c	2007-01-10 15:30:35.000000000 -0500
@@ -79,7 +79,7 @@ skip:
 	return 0;
 }
 
-struct irq_fd *active_fds = NULL;
+static struct irq_fd *active_fds = NULL;
 static struct irq_fd **last_irq_ptr = &active_fds;
 
 extern void free_irqs(void);
@@ -124,8 +124,8 @@ int activate_fd(int irq, int fd, int typ
 	if (err < 0)
 		goto out;
 
-	new_fd = um_kmalloc(sizeof(*new_fd));
 	err = -ENOMEM;
+	new_fd = kmalloc(sizeof(struct irq_fd), GFP_KERNEL);
 	if (new_fd == NULL)
 		goto out;
 
@@ -176,9 +176,8 @@ int activate_fd(int irq, int fd, int typ
 		 */
 		spin_unlock_irqrestore(&irq_lock, flags);
 		kfree(tmp_pfd);
-		tmp_pfd = NULL;
 
-		tmp_pfd = um_kmalloc(n);
+		tmp_pfd = kmalloc(n, GFP_KERNEL);
 		if (tmp_pfd == NULL)
 			goto out_kfree;
 
Index: linux-2.6.18-mm/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/irq.c	2007-01-10 15:08:33.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/irq.c	2007-01-10 15:34:43.000000000 -0500
@@ -20,6 +20,10 @@
 #include "os.h"
 #include "um_malloc.h"
 
+/*
+ * Locked by irq_lock in arch/um/kernel/irq.c.  Changed by os_create_pollfd
+ * and os_free_irq_by_cb, which are called under irq_lock.
+ */
 static struct pollfd *pollfds = NULL;
 static int pollfds_num = 0;
 static int pollfds_size = 0;
@@ -58,7 +62,7 @@ int os_create_pollfd(int fd, int events,
 	if (pollfds_num == pollfds_size) {
 		if (size_tmpfds <= pollfds_size * sizeof(pollfds[0])) {
 			/* return min size needed for new pollfds area */
-			return((pollfds_size + 1) * sizeof(pollfds[0]));
+			return (pollfds_size + 1) * sizeof(pollfds[0]);
 		}
 
 		if (pollfds != NULL) {


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU1-00018B-RD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU0-00014q-Ox
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Date: Thu, 17 Jan 2008 16:40:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214050.GA6782@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 19/20] UML - port mutex conversion
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
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Daniel Walker <dwalker@mvista.com>

The port_sem is already used as a mutex since it's using DECLARE_MUTEX(),
but the underlying construct is still a semaphore .. This patch switches
it over to a struct mutex.

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/port_kern.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.22/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/port_kern.c	2008-01-17 13:44:46.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/port_kern.c	2008-01-17 13:47:39.000000000 -0500
@@ -6,6 +6,7 @@
 #include "linux/completion.h"
 #include "linux/interrupt.h"
 #include "linux/list.h"
+#include "linux/mutex.h"
 #include "asm/atomic.h"
 #include "init.h"
 #include "irq_kern.h"
@@ -120,7 +121,7 @@ static int port_accept(struct port_list 
 	return 0;
 }
 
-static DECLARE_MUTEX(ports_sem);
+static DEFINE_MUTEX(ports_mutex);
 static LIST_HEAD(ports);
 
 static void port_work_proc(struct work_struct *unused)
@@ -161,7 +162,7 @@ void *port_data(int port_num)
 	struct port_dev *dev = NULL;
 	int fd;
 
-	down(&ports_sem);
+	mutex_lock(&ports_mutex);
 	list_for_each(ele, &ports) {
 		port = list_entry(ele, struct port_list, list);
 		if (port->port == port_num)
@@ -216,7 +217,7 @@ void *port_data(int port_num)
  out_free:
 	kfree(port);
  out:
-	up(&ports_sem);
+	mutex_unlock(&ports_mutex);
 	return dev;
 }
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

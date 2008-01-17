Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU1-00017u-DE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU0-00014r-Op
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Date: Thu, 17 Jan 2008 16:40:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214049.GA6777@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 18/20] UML - mconsole mutex conversion
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

The plug_mem_mutex is already used as a mutex since it's using DECLARE_MUTEX(),
but the underlying construct is still a semaphore .. This patch switches
it over to a struct mutex.

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/mconsole_kern.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6-git/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6-git.orig/arch/um/drivers/mconsole_kern.c	2008-01-17 14:35:43.000000000 -0500
+++ linux-2.6-git/arch/um/drivers/mconsole_kern.c	2008-01-17 14:37:29.000000000 -0500
@@ -17,6 +17,7 @@
 #include "linux/syscalls.h"
 #include "linux/utsname.h"
 #include "linux/workqueue.h"
+#include "linux/mutex.h"
 #include "asm/uaccess.h"
 #include "init.h"
 #include "irq_kern.h"
@@ -360,7 +361,7 @@ struct unplugged_pages {
 	void *pages[UNPLUGGED_PER_PAGE];
 };
 
-static DECLARE_MUTEX(plug_mem_mutex);
+static DEFINE_MUTEX(plug_mem_mutex);
 static unsigned long long unplugged_pages_count = 0;
 static LIST_HEAD(unplugged_pages);
 static int unplug_index = UNPLUGGED_PER_PAGE;
@@ -396,7 +397,7 @@ static int mem_config(char *str, char **
 
 	diff /= PAGE_SIZE;
 
-	down(&plug_mem_mutex);
+	mutex_lock(&plug_mem_mutex);
 	for (i = 0; i < diff; i++) {
 		struct unplugged_pages *unplugged;
 		void *addr;
@@ -453,7 +454,7 @@ static int mem_config(char *str, char **
 
 	err = 0;
 out_unlock:
-	up(&plug_mem_mutex);
+	mutex_unlock(&plug_mem_mutex);
 out:
 	return err;
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

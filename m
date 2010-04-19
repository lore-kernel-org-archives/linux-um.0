Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lczerner@redhat.com>) id 1O3vMz-0002oI-Cw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 18:06:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O3vMy-0007pE-Hn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 18:06:53 +0000
From: Lukas Czerner <lczerner@redhat.com>
Date: Mon, 19 Apr 2010 20:06:07 +0200
Message-Id: <1271700367-14127-1-git-send-email-lczerner@redhat.com>
Subject: [uml-devel] [PATCH] um: Fix compile errors for um architecture
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lukas Czerner <lczerner@redhat.com>, Jeff Dike <jdike@addtoit.com>

arch/um/drivers/line.c
 - need to include linux/slab.h since the code uses kmalloc.
 - fix warning message with unused variable tty

arch/um/os-Linux/helper.c
 - there is no need to include linux/slab.h since allocations are
 done with uml_kmalloc

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 arch/um/drivers/line.c    |    2 +-
 arch/um/os-Linux/helper.c |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 64cda95..7f7338c 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -6,6 +6,7 @@
 #include "linux/irqreturn.h"
 #include "linux/kd.h"
 #include "linux/sched.h"
+#include "linux/slab.h"
 #include "chan_kern.h"
 #include "irq_kern.h"
 #include "irq_user.h"
@@ -18,7 +19,6 @@ static irqreturn_t line_interrupt(int irq, void *data)
 {
 	struct chan *chan = data;
 	struct line *line = chan->line;
-	struct tty_struct *tty;
 
 	if (line)
 		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 06d6ccf..b6b1096 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -8,7 +8,6 @@
 #include <errno.h>
 #include <sched.h>
 #include <linux/limits.h>
-#include <linux/slab.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include "kern_constants.h"
-- 
1.6.6.1


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


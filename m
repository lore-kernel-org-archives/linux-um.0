Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tiger.yang@oracle.com>) id 1O2h47-0002yz-1I
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2010 08:38:19 +0000
Received: from rcsinet11.oracle.com ([148.87.113.123])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2h44-0007Vv-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2010 08:38:18 +0000
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by rcsinet11.oracle.com (Switch-3.4.2/Switch-3.4.2) with ESMTP id
	o3G8c9MZ012368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2010 08:38:11 GMT
Received: from acsmt355.oracle.com (acsmt355.oracle.com [141.146.40.155])
	by acsinet15.oracle.com (Switch-3.4.2/Switch-3.4.1) with ESMTP id
	o3FGwVHS030851 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2010 08:38:08 GMT
From: Tiger Yang <tiger.yang@oracle.com>
Date: Fri, 16 Apr 2010 16:35:39 +0800
Message-Id: <1271406939-26394-1-git-send-email-tiger.yang@oracle.com>
In-Reply-To: <>
References: <>
Subject: [uml-devel] [PATCH 1/1] uml: replace kmalloc() in line.c
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

This patch replace kmalloc() with uml_kmalloc() in line.c and
remove an unused variable.

Signed-off-by: Tiger Yang <tiger.yang@oracle.com>
---
 arch/um/drivers/line.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 64cda95..616a1f3 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -11,6 +11,7 @@
 #include "irq_user.h"
 #include "kern_util.h"
 #include "os.h"
+#include "um_malloc.h"
 
 #define LINE_BUFSIZE 4096
 
@@ -18,7 +19,6 @@ static irqreturn_t line_interrupt(int irq, void *data)
 {
 	struct chan *chan = data;
 	struct line *line = chan->line;
-	struct tty_struct *tty;
 
 	if (line)
 		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
@@ -95,7 +95,7 @@ static int buffer_data(struct line *line, const char *buf, int len)
 	int end, room;
 
 	if (line->buffer == NULL) {
-		line->buffer = kmalloc(LINE_BUFSIZE, GFP_ATOMIC);
+		line->buffer = uml_kmalloc(LINE_BUFSIZE, UM_GFP_ATOMIC);
 		if (line->buffer == NULL) {
 			printk(KERN_ERR "buffer_data - atomic allocation "
 			       "failed\n");
@@ -782,7 +782,7 @@ void register_winch_irq(int fd, int tty_fd, int pid, struct tty_struct *tty,
 {
 	struct winch *winch;
 
-	winch = kmalloc(sizeof(*winch), GFP_KERNEL);
+	winch = uml_kmalloc(sizeof(*winch), UM_GFP_KERNEL);
 	if (winch == NULL) {
 		printk(KERN_ERR "register_winch_irq - kmalloc failed\n");
 		goto cleanup;
@@ -861,7 +861,7 @@ char *add_xterm_umid(char *base)
 		return base;
 
 	len = strlen(base) + strlen(" ()") + strlen(umid) + 1;
-	title = kmalloc(len, GFP_KERNEL);
+	title = uml_kmalloc(len, UM_GFP_KERNEL);
 	if (title == NULL) {
 		printk(KERN_ERR "Failed to allocate buffer for xterm title\n");
 		return base;
-- 
1.5.4.3


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


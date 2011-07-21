Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QjpPE-00078I-Qd
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:56 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QjpPA-0002Hc-PS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:56 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Jul 2011 11:18:34 +0200
Message-Id: <1311239914-8301-10-git-send-email-richard@nod.at>
In-Reply-To: <1311239914-8301-1-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 10/10] um: Remove dead code
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

GCC 4.6's -Wunused-but-set-variable found some dead code.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/chan_kern.c |    3 +--
 arch/um/drivers/line.c      |    3 +--
 arch/um/kernel/reboot.c     |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 25e1965..d4191fe 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -543,11 +543,10 @@ int parse_chan_pair(char *str, struct line *line, int device,
 		    const struct chan_opts *opts, char **error_out)
 {
 	struct list_head *chans = &line->chan_list;
-	struct chan *new, *chan;
+	struct chan *new;
 	char *in, *out;
 
 	if (!list_empty(chans)) {
-		chan = list_entry(chans->next, struct chan, list);
 		free_chan(chans, 0);
 		INIT_LIST_HEAD(chans);
 	}
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 35dd0b8..d51c404 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -176,10 +176,9 @@ void line_flush_buffer(struct tty_struct *tty)
 {
 	struct line *line = tty->driver_data;
 	unsigned long flags;
-	int err;
 
 	spin_lock_irqsave(&line->lock, flags);
-	err = flush_buffer(line);
+	flush_buffer(line);
 	spin_unlock_irqrestore(&line->lock, flags);
 }
 
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 869bec9..4d93dff 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -20,9 +20,8 @@ static void kill_off_processes(void)
 		os_kill_ptraced_process(userspace_pid[0], 1);
 	else {
 		struct task_struct *p;
-		int pid, me;
+		int pid;
 
-		me = os_getpid();
 		for_each_process(p) {
 			if (p->mm == NULL)
 				continue;
-- 
1.7.6


------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


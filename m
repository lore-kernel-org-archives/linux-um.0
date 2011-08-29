Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qy4K7-00082Z-Pq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:31 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qy4K3-0005sv-QW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:31 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:03:58 +0200
Message-Id: <1314633842-24515-6-git-send-email-richard@nod.at>
In-Reply-To: <1314633842-24515-1-git-send-email-richard@nod.at>
References: <1314633842-24515-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 5/9] um: winch_interrupt() can happen inside of
	free_winch()
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>

From: Al Viro <viro@ftp.linux.org.uk>

... so set winch->fd to -1 before doing free_irq(), to avoid having
winch_interrupt() come from/during the latter and attempt to do
reactivate_fd() on something that's already gone.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/line.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index c5bff1d..91bf1894 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -725,6 +725,8 @@ struct winch {
 
 static void free_winch(struct winch *winch, int free_irq_ok)
 {
+	int fd = winch->fd;
+	winch->fd = -1;
 	if (free_irq_ok)
 		free_irq(WINCH_IRQ, winch);
 
@@ -732,8 +734,8 @@ static void free_winch(struct winch *winch, int free_irq_ok)
 
 	if (winch->pid != -1)
 		os_kill_process(winch->pid, 1);
-	if (winch->fd != -1)
-		os_close_file(winch->fd);
+	if (fd != -1)
+		os_close_file(fd);
 	if (winch->stack != 0)
 		free_stack(winch->stack, 0);
 	kfree(winch);
-- 
1.7.6.1


------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


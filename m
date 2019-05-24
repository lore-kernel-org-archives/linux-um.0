Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hUGOx-0006ah-PI
 for linux-um@lists.infradead.org; Fri, 24 May 2019 20:02:52 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] arch: um: don't garbage collect in deactivate_all_fds()
Date: Fri, 24 May 2019 22:02:44 +0200
Message-Id: <20190524200244.32546-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: j@w1.fi, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

My previous commit didn't actually address the whole issue with
lockdep shutdown, I had another local modification that disabled
lockdep but that wasn't sufficient alone, so had to do the other
change.

Another issue remained though - during kfree() we acquire locks
and lockdep tries to annotate those with exactly the same issue
in the other patch - we no longer have "current".

So, just remove the garbage collection. There's no value in it
anyway since we're going to shut down anyway and marking a slab
object as free is now not very useful anymore.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index d532377f5808..efde1f16c603 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -401,7 +401,7 @@ int deactivate_all_fds(void)
 		);
 		to_free = to_free->next;
 	}
-	garbage_collect_irq_entries();
+	/* don't garbage collect - we can no longer call kfree() here */
 	os_close_epoll_fd();
 	return 0;
 }
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


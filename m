Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKKEL-0007Bo-Hy
 for linux-um@lists.infradead.org; Mon, 21 Sep 2020 11:43:38 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: clean up stacktrace dump
Date: Mon, 21 Sep 2020 13:43:25 +0200
Message-Id: <20200921134325.f1571009ca6a.I25fc8d2d67f9d6677402b2753989ba74a700d9c5@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

We currently get a few stray newlines, due to the interaction
between printk() and the code here. Remove a few explicit
newline prints to neaten the output.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/sysrq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index acbc879d2773..7452f70d50d0 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -47,12 +47,10 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 		if (kstack_end(stack))
 			break;
 		if (i && ((i % STACKSLOTS_PER_LINE) == 0))
-			printk("%s\n", loglvl);
+			pr_cont("\n");
 		pr_cont(" %08lx", *stack++);
 	}
-	printk("%s\n", loglvl);
 
 	printk("%sCall Trace:\n", loglvl);
 	dump_trace(current, &stackops, (void *)loglvl);
-	printk("%s\n", loglvl);
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


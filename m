Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVrwM-005Ble-TG
	for linux-um@lists.infradead.org; Wed, 07 Sep 2022 10:05:52 +0000
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] um: Prevent KASAN splats in dump_stack()
Date: Wed, 7 Sep 2022 12:05:33 +0200
Message-ID: <20220907100533.1719128-1-vincent.whitchurch@axis.com>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: kernel@axis.com, Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Use READ_ONCE_NOCHECK() when reading the stack to prevent KASAN splats
when dump_stack() is used.

Fixes: 5b301409e8bc5d7fad ("UML: add support for KASAN under x86_64")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/kernel/sysrq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 7452f70d50d0..746715379f12 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -48,7 +48,8 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 			break;
 		if (i && ((i % STACKSLOTS_PER_LINE) == 0))
 			pr_cont("\n");
-		pr_cont(" %08lx", *stack++);
+		pr_cont(" %08lx", READ_ONCE_NOCHECK(*stack));
+		stack++;
 	}
 
 	printk("%sCall Trace:\n", loglvl);
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


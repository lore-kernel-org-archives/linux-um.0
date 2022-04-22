Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhs37-000KIO-On
 for linux-um@lists.infradead.org; Fri, 22 Apr 2022 12:06:10 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] um: x86: print RIP with symbol
Date: Fri, 22 Apr 2022 14:06:02 +0200
Message-Id: <20220422140602.26dfa3ae90d2.I741c6239fb1423fe4ce6eb00f5dcce360c01a700@changeid>
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

This is not only nicer to read by default, but also lets
decode_stacktrace.sh work on it, rather than removing it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: put back %lx I accidentally dropped looking at x86
---
 arch/x86/um/sysrq_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/sysrq_64.c b/arch/x86/um/sysrq_64.c
index 903ad91b624f..ac4ffe4a4396 100644
--- a/arch/x86/um/sysrq_64.c
+++ b/arch/x86/um/sysrq_64.c
@@ -19,7 +19,7 @@ void show_regs(struct pt_regs *regs)
 	print_modules();
 	printk(KERN_INFO "Pid: %d, comm: %.20s %s %s\n", task_pid_nr(current),
 		current->comm, print_tainted(), init_utsname()->release);
-	printk(KERN_INFO "RIP: %04lx:[<%016lx>]\n", PT_REGS_CS(regs) & 0xffff,
+	printk(KERN_INFO "RIP: %04lx:%pS\n", PT_REGS_CS(regs) & 0xffff,
 	       PT_REGS_IP(regs));
 	printk(KERN_INFO "RSP: %016lx  EFLAGS: %08lx\n", PT_REGS_SP(regs),
 	       PT_REGS_EFLAGS(regs));
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


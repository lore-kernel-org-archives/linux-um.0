Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuUIn-00GrNV-KV
	for linux-um@lists.infradead.org; Fri, 27 May 2022 07:22:31 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3] um: x86: print RIP with symbol
Date: Fri, 27 May 2022 09:22:16 +0200
Message-Id: <20220527092216.cc1f987d4240.I741c6239fb1423fe4ce6eb00f5dcce360c01a700@changeid>
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
 arch/x86/um/sysrq_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/sysrq_64.c b/arch/x86/um/sysrq_64.c
index 903ad91b624f..ef1eb4f4f612 100644
--- a/arch/x86/um/sysrq_64.c
+++ b/arch/x86/um/sysrq_64.c
@@ -19,8 +19,8 @@ void show_regs(struct pt_regs *regs)
 	print_modules();
 	printk(KERN_INFO "Pid: %d, comm: %.20s %s %s\n", task_pid_nr(current),
 		current->comm, print_tainted(), init_utsname()->release);
-	printk(KERN_INFO "RIP: %04lx:[<%016lx>]\n", PT_REGS_CS(regs) & 0xffff,
-	       PT_REGS_IP(regs));
+	printk(KERN_INFO "RIP: %04lx:%pS\n", PT_REGS_CS(regs) & 0xffff,
+	       (void *)PT_REGS_IP(regs));
 	printk(KERN_INFO "RSP: %016lx  EFLAGS: %08lx\n", PT_REGS_SP(regs),
 	       PT_REGS_EFLAGS(regs));
 	printk(KERN_INFO "RAX: %016lx RBX: %016lx RCX: %016lx\n",
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


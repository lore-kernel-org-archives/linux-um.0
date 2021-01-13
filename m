Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kznMu-0000dZ-Hw
 for linux-um@lists.infradead.org; Wed, 13 Jan 2021 21:07:53 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: print register names in wait_for_stub
Date: Wed, 13 Jan 2021 22:07:41 +0100
Message-Id: <20210113220741.dc68ed73f5fb.I09397ac1b5f358d940bd88bd662cb79ef8d070fa@changeid>
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

Since we're basically debugging the userspace (it runs in ptrace)
it's useful to dump out the registers - but they're not readable,
so if something goes wrong it's hard to say what. Print the names
of registers in the register dump so it's easier to look at.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/skas/process.c | 55 +++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 02c4741ade5e..d910e25c273e 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -28,6 +28,54 @@ int is_skas_winch(int pid, int fd, void *data)
 	return pid == getpgrp();
 }
 
+static const char *ptrace_reg_name(int idx)
+{
+#define R(n) case HOST_##n: return #n
+
+	switch (idx) {
+#ifdef __x86_64__
+	R(BX);
+	R(CX);
+	R(DI);
+	R(SI);
+	R(DX);
+	R(BP);
+	R(AX);
+	R(R8);
+	R(R9);
+	R(R10);
+	R(R11);
+	R(R12);
+	R(R13);
+	R(R14);
+	R(R15);
+	R(ORIG_AX);
+	R(CS);
+	R(SS);
+	R(EFLAGS);
+#elif defined(__i386__)
+	R(IP);
+	R(SP);
+	R(EFLAGS);
+	R(AX);
+	R(BX);
+	R(CX);
+	R(DX);
+	R(SI);
+	R(DI);
+	R(BP);
+	R(CS);
+	R(SS);
+	R(DS);
+	R(FS);
+	R(ES);
+	R(GS);
+	R(ORIG_AX);
+#endif
+	}
+	return "";
+}
+
 static int ptrace_dump_regs(int pid)
 {
 	unsigned long regs[MAX_REG_NR];
@@ -37,8 +85,11 @@ static int ptrace_dump_regs(int pid)
 		return -errno;
 
 	printk(UM_KERN_ERR "Stub registers -\n");
-	for (i = 0; i < ARRAY_SIZE(regs); i++)
-		printk(UM_KERN_ERR "\t%d - %lx\n", i, regs[i]);
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		const char *regname = ptrace_reg_name(i);
+
+		printk(UM_KERN_ERR "\t%s\t(%2d): %lx\n", regname, i, regs[i]);
+	}
 
 	return 0;
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


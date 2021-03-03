Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTx7-005VmG-M1
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:02:24 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 19/27] um: Move faultinfo extraction into userspace routine
Date: Wed,  3 Mar 2021 16:55:15 +0100
Message-Id: <20210303155523.124277-20-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>

The segv handler is called slightly differently depending on whether
PTRACE_FULL_FAULTINFO is set or not (32bit vs. 64bit). The only
difference is that we don't try to pass the registers and instruction
pointer to the segv handler.

It would be good to either document or remove the difference, but I do
not know why this difference exists.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 08ce1798ee96..660b23389016 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -170,12 +170,6 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux
 	}
 }
 
-static void handle_segv(int pid, struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
-{
-	get_skas_faultinfo(pid, &regs->faultinfo, aux_fp_regs);
-	segv(regs->faultinfo, 0, 1, NULL);
-}
-
 static void handle_trap(int pid, struct uml_pt_regs *regs)
 {
 	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
@@ -426,13 +420,15 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 
 			switch (sig) {
 			case SIGSEGV:
-				if (PTRACE_FULL_FAULTINFO) {
-					get_skas_faultinfo(pid,
-							   &regs->faultinfo, aux_fp_regs);
+				get_skas_faultinfo(pid,
+						   &regs->faultinfo, aux_fp_regs);
+
+				if (PTRACE_FULL_FAULTINFO)
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
 							     regs);
-				}
-				else handle_segv(pid, regs, aux_fp_regs);
+				else
+					segv(regs->faultinfo, 0, 1, NULL);
+
 				break;
 			case SIGTRAP + 0x80:
 				handle_trap(pid, regs);
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


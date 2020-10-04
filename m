Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOwCr-0006ZM-6h
 for linux-um@lists.infradead.org; Sun, 04 Oct 2020 05:05:10 +0000
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] um: Remove dead usage of TIF_IA32
Date: Sun,  4 Oct 2020 01:04:36 -0400
Message-Id: <20201004050436.1406738-1-krisman@collabora.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, kernel@collabora.com, linux-um@lists.infradead.org, oleg@redhat.com

This seems like a dead artifact since TIF_IA32 is not even defined as a
TI flag for UM.  Looking back in git history, it made sense in the old
days, but it is apparently not used since UM was split out of the x86
arch/.  It is also going away from the x86 tree soon.

Also, I think the variable clean up it performs is not needed as 64-bit
UML doesn't run 32-bit binaries as far as I can tell, and 32-bit UML
has 32-bit ulong.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/um/ptrace_64.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index 09a085bde0d4..1401899dee9b 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -52,14 +52,6 @@ static const int reg_offsets[] =
 
 int putreg(struct task_struct *child, int regno, unsigned long value)
 {
-#ifdef TIF_IA32
-	/*
-	 * Some code in the 64bit emulation may not be 64bit clean.
-	 * Don't take any chances.
-	 */
-	if (test_tsk_thread_flag(child, TIF_IA32))
-		value &= 0xffffffff;
-#endif
 	switch (regno) {
 	case R8:
 	case R9:
@@ -137,10 +129,7 @@ int poke_user(struct task_struct *child, long addr, long data)
 unsigned long getreg(struct task_struct *child, int regno)
 {
 	unsigned long mask = ~0UL;
-#ifdef TIF_IA32
-	if (test_tsk_thread_flag(child, TIF_IA32))
-		mask = 0xffffffff;
-#endif
+
 	switch (regno) {
 	case R8:
 	case R9:
-- 
2.28.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


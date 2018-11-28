Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd4a.google.com ([2607:f8b0:4864:20::d4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gS5f5-0003ZF-IF
 for linux-um@lists.infradead.org; Wed, 28 Nov 2018 19:38:17 +0000
Received: by mail-io1-xd4a.google.com with SMTP id s10so26246788iop.16
 for <linux-um@lists.infradead.org>; Wed, 28 Nov 2018 11:38:04 -0800 (PST)
Date: Wed, 28 Nov 2018 11:36:25 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
Subject: [RFC v3 08/19] arch: um: add shim to trap to allow installing a fault
 catcher for tests
From: Brendan Higgins <brendanhiggins@google.com>
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
To: gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org
Cc: brakmo@fb.com, jdike@addtoit.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, frowand.list@gmail.com, robh@kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, joel@jms.id.au, khilman@baylibre.com, Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com

Add context to current thread that allows a test to specify that it
wants to skip the normal checks to run an installed fault catcher.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/include/asm/processor-generic.h |  4 +++-
 arch/um/kernel/trap.c                   | 15 +++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index b58b746d3f2ca..d566cd416ff02 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -27,6 +27,7 @@ struct thread_struct {
 	struct task_struct *prev_sched;
 	struct arch_thread arch;
 	jmp_buf switch_buf;
+	bool is_running_test;
 	struct {
 		int op;
 		union {
@@ -51,7 +52,8 @@ struct thread_struct {
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.arch			= INIT_ARCH_THREAD, \
-	.request		= { 0 } \
+	.request		= { 0 }, \
+	.is_running_test	= false, \
 }
 
 static inline void release_thread(struct task_struct *task)
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index cced829460427..bf90e678b3d71 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 
+static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
+{
+	current->thread.fault_addr = fault_addr;
+	UML_LONGJMP(catcher, 1);
+}
+
 /*
  * We give a *copy* of the faultinfo in the regs to segv.
  * This must be done, since nesting SEGVs could overwrite
@@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
-	if (!is_user && (address >= start_vm) && (address < end_vm)) {
+	catcher = current->thread.fault_catcher;
+	if (catcher && current->thread.is_running_test)
+		segv_run_catcher(catcher, (void *) address);
+	else if (!is_user && (address >= start_vm) && (address < end_vm)) {
 		flush_tlb_kernel_vm();
 		goto out;
 	}
@@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		address = 0;
 	}
 
-	catcher = current->thread.fault_catcher;
 	if (!err)
 		goto out;
 	else if (catcher != NULL) {
-		current->thread.fault_addr = (void *) address;
-		UML_LONGJMP(catcher, 1);
+		segv_run_catcher(catcher, (void *) address);
 	}
 	else if (current->thread.fault_addr != NULL)
 		panic("fault_addr set but no fault catcher");
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


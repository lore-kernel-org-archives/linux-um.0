Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd4a.google.com ([2607:f8b0:4864:20::d4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCZAu-0004WM-FB
 for linux-um@lists.infradead.org; Tue, 16 Oct 2018 23:55:20 +0000
Received: by mail-io1-xd4a.google.com with SMTP id z20-v6so23259503ioh.2
 for <linux-um@lists.infradead.org>; Tue, 16 Oct 2018 16:54:45 -0700 (PDT)
Date: Tue, 16 Oct 2018 16:51:13 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-25-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
Subject: [RFC v1 24/31] kunit: improved sigsegv stack trace printing
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
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Tim.Bird@sony.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, joe@perches.com, jdike@addtoit.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

Sacrificed the control of printing stack trace within the crash handler
in the test runner for getting a better stack trace; this is still not
ideal, but much better than before.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/kernel/trap.c | 11 ++++++++++-
 kunit/test.c          | 13 +++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 9b97712daf14f..c3ff8346800c4 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -226,8 +226,17 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
 	catcher = current->thread.fault_catcher;
-	if (catcher && current->thread.is_running_test)
+	if (catcher && current->thread.is_running_test) {
+		/*
+		 * TODO(b/77223210): Right now we don't have a way to store a
+		 * copy of the stack, or a copy of information from the stack,
+		 * so we need to print it now; otherwise, the stack will be
+		 * destroyed by segv_run_catcher which works by popping off
+		 * stack frames.
+		 */
+		show_stack(NULL, NULL);
 		segv_run_catcher(catcher, (void *) address);
+	}
 	else if (!is_user && (address >= start_vm) && (address < end_vm)) {
 		flush_tlb_kernel_vm();
 		goto out;
diff --git a/kunit/test.c b/kunit/test.c
index 6ea60059b4918..5d78f76b421af 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -210,12 +210,17 @@ static void test_handle_test_crash(struct test *test,
 				   struct test_module *module,
 				   struct test_case *test_case)
 {
-	test_err(test, "%s crashed", test_case->name);
 	/*
-	 * TODO(brendanhiggins@google.com): This prints the stack trace up
-	 * through this frame, not up to the frame that caused the crash.
+	 * TODO(brendanhiggins@google.com): Right now we don't have a way to
+	 * store a copy of the stack, or a copy of information from the stack,
+	 * so we need to print it in the "trap" handler; otherwise, the stack
+	 * will be destroyed when it returns to us by popping off the
+	 * appropriate stack frames (see longjmp).
+	 *
+	 * Ideally we would print the stack trace here, but we do not have the
+	 * ability to do so with meaningful information at this time.
 	 */
-	show_stack(NULL, NULL);
+	test_err(test, "%s crashed", test_case->name);
 
 	test_case_internal_cleanup(test);
 }
-- 
2.19.1.331.ge82ca0e54c-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


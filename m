Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCZAM-000487-Ll
 for linux-um@lists.infradead.org; Tue, 16 Oct 2018 23:54:26 +0000
Received: by mail-qt1-x849.google.com with SMTP id f20-v6so26497660qta.16
 for <linux-um@lists.infradead.org>; Tue, 16 Oct 2018 16:54:11 -0700 (PDT)
Date: Tue, 16 Oct 2018 16:50:59 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
Subject: [RFC v1 10/31] kunit: test: added concept of initcalls
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

Added a way to add plugins that require a test module to be loaded
during initialization.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 19 +++++++++++++++++++
 kunit/test.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49a9d6e43992c..58dbe2aee423f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -152,6 +152,12 @@ struct test_module {
 	struct test_case *test_cases;
 };
 
+struct test_initcall {
+	struct list_head node;
+	int (*init)(struct test_initcall *this, struct test *test);
+	void (*exit)(struct test_initcall *this);
+};
+
 /**
  * struct test - represents a running instance of a test.
  * @priv: for user to store arbitrary data. Commonly used to pass data created
@@ -183,6 +189,19 @@ int test_init_test(struct test *test, const char *name);
 
 int test_run_tests(struct test_module *module);
 
+void test_install_initcall(struct test_initcall *initcall);
+
+#define test_pure_initcall(fn) postcore_initcall(fn)
+
+#define test_register_initcall(initcall) \
+		static int register_test_initcall_##initcall(void) \
+		{ \
+			test_install_initcall(&initcall); \
+			\
+			return 0; \
+		} \
+		test_pure_initcall(register_test_initcall_##initcall)
+
 /**
  * module_test() - used to register a &struct test_module with KUnit.
  * @module: a statically allocated &struct test_module.
diff --git a/kunit/test.c b/kunit/test.c
index f89cfaaf5eb79..9737465fb0568 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -53,6 +53,19 @@ static void test_set_death_test(struct test *test, bool death_test)
 	spin_unlock_irqrestore(&test->lock, flags);
 }
 
+struct test_global_context {
+	struct list_head initcalls;
+};
+
+static struct test_global_context test_global_context = {
+	.initcalls = LIST_HEAD_INIT(test_global_context.initcalls),
+};
+
+void test_install_initcall(struct test_initcall *initcall)
+{
+	list_add_tail(&initcall->node, &test_global_context.initcalls);
+}
+
 static int test_vprintk_emit(const struct test *test,
 			     int level,
 			     const char *fmt,
@@ -130,8 +143,18 @@ static void test_run_case_internal(struct test *test,
 				   struct test_module *module,
 				   struct test_case *test_case)
 {
+	struct test_initcall *initcall;
 	int ret;
 
+	list_for_each_entry(initcall, &test_global_context.initcalls, node) {
+		ret = initcall->init(initcall, test);
+		if (ret) {
+			test_err(test, "failed to initialize: %d", ret);
+			test->success = false;
+			return;
+		}
+	}
+
 	if (module->init) {
 		ret = module->init(test);
 		if (ret) {
@@ -146,6 +169,12 @@ static void test_run_case_internal(struct test *test,
 
 static void test_case_internal_cleanup(struct test *test)
 {
+	struct test_initcall *initcall;
+
+	list_for_each_entry(initcall, &test_global_context.initcalls, node) {
+		initcall->exit(initcall);
+	}
+
 	test_cleanup(test);
 }
 
-- 
2.19.1.331.ge82ca0e54c-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


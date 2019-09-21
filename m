Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBT7f-0005Qr-1H
 for linux-um@lists.infradead.org; Sat, 21 Sep 2019 00:19:36 +0000
Received: by mail-pf1-x449.google.com with SMTP id v6so5861600pfm.1
 for <linux-um@lists.infradead.org>; Fri, 20 Sep 2019 17:19:33 -0700 (PDT)
Date: Fri, 20 Sep 2019 17:18:46 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
Subject: [PATCH v17 10/19] kunit: test: add tests for kunit test abort
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
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at, torvalds@linux-foundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org, logang@deltatee.com

Add KUnit tests for the KUnit test abort mechanism (see preceding
commit). Add tests both for general try catch mechanism as well as
non-architecture specific mechanism.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/Makefile    |   3 +-
 lib/kunit/test-test.c | 106 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 lib/kunit/test-test.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index c9176c9c578c..769d9402b5d3 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_KUNIT) +=			test.o \
 					assert.o \
 					try-catch.o
 
-obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
+					string-stream-test.o
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
new file mode 100644
index 000000000000..06d34d36b103
--- /dev/null
+++ b/lib/kunit/test-test.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for core test infrastructure.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+struct kunit_try_catch_test_context {
+	struct kunit_try_catch *try_catch;
+	bool function_called;
+};
+
+static void kunit_test_successful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_no_catch(void *data)
+{
+	struct kunit *test = data;
+
+	KUNIT_FAIL(test, "Catch should not be called\n");
+}
+
+static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_successful_try,
+			     kunit_test_no_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_unsuccessful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_throw(try_catch);
+	KUNIT_FAIL(test, "This line should never be reached\n");
+}
+
+static void kunit_test_catch(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_unsuccessful_try,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static int kunit_try_catch_test_init(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	test->priv = ctx;
+
+	ctx->try_catch = kunit_kmalloc(test,
+				       sizeof(*ctx->try_catch),
+				       GFP_KERNEL);
+	if (!ctx->try_catch)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct kunit_case kunit_try_catch_test_cases[] = {
+	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
+	{}
+};
+
+static struct kunit_suite kunit_try_catch_test_suite = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+kunit_test_suite(kunit_try_catch_test_suite);
-- 
2.23.0.351.gc4317032e6-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


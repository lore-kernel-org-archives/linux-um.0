Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCZAP-0004AR-Rb
 for linux-um@lists.infradead.org; Tue, 16 Oct 2018 23:54:30 +0000
Received: by mail-qk1-x749.google.com with SMTP id r77-v6so25979704qke.3
 for <linux-um@lists.infradead.org>; Tue, 16 Oct 2018 16:54:14 -0700 (PDT)
Date: Tue, 16 Oct 2018 16:51:00 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
Subject: [RFC v1 11/31] kunit: test: added concept of post conditions
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

Adds a way to specify that certain conditions must be met at the end of
a test case.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h |  6 ++++++
 kunit/test.c         | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 58dbe2aee423f..be2b11117d1de 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -158,6 +158,11 @@ struct test_initcall {
 	void (*exit)(struct test_initcall *this);
 };
 
+struct test_post_condition {
+	struct list_head node;
+	void (*validate)(struct test_post_condition *condition);
+};
+
 /**
  * struct test - represents a running instance of a test.
  * @priv: for user to store arbitrary data. Commonly used to pass data created
@@ -177,6 +182,7 @@ struct test {
 	bool success; /* Protected by lock. */
 	bool death_test; /* Protected by lock. */
 	struct list_head resources; /* Protected by lock. */
+	struct list_head post_conditions;
 	void (*set_death_test)(struct test *test, bool death_test);
 	void (*vprintk)(const struct test *test,
 			const char *level,
diff --git a/kunit/test.c b/kunit/test.c
index 9737465fb0568..6ea60059b4918 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -125,8 +125,9 @@ static void __noreturn test_abort(struct test *test)
 
 int test_init_test(struct test *test, const char *name)
 {
-	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
+	INIT_LIST_HEAD(&test->post_conditions);
+	spin_lock_init(&test->lock);
 	test->name = name;
 	test->set_death_test = test_set_death_test;
 	test->vprintk = test_vprintk;
@@ -186,6 +187,16 @@ static void test_run_case_cleanup(struct test *test,
 				  struct test_module *module,
 				  struct test_case *test_case)
 {
+	struct test_post_condition *condition, *condition_safe;
+
+	list_for_each_entry_safe(condition,
+				 condition_safe,
+				 &test->post_conditions,
+				 node) {
+		condition->validate(condition);
+		list_del(&condition->node);
+	}
+
 	if (module->exit)
 		module->exit(test);
 
-- 
2.19.1.331.ge82ca0e54c-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


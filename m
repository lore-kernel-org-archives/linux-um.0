Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igyWA-0001vm-AL
 for linux-um@lists.infradead.org; Mon, 16 Dec 2019 22:07:07 +0000
Received: by mail-pj1-x1049.google.com with SMTP id iq22so4182230pjb.21
 for <linux-um@lists.infradead.org>; Mon, 16 Dec 2019 14:07:05 -0800 (PST)
Date: Mon, 16 Dec 2019 14:05:55 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
Subject: [RFC v1 6/6] kunit: Add 'kunit_shutdown' option
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: linux-arch@vger.kernel.org, sboyd@kernel.org, gregkh@linuxfoundation.org, knut.omang@oracle.com, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

From: David Gow <davidgow@google.com>

Add a new kernel command-line option, 'kunit_shutdown', which allows the
user to specify that the kernel poweroff, halt, or reboot after
completing all KUnit tests; this is very handy for running KUnit tests
on UML or a VM so that the UML/VM process exits cleanly immediately
after running all tests without needing a special initramfs.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/executor.c                | 18 ++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  2 +-
 tools/testing/kunit/kunit_parser.py |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index d5f1d07f2f817..32462ecb94eb6 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -7,7 +7,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/printk.h>
+#include <linux/reboot.h>
 #include <kunit/test.h>
 
 /*
@@ -17,6 +19,9 @@
 extern struct kunit_suite *__kunit_suites_start[];
 extern struct kunit_suite *__kunit_suites_end[];
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
 static void kunit_print_tap_header(void)
 {
 	size_t num_of_suites;
@@ -30,6 +35,17 @@ static void kunit_print_tap_header(void)
 	pr_info("1..%zd\n", num_of_suites);
 }
 
+static void kunit_handle_shutdown(void)
+{
+	if (!strcmp(kunit_shutdown, "poweroff")) {
+		kernel_power_off();
+	} else if (!strcmp(kunit_shutdown, "halt")) {
+		kernel_halt();
+	} else if (!strcmp(kunit_shutdown, "reboot")) {
+		kernel_restart(NULL);
+	}
+}
+
 static bool kunit_run_all_tests(void)
 {
 	struct kunit_suite **suite;
@@ -44,6 +60,8 @@ static bool kunit_run_all_tests(void)
 			has_test_failed = true;
 	}
 
+	kunit_handle_shutdown();
+
 	return !has_test_failed;
 }
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf38768353313..0070c6b807d2a 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -141,7 +141,7 @@ class LinuxSourceTree(object):
 		return True
 
 	def run_kernel(self, args=[], timeout=None, build_dir=None):
-		args.extend(['mem=256M'])
+		args.extend(['mem=256M', 'kunit_shutdown=halt'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
 		with open('test.log', 'w') as f:
 			for line in process.stdout:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 78b3bdd03b1e4..633811dd9bce8 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -48,7 +48,7 @@ class TestStatus(Enum):
 	FAILURE_TO_PARSE_TESTS = auto()
 
 kunit_start_re = re.compile(r'^TAP version [0-9]+$')
-kunit_end_re = re.compile('List of all partitions:')
+kunit_end_re = re.compile(r'reboot: System halted')
 
 def isolate_kunit_output(kernel_output):
 	started = False
-- 
2.24.1.735.g03f4e72817-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


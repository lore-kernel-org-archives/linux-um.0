Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x24a.google.com ([2607:f8b0:4864:20::24a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gF6av-0004LY-6N
 for linux-um@lists.infradead.org; Wed, 24 Oct 2018 00:00:32 +0000
Received: by mail-oi1-x24a.google.com with SMTP id n186-v6so2222416oig.13
 for <linux-um@lists.infradead.org>; Tue, 23 Oct 2018 17:00:05 -0700 (PDT)
Date: Tue, 23 Oct 2018 16:57:47 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
Subject: [RFC v2 11/14] kunit: add KUnit wrapper script and simple output
 parser
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
Cc: brakmo@fb.com, jdike@addtoit.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, kieran.bingham@ideasonboard.com, Felix Guo <felixguoxiuping@gmail.com>, joel@jms.id.au, khilman@baylibre.com, Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com

The KUnit wrapper script interfaces with the two modules
(kunit_config.py and kunit_kernel.py) and provides a command line
interface for running KUnit tests. This interface allows the caller to
specify options like test timeouts. The script handles configuring,
building and running the kernel and tests.

The output parser (kunit_parser.py) simply strips out all the output
from the kernel that is outputted as part of it's initialization
sequence. This ensures that only the output from KUnit is displayed
on the screen.

A full version of the output is written to test.log, or can be seen by
passing --raw_output to the wrapper script.

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 40 +++++++++++++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  3 +--
 tools/testing/kunit/kunit_parser.py | 24 +++++++++++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/kunit/kunit.py
 create mode 100644 tools/testing/kunit/kunit_parser.py

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
new file mode 100755
index 0000000000000..1356be404996b
--- /dev/null
+++ b/tools/testing/kunit/kunit.py
@@ -0,0 +1,40 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+
+# A thin wrapper on top of the KUnit Kernel
+
+import argparse
+import sys
+import os
+
+import kunit_config
+import kunit_kernel
+import kunit_parser
+
+parser = argparse.ArgumentParser(description='Runs KUnit tests.')
+
+parser.add_argument('--raw_output', help='don\'t format output from kernel',
+		    action='store_true')
+
+parser.add_argument('--timeout', help='maximum number of seconds to allow for '
+		    'all tests to run. This does not include time taken to '
+		    'build the tests.', type=int, default=300,
+		    metavar='timeout')
+
+cli_args = parser.parse_args()
+linux = kunit_kernel.LinuxSourceTree()
+
+success = linux.build_reconfig()
+if not success:
+	quit()
+
+print('Building KUnit Kernel ...')
+success = linux.build_um_kernel()
+if not success:
+	quit()
+
+print('Starting KUnit Kernel ...')
+if cli_args.raw_output:
+	kunit_parser.raw_output(linux.run_kernel(timeout=cli_args.timeout))
+else:
+	kunit_parser.parse_run_tests(linux.run_kernel(timeout=cli_args.timeout))
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 87abaede50513..c1259b174f7d4 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -113,8 +113,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def run_kernel(self, args=[]):
-		timeout = None
+	def run_kernel(self, args=[], timeout=None):
 		args.extend(['mem=256M'])
 		process = self._ops.linux_bin(args, timeout)
 		with open('test.log', 'w') as f:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
new file mode 100644
index 0000000000000..1dff3adb73bd3
--- /dev/null
+++ b/tools/testing/kunit/kunit_parser.py
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import re
+
+kunit_start_re = re.compile('console .* enabled')
+kunit_end_re = re.compile('List of all partitions:')
+
+def isolate_kunit_output(kernel_output):
+	started = False
+	for line in kernel_output:
+		if kunit_start_re.match(line):
+			started = True
+		elif kunit_end_re.match(line):
+			break
+		elif started:
+			yield line
+
+def raw_output(kernel_output):
+	for line in kernel_output:
+		print(line)
+
+def parse_run_tests(kernel_output):
+	for output in isolate_kunit_output(kernel_output):
+		print(output)
-- 
2.19.1.568.g152ad8e336-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


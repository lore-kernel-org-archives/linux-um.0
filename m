Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkJTc-0000FW-Hj
 for linux-um@lists.infradead.org; Sat, 22 May 2021 04:43:05 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id
 s8-20020a5b04480000b029049fb35700b9so30356950ybp.5
 for <linux-um@lists.infradead.org>; Fri, 21 May 2021 21:43:03 -0700 (PDT)
Date: Fri, 21 May 2021 21:42:40 -0700
In-Reply-To: <20210522044241.2763088-1-davidgow@google.com>
Message-Id: <20210522044241.2763088-2-davidgow@google.com>
Mime-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com>
Subject: [PATCH v2 2/3] kunit: Move default config from arch/um ->
 tools/testing/kunit
From: David Gow <davidgow@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>, Shuah Khan <shuah@kernel.org>
Cc: David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

The default .kunitconfig file is currently kept in
arch/um/configs/kunit_defconfig, but -- with the impending QEMU patch
-- will no-longer be exclusively used for UML-based kernels.

Move it alongside the other KUnit configs in
tools/testing/kunit/configs, and give it a name which matches the
existing all_tests.config and broken_on_uml.config files.

Also update the Getting Started documentation to point to the new file.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/start.rst                         | 2 +-
 .../testing/kunit/configs/default.config                        | 0
 tools/testing/kunit/kunit_kernel.py                             | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/um/configs/kunit_defconfig => tools/testing/kunit/configs/default.config (100%)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 0e65cabe08eb..5becb09b1751 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -36,7 +36,7 @@ A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
-	cp arch/um/configs/kunit_defconfig .kunitconfig
+	cp tools/testing/kunit/configs/default.config .kunitconfig
 
 You can then add any other Kconfig options you wish, e.g.:
 
diff --git a/arch/um/configs/kunit_defconfig b/tools/testing/kunit/configs/default.config
similarity index 100%
rename from arch/um/configs/kunit_defconfig
rename to tools/testing/kunit/configs/default.config
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 89a7d4024e87..5b57a43de33f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -20,7 +20,7 @@ import kunit_parser
 
 KCONFIG_PATH = '.config'
 KUNITCONFIG_PATH = '.kunitconfig'
-DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
+DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 OUTFILE_PATH = 'test.log'
 
-- 
2.31.1.818.g46aad6cb9e-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


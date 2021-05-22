Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkJTR-0000E7-Dw
 for linux-um@lists.infradead.org; Sat, 22 May 2021 04:42:55 +0000
Received: by mail-yb1-xb49.google.com with SMTP id
 s8-20020a5b04480000b029049fb35700b9so30356525ybp.5
 for <linux-um@lists.infradead.org>; Fri, 21 May 2021 21:42:51 -0700 (PDT)
Date: Fri, 21 May 2021 21:42:39 -0700
Message-Id: <20210522044241.2763088-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH v2 1/3] kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by
 default
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
Cc: David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Latypov <dlatypov@google.com>

Make the default .kunitconfig (specified in
arch/um/configs/kunit_defconfig) specify CONFIG_KUNIT_ALL_TESTS by
default. KUNIT_ALL_TESTS runs all tests which have satisfied
dependencies in the current .config (which would be the architecture
defconfig).

Currently, the default .kunitconfig enables only the example tests and
KUnit's own tests. While this does provide a good example of what a
.kunitconfig for running a few individual tests should look like, it
does mean that kunit_tool runs a pretty paltry collection of tests by
default.

The example tests' config entry (CONFIG_KUNIT_EXAMPLE_TEST=y) continues
to be included -- despite now being redundant -- to provide an example
of how tests are enabled when KUNIT_ALL_TESTS is disabled.

A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
instead of 14.

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210518035825.1885357-1-davidgow@google.com/
- Keep the KUNIT_EXAMPLE_TEST entry as an example.
- Move (in patches 2,3) kunit_defconfig to tools/testing/kunit/configs
  and replace all_tests.config.

 arch/um/configs/kunit_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
index 9235b7d42d38..e67af7b9f1bb 100644
--- a/arch/um/configs/kunit_defconfig
+++ b/arch/um/configs/kunit_defconfig
@@ -1,3 +1,3 @@
 CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
 CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_KUNIT_ALL_TESTS=y
-- 
2.31.1.818.g46aad6cb9e-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liqsO-00EI6M-NE
 for linux-um@lists.infradead.org; Tue, 18 May 2021 03:58:42 +0000
Received: by mail-pj1-x104a.google.com with SMTP id
 a11-20020a17090a70cbb029015d3e996884so895201pjm.4
 for <linux-um@lists.infradead.org>; Mon, 17 May 2021 20:58:34 -0700 (PDT)
Date: Mon, 17 May 2021 20:58:25 -0700
Message-Id: <20210518035825.1885357-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by default
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
Cc: David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

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

A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
instead of 14.

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/configs/kunit_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
index 9235b7d42d38..becf3432a375 100644
--- a/arch/um/configs/kunit_defconfig
+++ b/arch/um/configs/kunit_defconfig
@@ -1,3 +1,2 @@
 CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
-CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_KUNIT_ALL_TESTS=y
-- 
2.31.1.751.gd2f1c929bd-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


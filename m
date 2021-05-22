Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkJTh-0000GS-1d
 for linux-um@lists.infradead.org; Sat, 22 May 2021 04:43:10 +0000
Received: by mail-yb1-xb49.google.com with SMTP id
 o12-20020a5b050c0000b02904f4a117bd74so29977692ybp.17
 for <linux-um@lists.infradead.org>; Fri, 21 May 2021 21:43:07 -0700 (PDT)
Date: Fri, 21 May 2021 21:42:41 -0700
In-Reply-To: <20210522044241.2763088-1-davidgow@google.com>
Message-Id: <20210522044241.2763088-3-davidgow@google.com>
Mime-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com>
Subject: [PATCH v2 3/3] kunit: Remove the unused all_tests.config
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

This isn't used anywhere. While it's possible that people were manually
referencing it, the new default config (in default.config in the same
path) provides equivalent functionality.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/configs/all_tests.config | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
deleted file mode 100644
index 9235b7d42d38..000000000000
--- a/tools/testing/kunit/configs/all_tests.config
+++ /dev/null
@@ -1,3 +0,0 @@
-CONFIG_KUNIT=y
-CONFIG_KUNIT_TEST=y
-CONFIG_KUNIT_EXAMPLE_TEST=y
-- 
2.31.1.818.g46aad6cb9e-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


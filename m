Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxGSE-0006t5-Sd
 for linux-um@lists.infradead.org; Sun, 19 Jul 2020 21:02:40 +0000
Received: by mail-wr1-x444.google.com with SMTP id a6so15928738wrm.4
 for <linux-um@lists.infradead.org>; Sun, 19 Jul 2020 14:02:38 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v4 1/3] um/kconfig: introduce
 CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
Date: Sun, 19 Jul 2020 22:02:20 +0100
Message-Id: <20200719210222.2811-2-ignat@cloudflare.com>
In-Reply-To: <20200719210222.2811-1-ignat@cloudflare.com>
References: <20200719210222.2811-1-ignat@cloudflare.com>
MIME-Version: 1.0
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, brendanhiggins@google.com, masahiroy@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>

For statically linked UML build it is important to take into account the
standard C-library implementation. Some implementations, notably glibc have
caveats: even when linked statically, the final program might require some
runtime dependencies, if certain functions are used within the code.

Consider the following program:
int main(void)
{
	getpwent();
	return 0;
}

Compiling this program and linking statically with glibc produces the following
warning from the linker:
/usr/sbin/ld: /tmp/ccuthw1o.o: in function `main':
test.c:(.text+0x5): warning: Using 'getpwent' in statically linked
applications requires at runtime the shared libraries from the glibc version
used for linking

We will use the flag to detect such C-library implementation build time and
possibly disable static linking for UML to avoid producing a binary with
unexpected behaviour and dependencies.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 init/Kconfig           | 6 ++++++
 scripts/cc-can-link.sh | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..0a1ec56c9f33 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -57,6 +57,12 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
 
+config CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
+	bool
+	depends on UML && CC_CAN_LINK_STATIC
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static -Xlinker --fatal-warnings) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static -Xlinker --fatal-warnings)
+
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
 
diff --git a/scripts/cc-can-link.sh b/scripts/cc-can-link.sh
index 6efcead31989..e5011a46103e 100755
--- a/scripts/cc-can-link.sh
+++ b/scripts/cc-can-link.sh
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 cat << "END" | $@ -x c - -o /dev/null >/dev/null 2>&1
-#include <stdio.h>
+#include <sys/types.h>
+#include <pwd.h>
 int main(void)
 {
-	printf("");
+	getpwent();
 	return 0;
 }
 END
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


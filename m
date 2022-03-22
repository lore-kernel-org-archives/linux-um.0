Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWiTN-00BkjT-3M
 for linux-um@lists.infradead.org; Tue, 22 Mar 2022 17:39:10 +0000
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] um: Fix filtering '-mno-global-merge'
Date: Tue, 22 Mar 2022 10:35:47 -0700
Message-Id: <20220322173547.677760-1-nathan@kernel.org>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>, David Gow <davidgow@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>

When booting a clang compiled UML kernel, the kernel panics when trying
to run init:

  wait_stub_done : failed to wait for SIGTRAP, pid = 651294, n = 651294, errno = 0, status = 0xb7f
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

After the commit in Fixes, many flags from KBUILD_CFLAGS do not appear
in USER_CFLAGS, likely due to USER_CFLAGS initially being a recursive
variable ("VAR =") then being switched to a simple ("VAR :=") variable.
For example, diffing arch/x86/um/.ptrace_user.o.cmd shows flags such as
'-Os' and '-fno-delete-null-pointer-checks' getting dropped, which both
impact code generation.

Rework the filtering to use filter-out instead of patsubst, which allows
all the patterns that USER_CFLAGS cares about to be excluded in one
command and ensures all flags from KBUILD_CFLAGS are transferred over to
USER_CFLAGS properly, which resolves the boot issue noted above.

Fixes: 6580c5c18fb3 ("um: clang: Strip out -mno-global-merge from USER_CFLAGS")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 320b09cd513c..d202f501e9e1 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -70,15 +70,11 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+USER_CFLAGS = $(filter-out $(KERNEL_DEFINES) -I% -mno-global-merge,$(KBUILD_CFLAGS)) \
 		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
-ifdef CONFIG_CC_IS_CLANG
-USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
-endif
-
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 

base-commit: 82017457957a550d7d00dde419435dd74a890887
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


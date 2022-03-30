Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZi0w-0007Lb-Pi
 for linux-um@lists.infradead.org; Wed, 30 Mar 2022 23:46:12 +0000
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] Revert "um: clang: Strip out -mno-global-merge from
 USER_CFLAGS"
Date: Wed, 30 Mar 2022 16:45:28 -0700
Message-Id: <20220330234528.1426991-3-nathan@kernel.org>
In-Reply-To: <20220330234528.1426991-1-nathan@kernel.org>
References: <20220330234528.1426991-1-nathan@kernel.org>
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
To: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Kees Cook <keescook@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, llvm@lists.linux.dev, patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>

This reverts commit 6580c5c18fb3df2b11c5e0452372f815deeff895.

This patch is buggy, as noted in the patch linked below. The root cause
has been solved by removing '-mno-global-merge' for the entire kernel.

Link: https://lore.kernel.org/r/20220322173547.677760-1-nathan@kernel.org/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 320b09cd513c..f2fe63bfd819 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -75,10 +75,6 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
-ifdef CONFIG_CC_IS_CLANG
-USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
-endif
-
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


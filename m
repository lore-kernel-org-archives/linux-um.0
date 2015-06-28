Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Sun, 28 Jun 2015 23:00:33 +0200
Message-Id: <1435525233-14656-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Fix out-of-tree build
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit 30b11ee9a (um: Remove copy&paste code from init.h)
uncovered an issue wrt. out-of-tree builds.
For out-of-tree builds, we must not rely on relative paths.
Before 30b11ee9a it worked by chance as no host code included
generated header files.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 098ab33..e3abe6f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -70,8 +70,8 @@ KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
-		-D_FILE_OFFSET_BITS=64 -idirafter include \
-		-D__KERNEL__ -D__UM_HOST__
+		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
+		-idirafter $(obj)/include -D__KERNEL__ -D__UM_HOST__
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(ARCH_DIR)/Makefile-os-$(OS)
-- 
1.8.4.5


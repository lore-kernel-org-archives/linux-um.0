Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 1/2] um: link vmlinux with -no-pie
Date: Sun, 20 Aug 2017 13:26:04 +0200
Message-Id: <20170820112605.19883-1-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Thomas Meyer <thomas@m3y3r.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Debian's gcc defaults to pie. The global Makefile already defines the -fno-pie option.
Link UML dynamic kernel image also with -no-pie to fix the build.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1c9269b2c2a..8e3ae6d0c810 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -121,7 +121,7 @@ archheaders:
 archprepare: include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
-- 
2.11.0



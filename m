Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "H. Peter Anvin" <hpa@linux.intel.com>
Date: Mon,  5 Dec 2011 17:05:48 -0800
Message-Id: <1323133549-13590-3-git-send-email-hpa@linux.intel.com>
In-Reply-To: <1323133549-13590-1-git-send-email-hpa@linux.intel.com>
References: <1323133549-13590-1-git-send-email-hpa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 2/3] um: Generate headers before generating user-offsets.s
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@linux.intel.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: "H. Peter Anvin" <hpa@linux.intel.com>

In case we need generated header files for the values in
user-offsets.h, make sure we build generated header files before
user-offsets.s is built.

Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
---
 arch/um/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 00210e9..9548ddc 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -140,7 +140,7 @@ archclean:
 
 # Generated files
 
-$(HOST_DIR)/um/user-offsets.s: FORCE
+$(HOST_DIR)/um/user-offsets.s: __headers FORCE
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um $@
 
 define filechk_gen-asm-offsets
-- 
1.7.6.4


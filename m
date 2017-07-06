Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Correctly check for PTRACE_GETRESET/SETREGSET
Date: Thu,  6 Jul 2017 09:35:27 +0200
Message-Id: <20170706073527.12006-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Florian Fainelli <f.fainelli@gmail.com>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

When checking for PTRACE_GETRESET/SETREGSET, make sure that
the correct header file is included. We need linux/ptrace.h
which contains all ptrace UAPI related defines.
Otherwise #if defined(PTRACE_GETRESET) is always false.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/user-offsets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index 8af0fb5d2780..ae4cd58c0c7a 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -5,7 +5,7 @@
 #include <sys/mman.h>
 #include <sys/user.h>
 #define __FRAME_OFFSETS
-#include <asm/ptrace.h>
+#include <linux/ptrace.h>
 #include <asm/types.h>
 
 #ifdef __i386__
-- 
2.12.3



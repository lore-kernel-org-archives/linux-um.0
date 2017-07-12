Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Re-enable verbose panic()
Date: Wed, 12 Jul 2017 22:53:56 +0200
Message-Id: <20170712205356.23042-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit 9a93848fe787 ("x86/debug: Implement __WARN() using UD0")
rightfully removed GENERIC_BUG from UML because UML didn't use
that feature.
A side effect of this is that DEBUG_BUGVERBOSE no longer
set and therefore panic() doesn't print a stack trace.

Let's select DEBUG_BUGVERBOSE manually to have a verbose panic()
again.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 85f6dd204ab6..3cb6cd80ee4c 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -13,6 +13,8 @@ config UML
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
 	select TTY # Needed for line.c
+	select HAVE_DEBUG_BUGVERBOSE
+	select DEBUG_BUGVERBOSE
 
 config MMU
 	bool
-- 
2.12.3



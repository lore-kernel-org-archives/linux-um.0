Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH v2 3/3] seccomp: Remove 2-phase API documentation
Date: Mon,  1 Aug 2016 23:01:57 +0200
Message-Id: <1470085317-11932-4-git-send-email-mic@digikod.net>
In-Reply-To: <1470085317-11932-1-git-send-email-mic@digikod.net>
References: <alpine.LRH.2.20.1608011053430.15475@namei.org>
 <1470085317-11932-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Morris <jmorris@namei.org>, Olof Johansson <olof@lixom.net>, user-mode-linux-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Fixes: 8112c4f140fa ("seccomp: remove 2-phase API")

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: James Morris <jmorris@namei.org>
---
 arch/Kconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d794384a0404..96e434638767 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -336,17 +336,6 @@ config HAVE_ARCH_SECCOMP_FILTER
 	    results in the system call being skipped immediately.
 	  - seccomp syscall wired up
 
-	  For best performance, an arch should use seccomp_phase1 and
-	  seccomp_phase2 directly.  It should call seccomp_phase1 for all
-	  syscalls if TIF_SECCOMP is set, but seccomp_phase1 does not
-	  need to be called from a ptrace-safe context.  It must then
-	  call seccomp_phase2 if seccomp_phase1 returns anything other
-	  than SECCOMP_PHASE1_OK or SECCOMP_PHASE1_SKIP.
-
-	  As an additional optimization, an arch may provide seccomp_data
-	  directly to seccomp_phase1; this avoids multiple calls
-	  to the syscall_xyz helpers for every syscall.
-
 config SECCOMP_FILTER
 	def_bool y
 	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
-- 
2.8.1



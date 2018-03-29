Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Fix return value of start_idle_thread
Date: Thu, 29 Mar 2018 22:45:59 +0200
Message-Id: <20180329204559.14113-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at, jdike@addtoit.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

While the function will never returns, gcc will warns.
Add a return statement to make gcc happy.
Before f44f1e7da7c8 we never noticed because gcc knows that longjmp does
not return.

arch/um/os-Linux/skas/process.c: In function ‘start_idle_thread’:
arch/um/os-Linux/skas/process.c:613:1: warning: control reaches end of non-void function [-Wreturn-type]

Fixes: f44f1e7da7c8 ("um: Avoid longjmp/setjmp symbol clashes with libpthread.a")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/skas/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index c94c3bd70ccd..d41fdf686a5f 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -610,6 +610,10 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	fatal_sigsegv();
+	return 0;
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-- 
2.13.6



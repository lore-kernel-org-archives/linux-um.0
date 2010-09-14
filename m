Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/1] uml: fix compile warning
Date: Tue, 14 Sep 2010 23:27:46 +0200
Message-Id: <1284499666-17568-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jdike@addtoit.com, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, dhowells@redhat.com, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This fixes:
incompatible pointer type:  => 89
       arch/um/kernel/exec.c: warning: passing argument 2 of 'execve1' from
incompatible pointer type:  => 69, 85
       arch/um/kernel/exec.c: warning: passing argument 3 of 'execve1' from
incompatible pointer type:  => 69, 85

which was introduced by d7627467b7a8dd6944885290a03a07ceb28c10eb
(Make do_execve() take a const filename pointer)

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/exec.c     |    6 +++---
 arch/um/kernel/internal.h |    2 +-
 arch/um/kernel/syscall.c  |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index cd145ed..49b5e1e 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -62,7 +62,7 @@ static long execve1(const char *file,
 	return error;
 }
 
-long um_execve(const char *file, char __user *__user *argv, char __user *__user *env)
+long um_execve(const char *file, const char __user *const __user *argv, const char __user *const __user *env)
 {
 	long err;
 
@@ -72,8 +72,8 @@ long um_execve(const char *file, char __user *__user *argv, char __user *__user
 	return err;
 }
 
-long sys_execve(const char __user *file, char __user *__user *argv,
-		char __user *__user *env)
+long sys_execve(const char __user *file, const char __user *const __user *argv,
+		const char __user *const __user *env)
 {
 	long error;
 	char *filename;
diff --git a/arch/um/kernel/internal.h b/arch/um/kernel/internal.h
index 1303a10..5bf97db 100644
--- a/arch/um/kernel/internal.h
+++ b/arch/um/kernel/internal.h
@@ -1 +1 @@
-extern long um_execve(const char *file, char __user *__user *argv, char __user *__user *env);
+extern long um_execve(const char *file, const char __user *const __user *argv, const char __user *const __user *env);
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index 5ddb246..f958cb8 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -60,8 +60,8 @@ int kernel_execve(const char *filename,
 
 	fs = get_fs();
 	set_fs(KERNEL_DS);
-	ret = um_execve(filename, (char __user *__user *)argv,
-			(char __user *__user *) envp);
+	ret = um_execve(filename, (const char __user *const __user *)argv,
+			(const char __user *const __user *) envp);
 	set_fs(fs);
 
 	return ret;
-- 
1.6.6.1


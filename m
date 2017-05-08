Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH v2 3/6] um: Use os_info for the messages on normal path
Date: Mon,  8 May 2017 15:18:56 +0900
Message-Id: <149422432600.11101.9820185242266343537.stgit@devbox>
In-Reply-To: <149422411127.11101.13017249012576512464.stgit@devbox>
References: <149422411127.11101.13017249012576512464.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use os_info() for printing out the messages on the
normal execution path.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/kernel/um_arch.c    |    8 ++++----
 arch/um/os-Linux/main.c     |    3 +--
 arch/um/os-Linux/mem.c      |   18 +++++++++---------
 arch/um/os-Linux/start_up.c |   26 ++++++++++++++------------
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 64a1fd0..5df91d8 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -289,8 +289,8 @@ int __init linux_main(int argc, char **argv)
 
 	diff = UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
 	if (diff > 1024 * 1024) {
-		printf("Adding %ld bytes to physical memory to account for "
-		       "exec-shield gap\n", diff);
+		os_info("Adding %ld bytes to physical memory to account for "
+			"exec-shield gap\n", diff);
 		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
 	}
 
@@ -330,8 +330,8 @@ int __init linux_main(int argc, char **argv)
 	end_vm = start_vm + virtmem_size;
 
 	if (virtmem_size < physmem_size)
-		printf("Kernel virtual memory size shrunk to %lu bytes\n",
-		       virtmem_size);
+		os_info("Kernel virtual memory size shrunk to %lu bytes\n",
+			virtmem_size);
 
 	os_flush_stdout();
 
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 9d499de..f880dcd 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -184,14 +184,13 @@ int __init main(int argc, char **argv, char **envp)
 	 */
 	unblock_signals();
 
+	os_info("\n");
 	/* Reboot */
 	if (ret) {
-		printf("\n");
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret = 1;
 	}
-	printf("\n");
 	return uml_exitcode;
 }
 
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 8b17676..a7f6023 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -25,13 +25,13 @@ static int __init check_tmpfs(const char *dir)
 {
 	struct statfs st;
 
-	printf("Checking if %s is on tmpfs...", dir);
+	os_info("Checking if %s is on tmpfs...", dir);
 	if (statfs(dir, &st) < 0) {
-		printf("%s\n", strerror(errno));
+		os_info("%s\n", strerror(errno));
 	} else if (st.f_type != TMPFS_MAGIC) {
-		printf("no\n");
+		os_info("no\n");
 	} else {
-		printf("OK\n");
+		os_info("OK\n");
 		return 0;
 	}
 	return -1;
@@ -61,18 +61,18 @@ static char * __init choose_tempdir(void)
 	int i;
 	const char *dir;
 
-	printf("Checking environment variables for a tempdir...");
+	os_info("Checking environment variables for a tempdir...");
 	for (i = 0; vars[i]; i++) {
 		dir = getenv(vars[i]);
 		if ((dir != NULL) && (*dir != '\0')) {
-			printf("%s\n", dir);
+			os_info("%s\n", dir);
 			if (check_tmpfs(dir) >= 0)
 				goto done;
 			else
 				goto warn;
 		}
 	}
-	printf("none found\n");
+	os_info("none found\n");
 
 	for (i = 0; tmpfs_dirs[i]; i++) {
 		dir = tmpfs_dirs[i];
@@ -194,7 +194,7 @@ void __init check_tmpexec(void)
 
 	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
 		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
-	printf("Checking PROT_EXEC mmap in %s...", tempdir);
+	os_info("Checking PROT_EXEC mmap in %s...", tempdir);
 	if (addr == MAP_FAILED) {
 		err = errno;
 		printf("%s\n", strerror(err));
@@ -203,7 +203,7 @@ void __init check_tmpexec(void)
 			printf("%s must be not mounted noexec\n", tempdir);
 		exit(1);
 	}
-	printf("OK\n");
+	os_info("OK\n");
 	munmap(addr, UM_KERN_PAGE_SIZE);
 
 	close(fd);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 22a358e..5a61a93 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -166,7 +166,7 @@ static void __init check_sysemu(void)
 	unsigned long regs[MAX_REG_NR];
 	int pid, n, status, count=0;
 
-	non_fatal("Checking syscall emulation patch for ptrace...");
+	os_info("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
 	pid = start_ptraced_child();
 
@@ -199,10 +199,10 @@ static void __init check_sysemu(void)
 		goto fail_stopped;
 
 	sysemu_supported = 1;
-	non_fatal("OK\n");
+	os_info("OK\n");
 	set_using_sysemu(!force_sysemu_disabled);
 
-	non_fatal("Checking advanced syscall emulation patch for ptrace...");
+	os_info("Checking advanced syscall emulation patch for ptrace...");
 	pid = start_ptraced_child();
 
 	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
@@ -244,7 +244,7 @@ static void __init check_sysemu(void)
 		goto fail_stopped;
 
 	sysemu_supported = 2;
-	non_fatal("OK\n");
+	os_info("OK\n");
 
 	if (!force_sysemu_disabled)
 		set_using_sysemu(sysemu_supported);
@@ -260,7 +260,7 @@ static void __init check_ptrace(void)
 {
 	int pid, syscall, n, status;
 
-	non_fatal("Checking that ptrace can change system call numbers...");
+	os_info("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child();
 
 	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
@@ -292,7 +292,7 @@ static void __init check_ptrace(void)
 		}
 	}
 	stop_ptraced_child(pid, 0, 1);
-	non_fatal("OK\n");
+	os_info("OK\n");
 	check_sysemu();
 }
 
@@ -308,15 +308,17 @@ static void __init check_coredump_limit(void)
 		return;
 	}
 
-	printf("Core dump limits :\n\tsoft - ");
+	os_info("Core dump limits :\n\tsoft - ");
 	if (lim.rlim_cur == RLIM_INFINITY)
-		printf("NONE\n");
-	else printf("%lu\n", lim.rlim_cur);
+		os_info("NONE\n");
+	else
+		os_info("%lu\n", lim.rlim_cur);
 
-	printf("\thard - ");
+	os_info("\thard - ");
 	if (lim.rlim_max == RLIM_INFINITY)
-		printf("NONE\n");
-	else printf("%lu\n", lim.rlim_max);
+		os_info("NONE\n");
+	else
+		os_info("%lu\n", lim.rlim_max);
 }
 
 void __init os_early_checks(void)



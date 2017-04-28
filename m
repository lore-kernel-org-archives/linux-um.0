Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 4/7] um: Use non_fatal() for non-fatal information/warning messages
Date: Fri, 28 Apr 2017 19:24:29 +0900
Message-Id: <149337505971.14717.13284707508430993723.stgit@devbox>
In-Reply-To: <149337478135.14717.16640886389891283.stgit@devbox>
References: <149337478135.14717.16640886389891283.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use non_fatal() for non-fatal information or warning
messages instead of printf(). This also changes these
messages output to stderr.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/kernel/um_arch.c |   14 ++++++++------
 arch/um/kernel/umid.c    |    4 ++--
 arch/um/os-Linux/main.c  |    6 +++---
 arch/um/os-Linux/mem.c   |   24 ++++++++++++------------
 arch/um/os-Linux/umid.c  |    8 ++++----
 5 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 64a1fd0..b3b28db 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -126,6 +126,7 @@ static const char *usage_string =
 
 static int __init uml_version_setup(char *line, int *add)
 {
+	/* Version is shown when user intended to see it, not an error */
 	printf("%s\n", init_utsname()->release);
 	exit(0);
 
@@ -154,8 +155,8 @@ __uml_setup("root=", uml_root_setup,
 
 static int __init no_skas_debug_setup(char *line, int *add)
 {
-	printf("'debug' is not necessary to gdb UML in skas mode - run \n");
-	printf("'gdb linux'\n");
+	non_fatal("'debug' is not necessary to gdb UML in skas mode - run\n");
+	non_fatal("'gdb linux'\n");
 
 	return 0;
 }
@@ -169,6 +170,7 @@ static int __init Usage(char *line, int *add)
 {
 	const char **p;
 
+	/* Usage is usually shown when user intended to see it, not an error */
 	printf(usage_string, init_utsname()->release);
 	p = &__uml_help_start;
 	while (p < &__uml_help_end) {
@@ -289,8 +291,8 @@ int __init linux_main(int argc, char **argv)
 
 	diff = UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
 	if (diff > 1024 * 1024) {
-		printf("Adding %ld bytes to physical memory to account for "
-		       "exec-shield gap\n", diff);
+		non_fatal("Adding %ld bytes to physical memory to account for "
+			  "exec-shield gap\n", diff);
 		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
 	}
 
@@ -330,8 +332,8 @@ int __init linux_main(int argc, char **argv)
 	end_vm = start_vm + virtmem_size;
 
 	if (virtmem_size < physmem_size)
-		printf("Kernel virtual memory size shrunk to %lu bytes\n",
-		       virtmem_size);
+		non_fatal("Kernel virtual memory size shrunk to %lu bytes\n",
+			  virtmem_size);
 
 	os_flush_stdout();
 
diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
index f6cc3bd..0b5bc3f 100644
--- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -16,14 +16,14 @@ static int __init set_umid_arg(char *name, int *add)
 	int err;
 
 	if (umid_inited) {
-		printf("umid already set\n");
+		non_fatal("umid already set\n");
 		return 0;
 	}
 
 	*add = 0;
 	err = set_umid(name);
 	if (err == -EEXIST)
-		printf("umid '%s' already in use\n", name);
+		non_fatal("umid '%s' already in use\n", name);
 	else if (!err)
 		umid_inited = 1;
 
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 9d499de..659fee3 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -175,7 +175,7 @@ int __init main(int argc, char **argv, char **envp)
 	/* disable SIGIO for the fds and set SIGIO to be ignored */
 	err = deactivate_all_fds();
 	if (err)
-		printf("deactivate_all_fds failed, errno = %d\n", -err);
+		non_fatal("deactivate_all_fds failed, errno = %d\n", -err);
 
 	/*
 	 * Let any pending signals fire now.  This ensures
@@ -186,12 +186,12 @@ int __init main(int argc, char **argv, char **envp)
 
 	/* Reboot */
 	if (ret) {
-		printf("\n");
+		non_fatal("\n");
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret = 1;
 	}
-	printf("\n");
+	non_fatal("\n");
 	return uml_exitcode;
 }
 
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 8b17676..e4850c1 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -25,13 +25,13 @@ static int __init check_tmpfs(const char *dir)
 {
 	struct statfs st;
 
-	printf("Checking if %s is on tmpfs...", dir);
+	non_fatal("Checking if %s is on tmpfs...", dir);
 	if (statfs(dir, &st) < 0) {
-		printf("%s\n", strerror(errno));
+		non_fatal("%s\n", strerror(errno));
 	} else if (st.f_type != TMPFS_MAGIC) {
-		printf("no\n");
+		non_fatal("no\n");
 	} else {
-		printf("OK\n");
+		non_fatal("OK\n");
 		return 0;
 	}
 	return -1;
@@ -61,18 +61,18 @@ static char * __init choose_tempdir(void)
 	int i;
 	const char *dir;
 
-	printf("Checking environment variables for a tempdir...");
+	non_fatal("Checking environment variables for a tempdir...");
 	for (i = 0; vars[i]; i++) {
 		dir = getenv(vars[i]);
 		if ((dir != NULL) && (*dir != '\0')) {
-			printf("%s\n", dir);
+			non_fatal("%s\n", dir);
 			if (check_tmpfs(dir) >= 0)
 				goto done;
 			else
 				goto warn;
 		}
 	}
-	printf("none found\n");
+	non_fatal("none found\n");
 
 	for (i = 0; tmpfs_dirs[i]; i++) {
 		dir = tmpfs_dirs[i];
@@ -82,7 +82,7 @@ static char * __init choose_tempdir(void)
 
 	dir = fallback_dir;
 warn:
-	printf("Warning: tempdir %s is not on tmpfs\n", dir);
+	non_fatal("Warning: tempdir %s is not on tmpfs\n", dir);
 done:
 	/* Make a copy since getenv results may not remain valid forever. */
 	return strdup(dir);
@@ -194,16 +194,16 @@ void __init check_tmpexec(void)
 
 	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
 		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
-	printf("Checking PROT_EXEC mmap in %s...", tempdir);
+	non_fatal("Checking PROT_EXEC mmap in %s...", tempdir);
 	if (addr == MAP_FAILED) {
 		err = errno;
-		printf("%s\n", strerror(err));
+		non_fatal("%s\n", strerror(err));
 		close(fd);
 		if (err == EPERM)
-			printf("%s must be not mounted noexec\n", tempdir);
+			non_fatal("%s must be not mounted noexec\n", tempdir);
 		exit(1);
 	}
-	printf("OK\n");
+	non_fatal("OK\n");
 	munmap(addr, UM_KERN_PAGE_SIZE);
 
 	close(fd);
diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index b94a416..8974eb5 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -353,7 +353,7 @@ char *get_umid(void)
 static int __init set_uml_dir(char *name, int *add)
 {
 	if (*name == '\0') {
-		printf("uml_dir can't be an empty string\n");
+		non_fatal("uml_dir can't be an empty string\n");
 		return 0;
 	}
 
@@ -364,7 +364,7 @@ static int __init set_uml_dir(char *name, int *add)
 
 	uml_dir = malloc(strlen(name) + 2);
 	if (uml_dir == NULL) {
-		printf("Failed to malloc uml_dir - error = %d\n", errno);
+		non_fatal("Failed to malloc uml_dir - error = %d\n", errno);
 
 		/*
 		 * Return 0 here because do_initcalls doesn't look at
@@ -389,8 +389,8 @@ static void remove_umid_dir(void)
 	sprintf(dir, "%s%s", uml_dir, umid);
 	err = remove_files_and_dir(dir);
 	if (err)
-		printf("remove_umid_dir - remove_files_and_dir failed with "
-		       "err = %d\n", err);
+		non_fatal("remove_umid_dir - remove_files_and_dir failed with "
+			  "err = %d\n", err);
 }
 
 __uml_exitcall(remove_umid_dir);



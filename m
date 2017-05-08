Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH v2 5/6] um: Use os_warn to print out pre-boot warning/error messages
Date: Mon,  8 May 2017 15:21:14 +0900
Message-Id: <149422446447.11101.4945230040288593178.stgit@devbox>
In-Reply-To: <149422411127.11101.13017249012576512464.stgit@devbox>
References: <149422411127.11101.13017249012576512464.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use os_warn() instead of printf/fprintf to print out
pre-boot warning/error messages to stderr.
Note that the help message and version message are
kept to print out to stdout, because user explicitly
specifies those options to get such information.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/kernel/physmem.c    |   10 +++++-----
 arch/um/kernel/um_arch.c    |    8 +++++---
 arch/um/kernel/umid.c       |    4 ++--
 arch/um/os-Linux/execvp.c   |    2 +-
 arch/um/os-Linux/main.c     |    6 +++---
 arch/um/os-Linux/mem.c      |   10 +++++-----
 arch/um/os-Linux/start_up.c |    2 +-
 arch/um/os-Linux/umid.c     |    8 ++++----
 8 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 4c9861b..201bd43 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -89,8 +89,8 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	offset = uml_reserved - uml_physmem;
 	map_size = len - offset;
 	if(map_size <= 0) {
-		printf("Too few physical memory! Needed=%d, given=%d\n",
-		       offset, len);
+		os_warn("Too few physical memory! Needed=%d, given=%d\n",
+			offset, len);
 		exit(1);
 	}
 
@@ -99,9 +99,9 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
 			    map_size, 1, 1, 1);
 	if (err < 0) {
-		printf("setup_physmem - mapping %ld bytes of memory at 0x%p "
-		       "failed - errno = %d\n", map_size,
-		       (void *) uml_reserved, err);
+		os_warn("setup_physmem - mapping %ld bytes of memory at 0x%p "
+			"failed - errno = %d\n", map_size,
+			(void *) uml_reserved, err);
 		exit(1);
 	}
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 5df91d8..9c5d111 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -34,7 +34,7 @@ static char __initdata command_line[COMMAND_LINE_SIZE] = { 0 };
 static void __init add_arg(char *arg)
 {
 	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
-		printf("add_arg: Too many command line arguments!\n");
+		os_warn("add_arg: Too many command line arguments!\n");
 		exit(1);
 	}
 	if (strlen(command_line) > 0)
@@ -126,6 +126,7 @@ static const char *usage_string =
 
 static int __init uml_version_setup(char *line, int *add)
 {
+	/* Explicitly use printf() to show version in stdout */
 	printf("%s\n", init_utsname()->release);
 	exit(0);
 
@@ -154,8 +155,8 @@ __uml_setup("root=", uml_root_setup,
 
 static int __init no_skas_debug_setup(char *line, int *add)
 {
-	printf("'debug' is not necessary to gdb UML in skas mode - run \n");
-	printf("'gdb linux'\n");
+	os_warn("'debug' is not necessary to gdb UML in skas mode - run\n");
+	os_warn("'gdb linux'\n");
 
 	return 0;
 }
@@ -171,6 +172,7 @@ static int __init Usage(char *line, int *add)
 
 	printf(usage_string, init_utsname()->release);
 	p = &__uml_help_start;
+	/* Explicitly use printf() to show help in stdout */
 	while (p < &__uml_help_end) {
 		printf("%s", *p);
 		p++;
diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
index f6cc3bd..10bf4ac 100644
--- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -16,14 +16,14 @@ static int __init set_umid_arg(char *name, int *add)
 	int err;
 
 	if (umid_inited) {
-		printf("umid already set\n");
+		os_warn("umid already set\n");
 		return 0;
 	}
 
 	*add = 0;
 	err = set_umid(name);
 	if (err == -EEXIST)
-		printf("umid '%s' already in use\n", name);
+		os_warn("umid '%s' already in use\n", name);
 	else if (!err)
 		umid_inited = 1;
 
diff --git a/arch/um/os-Linux/execvp.c b/arch/um/os-Linux/execvp.c
index 8fb25ca..84a0777 100644
--- a/arch/um/os-Linux/execvp.c
+++ b/arch/um/os-Linux/execvp.c
@@ -136,7 +136,7 @@ int main(int argc, char**argv)
 	int ret;
 	argc--;
 	if (!argc) {
-		fprintf(stderr, "Not enough arguments\n");
+		os_warn("Not enough arguments\n");
 		return 1;
 	}
 	argv++;
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f880dcd..5f970ec 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -74,8 +74,8 @@ static void install_fatal_handler(int sig)
 	action.sa_restorer = NULL;
 	action.sa_handler = last_ditch_exit;
 	if (sigaction(sig, &action, NULL) < 0) {
-		printf("failed to install handler for signal %d - errno = %d\n",
-		       sig, errno);
+		os_warn("failed to install handler for signal %d "
+			"- errno = %d\n", sig, errno);
 		exit(1);
 	}
 }
@@ -175,7 +175,7 @@ int __init main(int argc, char **argv, char **envp)
 	/* disable SIGIO for the fds and set SIGIO to be ignored */
 	err = deactivate_all_fds();
 	if (err)
-		printf("deactivate_all_fds failed, errno = %d\n", -err);
+		os_warn("deactivate_all_fds failed, errno = %d\n", -err);
 
 	/*
 	 * Let any pending signals fire now.  This ensures
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index a7f6023..e162a95 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -82,7 +82,7 @@ static char * __init choose_tempdir(void)
 
 	dir = fallback_dir;
 warn:
-	printf("Warning: tempdir %s is not on tmpfs\n", dir);
+	os_warn("Warning: tempdir %s is not on tmpfs\n", dir);
 done:
 	/* Make a copy since getenv results may not remain valid forever. */
 	return strdup(dir);
@@ -100,7 +100,7 @@ static int __init make_tempfile(const char *template)
 	if (tempdir == NULL) {
 		tempdir = choose_tempdir();
 		if (tempdir == NULL) {
-			fprintf(stderr, "Failed to choose tempdir: %s\n",
+			os_warn("Failed to choose tempdir: %s\n",
 				strerror(errno));
 			return -1;
 		}
@@ -125,7 +125,7 @@ static int __init make_tempfile(const char *template)
 	strcat(tempname, template);
 	fd = mkstemp(tempname);
 	if (fd < 0) {
-		fprintf(stderr, "open - cannot create %s: %s\n", tempname,
+		os_warn("open - cannot create %s: %s\n", tempname,
 			strerror(errno));
 		goto out;
 	}
@@ -197,10 +197,10 @@ void __init check_tmpexec(void)
 	os_info("Checking PROT_EXEC mmap in %s...", tempdir);
 	if (addr == MAP_FAILED) {
 		err = errno;
-		printf("%s\n", strerror(err));
+		os_warn("%s\n", strerror(err));
 		close(fd);
 		if (err == EPERM)
-			printf("%s must be not mounted noexec\n", tempdir);
+			os_warn("%s must be not mounted noexec\n", tempdir);
 		exit(1);
 	}
 	os_info("OK\n");
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 5a61a93..a044d3e 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -351,7 +351,7 @@ int __init parse_iomem(char *str, int *add)
 	driver = str;
 	file = strchr(str,',');
 	if (file == NULL) {
-		fprintf(stderr, "parse_iomem : failed to parse iomem\n");
+		os_warn("parse_iomem : failed to parse iomem\n");
 		goto out;
 	}
 	*file = '\0';
diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 37cfaba..998fbb4 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -354,7 +354,7 @@ char *get_umid(void)
 static int __init set_uml_dir(char *name, int *add)
 {
 	if (*name == '\0') {
-		printf("uml_dir can't be an empty string\n");
+		os_warn("uml_dir can't be an empty string\n");
 		return 0;
 	}
 
@@ -365,7 +365,7 @@ static int __init set_uml_dir(char *name, int *add)
 
 	uml_dir = malloc(strlen(name) + 2);
 	if (uml_dir == NULL) {
-		printf("Failed to malloc uml_dir - error = %d\n", errno);
+		os_warn("Failed to malloc uml_dir - error = %d\n", errno);
 
 		/*
 		 * Return 0 here because do_initcalls doesn't look at
@@ -390,8 +390,8 @@ static void remove_umid_dir(void)
 	sprintf(dir, "%s%s", uml_dir, umid);
 	err = remove_files_and_dir(dir);
 	if (err)
-		printf("remove_umid_dir - remove_files_and_dir failed with "
-		       "err = %d\n", err);
+		os_warn("%s - remove_files_and_dir failed with err = %d\n",
+			__func__, err);
 }
 
 __uml_exitcall(remove_umid_dir);



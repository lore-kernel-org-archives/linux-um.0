Return-Path: <brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 2/4] um: remove uses of variable length arrays
Date: Thu, 11 Apr 2019 11:49:42 +0200
Message-Id: <20190411094944.12245-3-brgl@bgdev.pl>
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-ID: <linux-um.lists.infradead.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While the affected code is run in user-mode, the build still warns
about it. Convert all uses of VLA to dynamic allocations.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/um/os-Linux/umid.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 998fbb445458..e261656fe9d7 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -135,12 +135,18 @@ static int remove_files_and_dir(char *dir)
  */
 static inline int is_umdir_used(char *dir)
 {
-	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
-	char pid[sizeof("nnnnn\0")], *end;
+	char pid[sizeof("nnnnn\0")], *end, *file;
 	int dead, fd, p, n, err;
+	size_t filelen;
 
-	n = snprintf(file, sizeof(file), "%s/pid", dir);
-	if (n >= sizeof(file)) {
+	err = asprintf(&file, "%s/pid", dir);
+	if (err < 0)
+		return 0;
+
+	filelen = strlen(file);
+
+	n = snprintf(file, filelen, "%s/pid", dir);
+	if (n >= filelen) {
 		printk(UM_KERN_ERR "is_umdir_used - pid filename too long\n");
 		err = -E2BIG;
 		goto out;
@@ -185,6 +191,7 @@ static inline int is_umdir_used(char *dir)
 out_close:
 	close(fd);
 out:
+	free(file);
 	return 0;
 }
 
@@ -210,18 +217,21 @@ static int umdir_take_if_dead(char *dir)
 
 static void __init create_pid_file(void)
 {
-	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
-	char pid[sizeof("nnnnn\0")];
+	char pid[sizeof("nnnnn\0")], *file;
 	int fd, n;
 
-	if (umid_file_name("pid", file, sizeof(file)))
+	file = malloc(strlen(uml_dir) + UMID_LEN + sizeof("/pid\0"));
+	if (!file)
 		return;
 
+	if (umid_file_name("pid", file, sizeof(file)))
+		goto out;
+
 	fd = open(file, O_RDWR | O_CREAT | O_EXCL, 0644);
 	if (fd < 0) {
 		printk(UM_KERN_ERR "Open of machine pid file \"%s\" failed: "
 		       "%s\n", file, strerror(errno));
-		return;
+		goto out;
 	}
 
 	snprintf(pid, sizeof(pid), "%d\n", getpid());
@@ -231,6 +241,8 @@ static void __init create_pid_file(void)
 		       errno);
 
 	close(fd);
+out:
+	free(file);
 }
 
 int __init set_umid(char *name)
@@ -385,13 +397,19 @@ __uml_setup("uml_dir=", set_uml_dir,
 
 static void remove_umid_dir(void)
 {
-	char dir[strlen(uml_dir) + UMID_LEN + 1], err;
+	char *dir, err;
+
+	dir = malloc(strlen(uml_dir) + UMID_LEN + 1);
+	if (!dir)
+		return;
 
 	sprintf(dir, "%s%s", uml_dir, umid);
 	err = remove_files_and_dir(dir);
 	if (err)
 		os_warn("%s - remove_files_and_dir failed with err = %d\n",
 			__func__, err);
+
+	free(dir);
 }
 
 __uml_exitcall(remove_umid_dir);
-- 
2.21.0



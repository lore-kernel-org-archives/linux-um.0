Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaF9d-00016f-66 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 09:52:17 -0700
Received: from host2-39.pool8261.interbusiness.it ([82.61.39.2]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FaF9c-0004Oy-Fr for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 09:52:17 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060430153634.27676.89350.stgit@zion.home.lan>
In-Reply-To: <20060430153326.27676.64906.stgit@zion.home.lan>
References: <20060430153326.27676.64906.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 1/2] uml: fix not_dead_yet when directory is in
	bad state
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 30 Apr 2006 17:36:35 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The bug occurred to me when a UML left an empty ~/.uml/Sarge-norm folder - when
trying to reuse not_dead_yet() failed one of its check. The comment says that's
ok and means that we can take the directory, but while normally not_dead_yet()
removes it and returns 0 (i.e. go on, use this), on failure it returns 0 but
forgets to remove it.
The fix is to remove it anytime we're going to return 0.

But since "not_dead_yet" didn't make the interface so clear, causing this bug,
and I couldn't find a convenient name for the mix of things it did, I split it
into two parts:

is_umdir_used()      -	returns a boolean, contains all checks of not_dead_yet()
umdir_take_if_dead   -	tries to remove the dir unless it's used - returns
			whether it removed it, that is we now own it.

With this changes the control flow is IMHO a bit clearer and needs less comment
for control flow.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/umid.c |   48 ++++++++++++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 34bfc1b..7c53be1 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -103,9 +103,10 @@ static int actually_do_remove(char *dir)
  * 	something other than UML sticking stuff in the directory
  *	this boot racing with a shutdown of the other UML
  * In any of these cases, the directory isn't useful for anything else.
+ *
+ * Boolean return: 1 if in use, 0 otherwise.
  */
-
-static int not_dead_yet(char *dir)
+static inline int is_umdir_used(char *dir)
 {
 	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
 	char pid[sizeof("nnnnn\0")], *end;
@@ -113,7 +114,7 @@ static int not_dead_yet(char *dir)
 
 	n = snprintf(file, sizeof(file), "%s/pid", dir);
 	if(n >= sizeof(file)){
-		printk("not_dead_yet - pid filename too long\n");
+		printk("is_umdir_used - pid filename too long\n");
 		err = -E2BIG;
 		goto out;
 	}
@@ -123,7 +124,7 @@ static int not_dead_yet(char *dir)
 	if(fd < 0) {
 		fd = -errno;
 		if(fd != -ENOENT){
-			printk("not_dead_yet : couldn't open pid file '%s', "
+			printk("is_umdir_used : couldn't open pid file '%s', "
 			       "err = %d\n", file, -fd);
 		}
 		goto out;
@@ -132,18 +133,18 @@ static int not_dead_yet(char *dir)
 	err = 0;
 	n = read(fd, pid, sizeof(pid));
 	if(n < 0){
-		printk("not_dead_yet : couldn't read pid file '%s', "
+		printk("is_umdir_used : couldn't read pid file '%s', "
 		       "err = %d\n", file, errno);
 		goto out_close;
 	} else if(n == 0){
-		printk("not_dead_yet : couldn't read pid file '%s', "
+		printk("is_umdir_used : couldn't read pid file '%s', "
 		       "0-byte read\n", file);
 		goto out_close;
 	}
 
 	p = strtoul(pid, &end, 0);
 	if(end == pid){
-		printk("not_dead_yet : couldn't parse pid file '%s', "
+		printk("is_umdir_used : couldn't parse pid file '%s', "
 		       "errno = %d\n", file, errno);
 		goto out_close;
 	}
@@ -153,19 +154,32 @@ static int not_dead_yet(char *dir)
 		return 1;
 	}
 
-	err = actually_do_remove(dir);
-	if(err)
-		printk("not_dead_yet - actually_do_remove failed with "
-		       "err = %d\n", err);
-
-	return err;
-
 out_close:
 	close(fd);
 out:
 	return 0;
 }
 
+/*
+ * Try to remove the directory @dir unless it's in use.
+ * Precondition: @dir exists.
+ * Returns 0 for success, < 0 for failure in removal or if the directory is in
+ * use.
+ */
+static int umdir_take_if_dead(char *dir)
+{
+	int ret;
+	if (is_umdir_used(dir))
+		return -EEXIST;
+
+	ret = actually_do_remove(dir);
+	if (ret) {
+		printk("is_umdir_used - actually_do_remove failed with "
+		       "err = %d\n", ret);
+	}
+	return ret;
+}
+
 static void __init create_pid_file(void)
 {
 	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
@@ -244,11 +258,7 @@ int __init make_umid(void)
 		if(err != -EEXIST)
 			goto err;
 
-		/* 1   -> this umid is already in use
-		 * < 0 -> we couldn't remove the umid directory
-		 * In either case, we can't use this umid, so return -EEXIST.
-		 */
-		if(not_dead_yet(tmp) != 0)
+		if(umdir_take_if_dead(tmp) < 0)
 			goto err;
 
 		err = mkdir(tmp, 0777);


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

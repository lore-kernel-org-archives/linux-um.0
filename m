Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jgi79-0004S3-Am for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Apr 2008 08:09:31 -0700
Received: from qb-out-0506.google.com ([72.14.204.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jgi76-00011E-Hf
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Apr 2008 08:09:28 -0700
Received: by qb-out-0506.google.com with SMTP id c8so595001qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 01 Apr 2008 08:09:27 -0700 (PDT)
Date: Tue, 01 Apr 2008 23:06:41 +0800 (CST)
Message-Id: <20080401.230641.146239754.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] arch/um/os-Linux/main.c: Fix memory leaks.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


This patch fixes possible memory leaks in the main() function of
arch/um/os-Linux/main.c.

Cc: jdike@addtoit.com
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---

Index: linux-2.6/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.orig/arch/um/os-Linux/main.c
+++ linux-2.6/arch/um/os-Linux/main.c
@@ -113,14 +113,10 @@ static void setup_env_path(void)
 
 extern void scan_elf_aux( char **envp);
 
-int __init main(int argc, char **argv, char **envp)
+static char** dup_argv(int argc, char **argv)
 {
+	int i;
 	char **new_argv;
-	int ret, i, err;
-
-	set_stklim();
-
-	setup_env_path();
 
 	new_argv = malloc((argc + 1) * sizeof(char *));
 	if (new_argv == NULL) {
@@ -135,6 +131,28 @@ int __init main(int argc, char **argv, c
 		}
 	}
 	new_argv[argc] = NULL;
+	return new_argv;
+}
+
+static void free_argv(int argc, char **argv)
+{
+	int i;
+	for (i = 0; i < argc; i++) {
+		free(argv[i]);
+	}
+	free(argv);
+}
+
+int __init main(int argc, char **argv, char **envp)
+{
+	char **new_argv;
+	int ret, i, err;
+
+	set_stklim();
+
+	setup_env_path();
+
+	new_argv = dup_argv(argc, argv);
 
 	/*
 	 * Allow these signals to bring down a UML if all other
@@ -185,6 +203,7 @@ int __init main(int argc, char **argv, c
 		perror("Failed to exec kernel");
 		ret = 1;
 	}
+	free_argv(argc, new_argv);
 	printf("\n");
 	return uml_exitcode;
 }

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

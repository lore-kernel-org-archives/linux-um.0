Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JQ1I7-0003vp-OS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 06:11:51 -0800
Received: from ag-out-0708.google.com ([72.14.246.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JQ1I7-0005Vj-8N
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 06:11:51 -0800
Received: by ag-out-0708.google.com with SMTP id 35so18518949aga.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Feb 2008 06:11:50 -0800 (PST)
Date: Fri, 15 Feb 2008 22:07:42 +0800 (CST)
Message-Id: <20080215.220742.106815696.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: [uml-devel] [Patch] arch/um/kernel/um_arch.c: some small improvements
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, dike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


Make some small improvements for arch/um/kernel/um_arch.c.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>

---
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a6c1dd1..56deed6 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -115,7 +115,7 @@ static int have_root __initdata = 0;
 /* Set in uml_mem_setup and modified in linux_main */
 long long physmem_size = 32 * 1024 * 1024;
 
-static char *usage_string =
+static const char *usage_string =
 "User Mode Linux v%s\n"
 "	available at http://user-mode-linux.sourceforge.net/\n\n";
 
@@ -202,7 +202,7 @@ static void __init uml_checksetup(char *line, int *add)
 
 	p = &__uml_setup_start;
 	while (p < &__uml_setup_end) {
-		int n;
+		size_t n;
 
 		n = strlen(p->str);
 		if (!strncmp(line, p->str, n) && p->setup_func(line + n, add))
@@ -258,7 +258,8 @@ int __init linux_main(int argc, char **argv)
 {
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
-	unsigned int i, add;
+	unsigned int i;
+	int add;
 	char * mode;
 
 	for (i = 1; i < argc; i++) {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AegN1-00029W-0Q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 12:03:07 -0800
Received: from thebsh.namesys.com ([212.16.7.65])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AegN0-0000S8-B9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jan 2004 12:03:06 -0800
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16381.46954.397526.967308@laputa.namesys.com>
Subject: [uml-devel] [PATCH]: fix UML compilation breakage in
	fs/proc/task_mmu.c
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
Date: Thu, 8 Jan 2004 23:02:50 +0300
To: Jeff Dike <JDike@Karaya.COM>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <AKPM@Osdl.ORG>

Hello,

recent change that adds fixmaps to the /proc/<pid>/maps broke
compilation on the UML, because there FIXADDR_USER_{START,END} are not
constant.

This patch adds a function to initialize &gate_vmarea.

Nikita.
diff -puN fs/proc/task_mmu.c~uml-FIXADDR_USER_START-not-const fs/proc/task_mmu.c
--- lobby/fs/proc/task_mmu.c~uml-FIXADDR_USER_START-not-const	Thu Jan  8 20:56:36 2004
+++ lobby-nikita/fs/proc/task_mmu.c	Thu Jan  8 20:56:36 2004
@@ -79,17 +79,27 @@ int task_statm(struct mm_struct *mm, int
 #ifdef AT_SYSINFO_EHDR
 
 static struct vm_area_struct gate_vmarea = {
-	/* Do _not_ mark this area as readable, cuz not the entire range may be readable
-	   (e.g., due to execute-only pages or holes) and the tools that read
-	   /proc/PID/maps should read the interesting bits from the gate-DSO file
-	   instead.  */
-	.vm_start = FIXADDR_USER_START,
-	.vm_end = FIXADDR_USER_END
+	/*
+	 * we cannot initialize fields right here, because on some
+	 * architectures (on UML to be precise), FIXADDR_USER_* are not
+	 * constant. See build_gate_map() below.
+	 */
 };
 
 # define gate_map()	&gate_vmarea
+static inline struct vm_area_struct *build_gate_map(void)
+{
+	/* Do _not_ mark this area as readable, cuz not the entire range may
+	   be readable (e.g., due to execute-only pages or holes) and the
+	   tools that read /proc/PID/maps should read the interesting bits
+	   from the gate-DSO file instead.  */
+	gate_vmarea.vm_start = FIXADDR_USER_START;
+	gate_vmarea.vm_end   = FIXADDR_USER_END;
+	return &gate_vmarea;
+}
 #else
 # define gate_map()	NULL
+# define build_gate_map()	NULL
 #endif
 
 static int show_map(struct seq_file *m, void *v)
@@ -146,7 +156,7 @@ static void *m_start(struct seq_file *m,
 		up_read(&mm->mmap_sem);
 		mmput(mm);
 		if (l == -1)
-			map = gate_map();
+			map = build_gate_map();
 	}
 	return map;
 }

_



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

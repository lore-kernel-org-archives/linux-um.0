Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AewUm-0008Ex-OK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:16:12 -0800
Received: from thebsh.namesys.com ([212.16.7.65])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AewUm-0004cS-0P for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:16:12 -0800
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16382.43409.661706.120605@laputa.namesys.com>
In-Reply-To: <16381.46954.397526.967308@laputa.namesys.com>
References: <16381.46954.397526.967308@laputa.namesys.com>
Subject: [uml-devel] Re: [PATCH]: fix UML compilation breakage in
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
Date: Fri, 9 Jan 2004 16:16:01 +0300
To: Andrew Morton <AKPM@Osdl.ORG>
Cc: Jeff Dike <JDike@Karaya.COM>, user-mode-linux-devel@lists.sourceforge.net

Hopefully correct version this time. In previous version it was possible
to call ->show() on non-initialized gate_vmarea (through m_next()). Just
call build_gate_map() at the beginning of the m_start().

At least now it works:

$ cat /proc/self/maps | tail -1
ffffe000-fffff000 ---p 00000000 00:00 0 

I am not sure that this is best solution, because some utilities seems
to use /proc/*/maps extensively. Probably initialization should be moved
into initcall.

Nikita.
diff -puN fs/proc/task_mmu.c~uml-FIXADDR_USER_START-not-const fs/proc/task_mmu.c
--- limbo/fs/proc/task_mmu.c~uml-FIXADDR_USER_START-not-const	Fri Jan  9 16:05:37 2004
+++ limbo-god/fs/proc/task_mmu.c	Fri Jan  9 16:06:39 2004
@@ -79,17 +79,26 @@ int task_statm(struct mm_struct *mm, int
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
+static inline void build_gate_map(void)
+{
+	/* Do _not_ mark this area as readable, cuz not the entire range may
+	   be readable (e.g., due to execute-only pages or holes) and the
+	   tools that read /proc/PID/maps should read the interesting bits
+	   from the gate-DSO file instead.  */
+	gate_vmarea.vm_start = FIXADDR_USER_START;
+	gate_vmarea.vm_end   = FIXADDR_USER_END;
+}
 #else
 # define gate_map()	NULL
+# define build_gate_map()
 #endif
 
 static int show_map(struct seq_file *m, void *v)
@@ -138,6 +147,8 @@ static void *m_start(struct seq_file *m,
 	if (!mm)
 		return NULL;
 
+	build_gate_map();
+
 	down_read(&mm->mmap_sem);
 	map = mm->mmap;
 	while (l-- && map)

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

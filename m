Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFEyz-0001FN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 07:45:09 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AFEyz-00082j-5u
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 30 Oct 2003 07:45:09 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031030155757.GA19575@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] restore do_mmap_pgoff() semantics
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 30 Oct 2003 16:57:57 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

This patch makes do_mmap_pgoff behave as usual and intruduces a
new __do_mmap_pgoff function with the additional struct mm_struct
argument for the callers which need it.

Point of doing that is to allow a kernel tree with uml patch applied
still build non-uml kernels.

  Gerd

diff -u linux-2.6.0-test3/arch/um/kernel/syscall_kern.c linux/arch/um/kernel/syscall_kern.c
--- linux-2.6.0-test3/arch/um/kernel/syscall_kern.c	2003-08-22 09:41:46.000000000 +0000
+++ linux/arch/um/kernel/syscall_kern.c	2003-08-22 09:42:05.000000000 +0000
@@ -81,7 +81,7 @@
 	}
 
 	down_write(&mm->mmap_sem);
-	error = do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
+	error = __do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
 	up_write(&mm->mmap_sem);
 
 	if (file)
diff -u linux-2.6.0-test3/include/linux/mm.h linux/include/linux/mm.h
--- linux-2.6.0-test3/include/linux/mm.h	2003-08-22 08:36:13.000000000 +0000
+++ linux/include/linux/mm.h	2003-08-22 09:40:09.000000000 +0000
@@ -516,10 +516,18 @@
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
-extern unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file *file, 
-				   unsigned long addr, unsigned long len,
-				   unsigned long prot, unsigned long flag,
-				   unsigned long pgoff);
+extern unsigned long __do_mmap_pgoff(struct mm_struct *mm,
+	struct file *file, unsigned long addr,
+	unsigned long len, unsigned long prot,
+	unsigned long flag, unsigned long pgoff);
+
+static inline unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
+	unsigned long len, unsigned long prot,
+	unsigned long flag, unsigned long pgoff)
+{
+	return __do_mmap_pgoff(current->mm, file, addr, len,
+		               prot, flag, pgoff);
+}
 
 static inline unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
@@ -529,8 +537,7 @@
 	if ((offset + PAGE_ALIGN(len)) < offset)
 		goto out;
 	if (!(offset & ~PAGE_MASK))
-		ret = do_mmap_pgoff(current->mm, file, addr, len, prot, flag, 
-				    offset >> PAGE_SHIFT);
+		ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
 out:
 	return ret;
 }
diff -u linux-2.6.0-test3/mm/mmap.c linux/mm/mmap.c
--- linux-2.6.0-test3/mm/mmap.c	2003-08-22 09:52:40.000000000 +0000
+++ linux/mm/mmap.c	2003-08-22 09:52:48.000000000 +0000
@@ -457,7 +457,7 @@
  * The caller must hold down_write(current->mm->mmap_sem).
  */
 
-unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file * file, 
+unsigned long __do_mmap_pgoff(struct mm_struct *mm, struct file * file, 
 			    unsigned long addr, unsigned long len,
 			    unsigned long prot, unsigned long flags,
 			    unsigned long pgoff)


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

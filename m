Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x4yC-0004a3-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 06:25:16 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19x4yB-0005CX-LC
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 06:25:16 -0700
References: <1063194344.5333.6.camel@tyan.crapulence.org>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <1063194344.5333.6.camel@tyan.crapulence.org>
Message-ID: <87ekyo92zn.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: uml-patch-2.6.0-test5
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
Date: 10 Sep 2003 15:39:40 +0200
To: Paul Giordano <giordano@covad.net>, user-mode-linux-devel@lists.sourceforge.net

Paul Giordano <giordano@covad.net> writes:

> Seems all the do_mmap_pgoff's will fail with the change made in
> mmap.c.While I understand the change is to enable compilation of a uml
> kernel, it really shouldn't break the normal compiles as well, should
> it?

Patch below should fix that.  At least it did for the -test3 patch :)

  Gerd

==============================[ cut here ]==============================
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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

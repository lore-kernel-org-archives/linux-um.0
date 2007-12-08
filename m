Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J10Wq-0008H1-Tj for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 06:19:41 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J10Wq-0004xL-BI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 06:19:40 -0800
Date: Sat, 8 Dec 2007 09:19:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071208141934.GB4667@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] Diff against old 2.6.23 SKAS3
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, greg@enjellic.com

And for anyone who's interested, below are the changes which I made to
the original skas patch.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6-host/include/linux/mm.h
===================================================================
--- linux-2.6-host.orig/include/linux/mm.h	2007-12-07 00:37:20.000000000 -0500
+++ linux-2.6-host/include/linux/mm.h	2007-12-07 22:53:15.000000000 -0500
@@ -1077,8 +1077,8 @@ static inline unsigned long do_mmap_pgof
 	return __do_mmap_pgoff(current->mm, file, addr, len, prot, flag, pgoff);
 }
 
-extern unsigned long mmap_region(struct file *file, unsigned long addr,
-	unsigned long len, unsigned long flags,
+extern unsigned long mmap_region(struct mm_struct *mm, struct file *file,
+	unsigned long addr, unsigned long len, unsigned long flags,
 	unsigned int vm_flags, unsigned long pgoff,
 	int accountable);
 
Index: linux-2.6-host/mm/fremap.c
===================================================================
--- linux-2.6-host.orig/mm/fremap.c	2007-12-07 00:36:08.000000000 -0500
+++ linux-2.6-host/mm/fremap.c	2007-12-07 22:54:54.000000000 -0500
@@ -190,8 +190,9 @@ asmlinkage long sys_remap_file_pages(uns
 			unsigned long addr;
 
 			flags &= MAP_NONBLOCK;
-			addr = mmap_region(vma->vm_file, start, size,
-					flags, vma->vm_flags, pgoff, 1);
+			addr = mmap_region(current->mm, vma->vm_file, start,
+					   size, flags, vma->vm_flags, pgoff,
+					   1);
 			if (IS_ERR_VALUE(addr)) {
 				err = addr;
 			} else {
Index: linux-2.6-host/mm/mmap.c
===================================================================
--- linux-2.6-host.orig/mm/mmap.c	2007-12-07 00:37:20.000000000 -0500
+++ linux-2.6-host/mm/mmap.c	2007-12-07 22:55:26.000000000 -0500
@@ -1023,7 +1023,7 @@ unsigned long __do_mmap_pgoff(struct mm_
 	if (error)
 		return error;
 
-	return mmap_region(file, addr, len, flags, vm_flags, pgoff,
+	return mmap_region(mm, file, addr, len, flags, vm_flags, pgoff,
 			   accountable);
 }
 EXPORT_SYMBOL(__do_mmap_pgoff);
@@ -1062,12 +1062,12 @@ int vma_wants_writenotify(struct vm_area
 }
 
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+unsigned long mmap_region(struct mm_struct *mm,
+			  struct file *file, unsigned long addr,
 			  unsigned long len, unsigned long flags,
 			  unsigned int vm_flags, unsigned long pgoff,
 			  int accountable)
 {
-	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
 	int correct_wcount = 0;
 	int error;
Index: linux-2.6-host/mm/proc_mm.c
===================================================================
--- linux-2.6-host.orig/mm/proc_mm.c	2007-12-07 16:21:06.000000000 -0500
+++ linux-2.6-host/mm/proc_mm.c	2007-12-07 16:22:07.000000000 -0500
@@ -209,7 +209,7 @@ struct mm_struct *proc_mm_get_mm(int fd)
 		goto out;
 
 	ret = ERR_PTR(-EINVAL);
-	if(file->f_op != &proc_mm_fops)
+	if(PDE(file->f_path.dentry->d_inode)->proc_fops != &proc_mm_fops)
 		goto out_fput;
 
 	ret = file->private_data;

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

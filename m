Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6XH9-0005VB-Fe for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 09:04:43 -0800
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6XH5-0003Be-5s for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 09:04:43 -0800
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id MAA25467
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 2 Mar 2005 12:04:56 -0500 (EST)
Message-ID: <4225F1EB.9010503@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML 2.4 shmem.c changes? panic w/ backtrace
References: <41A35EF5.4080302@enterasys.com>
	<200502281944.j1SJiHMY003270@ccure.user-mode-linux.org>
	<200503021507.21524.blaisorblade@yahoo.it>
	<200503021801.28494.blaisorblade@yahoo.it>
In-Reply-To: <200503021801.28494.blaisorblade@yahoo.it>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig067D73710CEBEA04A568DC38"
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
Date: Wed, 02 Mar 2005 12:03:39 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig067D73710CEBEA04A568DC38
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

wow! thank you Blaisor. will apply and let you know.
still working on an isolated shmem program that will
reproduce this....

Blaisorblade wrote:

>On Wednesday 02 March 2005 15:07, Blaisorblade wrote:
>
>
>>On Monday 28 February 2005 20:44, Jeff Dike wrote:
>>
>>
>>>dbahi@enterasys.com said:
>>>
>>>
>>>>This happens everytime i try to load an application of ours that uses
>>>>shmem for syslog...
>>>>
>>>>
>>>I persist in seeing no particular UML involvement with this crash :-)
>>>
>>>Can you boil your app down to a test case which reproduces this?
>>>
>>>
>>Jeff, since the UML changes to the shmem.c code are currently unused, just
>>to make sure, can you remove them from the patch, so that we can make sure?
>>They are, actually, the devanon patch.
>>
>>
>
>Ok, D.Bahi, I found that I already prepared a patch to do this work. It also
>removes SKAS support for inner UML, btw, which is untested and probably would
>need some fixes. Apply the patch, and tell us the result.
>
>
>------------------------------------------------------------------------
>
>
>
>Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
>---
>
> um-linux-2.4.27-paolo/arch/um/config.in        |    1
> um-linux-2.4.27-paolo/arch/um/defconfig        |    1
> um-linux-2.4.27-paolo/arch/um/kernel/ptrace.c  |   54 -------
> um-linux-2.4.27-paolo/drivers/char/mem.c       |    8 -
> um-linux-2.4.27-paolo/include/linux/fs.h       |    2
> um-linux-2.4.27-paolo/include/linux/mm.h       |   13 -
> um-linux-2.4.27-paolo/include/linux/shmem_fs.h |    2
> um-linux-2.4.27-paolo/mm/Makefile              |    1
> um-linux-2.4.27-paolo/mm/mmap.c                |   12 -
> um-linux-2.4.27-paolo/mm/mprotect.c            |   14 --
> um-linux-2.4.27-paolo/mm/shmem.c               |  149 ---------------------
> um-linux-2.4.27/mm/proc_mm.c                   |  173 -------------------------
> 12 files changed, 18 insertions(+), 412 deletions(-)
>
>diff -puN drivers/char/mem.c~remove-devanon-skas drivers/char/mem.c
>--- um-linux-2.4.27/drivers/char/mem.c~remove-devanon-skas	2004-11-25 12:57:47.000000000 +0100
>+++ um-linux-2.4.27-paolo/drivers/char/mem.c	2004-11-25 12:57:47.000000000 +0100
>@@ -666,8 +666,6 @@ static struct file_operations full_fops
> 	write:		write_full,
> };
>
>-extern struct file_operations anon_file_operations;
>-
> static int memory_open(struct inode * inode, struct file * filp)
> {
> 	switch (MINOR(inode->i_rdev)) {
>@@ -697,9 +695,6 @@ static int memory_open(struct inode * in
> 		case 9:
> 			filp->f_op = &urandom_fops;
> 			break;
>-		case 10:
>-		        filp->f_op = &anon_file_operations;
>-			break;
> 		default:
> 			return -ENXIO;
> 	}
>@@ -726,8 +721,7 @@ void __init memory_devfs_register (void)
> 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},
> 	{7, "full",    S_IRUGO | S_IWUGO,           &full_fops},
> 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
>-	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
>-	{10, "anon", S_IRUGO | S_IWUSR,             &anon_file_operations},
>+	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops}
>     };
>     int i;
>
>diff -puN include/linux/fs.h~remove-devanon-skas include/linux/fs.h
>--- um-linux-2.4.27/include/linux/fs.h~remove-devanon-skas	2004-11-25 12:57:47.000000000 +0100
>+++ um-linux-2.4.27-paolo/include/linux/fs.h	2004-11-25 12:57:47.772483688 +0100
>@@ -870,8 +870,6 @@ struct file_operations {
> 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
> 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
> 	int (*mmap) (struct file *, struct vm_area_struct *);
>-	void (*munmap) (struct file *, struct vm_area_struct *,
>-			unsigned long start, unsigned long len);
> 	int (*open) (struct inode *, struct file *);
> 	int (*flush) (struct file *);
> 	int (*release) (struct inode *, struct file *);
>diff -puN include/linux/shmem_fs.h~remove-devanon-skas include/linux/shmem_fs.h
>--- um-linux-2.4.27/include/linux/shmem_fs.h~remove-devanon-skas	2004-11-25 12:57:47.000000000 +0100
>+++ um-linux-2.4.27-paolo/include/linux/shmem_fs.h	2004-11-25 12:57:47.772483688 +0100
>@@ -22,8 +22,6 @@ struct shmem_inode_info {
> 	unsigned long		next_index;
> 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
> 	void		      **i_indirect; /* indirect blocks */
>-	unsigned long		map_direct[SHMEM_NR_DIRECT];
>-	void 		      **map_indirect;
> 	unsigned long		swapped;    /* data pages assigned to swap */
> 	unsigned long		flags;
> 	struct list_head	list;
>diff -puN mm/Makefile~remove-devanon-skas mm/Makefile
>--- um-linux-2.4.27/mm/Makefile~remove-devanon-skas	2004-11-25 12:57:47.000000000 +0100
>+++ um-linux-2.4.27-paolo/mm/Makefile	2004-11-25 12:57:47.000000000 +0100
>@@ -17,6 +17,5 @@ obj-y	 := memory.o mmap.o filemap.o mpro
> 	    shmem.o
>
> obj-$(CONFIG_HIGHMEM) += highmem.o
>-obj-$(CONFIG_PROC_MM) += proc_mm.o
>
> include $(TOPDIR)/Rules.make
>diff -puN mm/mmap.c~remove-devanon-skas mm/mmap.c
>--- um-linux-2.4.27/mm/mmap.c~remove-devanon-skas	2004-11-25 12:57:47.000000000 +0100
>+++ um-linux-2.4.27-paolo/mm/mmap.c	2004-11-25 12:57:47.000000000 +0100
>@@ -391,11 +391,10 @@ static int vma_merge(struct mm_struct *
> 	return 0;
> }
>
>-unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file * file,
>-			    unsigned long addr, unsigned long len,
>-			    unsigned long prot, unsigned long flags,
>-			    unsigned long pgoff)
>+unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
>+	unsigned long prot, unsigned long flags, unsigned long pgoff)
> {
>+	struct mm_struct * mm = current->mm;
> 	struct vm_area_struct * vma, * prev;
> 	unsigned int vm_flags;
> 	int correct_wcount = 0;
>@@ -1001,11 +1000,6 @@ int do_munmap(struct mm_struct *mm, unsi
> 		remove_shared_vm_struct(mpnt);
> 		mm->map_count--;
>
>-		if((mpnt->vm_file != NULL) && (mpnt->vm_file->f_op != NULL) &&
>-		   (mpnt->vm_file->f_op->munmap != NULL))
>-		        mpnt->vm_file->f_op->munmap(mpnt->vm_file, mpnt, st,
>-						    size);
>-
> 		zap_page_range(mm, st, size);
>
> 		/*
>diff -puN mm/mprotect.c~remove-devanon-skas mm/mprotect.c
>--- um-linux-2.4.27/mm/mprotect.c~remove-devanon-skas	2004-11-25 12:57:47.000000000 +0100
>+++ um-linux-2.4.27-paolo/mm/mprotect.c	2004-11-25 12:57:47.000000000 +0100
>@@ -264,8 +264,7 @@ static int mprotect_fixup(struct vm_area
> 	return 0;
> }
>
>-long do_mprotect(struct mm_struct *mm, unsigned long start, size_t len,
>-		 unsigned long prot)
>+asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
> {
> 	unsigned long nstart, end, tmp;
> 	struct vm_area_struct * vma, * next, * prev;
>@@ -282,9 +281,9 @@ long do_mprotect(struct mm_struct *mm, u
> 	if (end == start)
> 		return 0;
>
>-	down_write(&mm->mmap_sem);
>+	down_write(&current->mm->mmap_sem);
>
>-	vma = find_vma_prev(mm, start, &prev);
>+	vma = find_vma_prev(current->mm, start, &prev);
> 	error = -ENOMEM;
> 	if (!vma || vma->vm_start > start)
> 		goto out;
>@@ -333,11 +332,6 @@ long do_mprotect(struct mm_struct *mm, u
> 		prev->vm_mm->map_count--;
> 	}
> out:
>-	up_write(&mm->mmap_sem);
>+	up_write(&current->mm->mmap_sem);
> 	return error;
> }
>-
>-asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
>-{
>-        return(do_mprotect(current->mm, start, len, prot));
>-}
>diff -L mm/proc_mm.c -puN mm/proc_mm.c~remove-devanon-skas /dev/null
>--- um-linux-2.4.27/mm/proc_mm.c
>+++ /dev/null	2004-06-25 17:47:25.000000000 +0200
>@@ -1,173 +0,0 @@
>-/*
>- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
>- * Licensed under the GPL
>- */
>-
>-#include "linux/init.h"
>-#include "linux/proc_fs.h"
>-#include "linux/proc_mm.h"
>-#include "linux/file.h"
>-#include "asm/uaccess.h"
>-#include "asm/mmu_context.h"
>-
>-static struct file_operations proc_mm_fops;
>-
>-struct mm_struct *proc_mm_get_mm(int fd)
>-{
>-	struct mm_struct *ret = ERR_PTR(-EBADF);
>-	struct file *file;
>-
>-	file = fget(fd);
>-	if (!file)
>-		goto out;
>-
>-	ret = ERR_PTR(-EINVAL);
>-	if(file->f_op != &proc_mm_fops)
>-		goto out_fput;
>-
>-	ret = file->private_data;
>- out_fput:
>-	fput(file);
>- out:
>-	return(ret);
>-}
>-
>-extern long do_mmap2(struct mm_struct *mm, unsigned long addr,
>-		     unsigned long len, unsigned long prot,
>-		     unsigned long flags, unsigned long fd,
>-		     unsigned long pgoff);
>-
>-static ssize_t write_proc_mm(struct file *file, const char *buffer,
>-			     size_t count, loff_t *ppos)
>-{
>-	struct mm_struct *mm = file->private_data;
>-	struct proc_mm_op req;
>-	int n, ret;
>-
>-	if(count > sizeof(req))
>-		return(-EINVAL);
>-
>-	n = copy_from_user(&req, buffer, count);
>-	if(n != 0)
>-		return(-EFAULT);
>-
>-	ret = count;
>-	switch(req.op){
>-	case MM_MMAP: {
>-		struct mm_mmap *map = &req.u.mmap;
>-
>-		ret = do_mmap2(mm, map->addr, map->len, map->prot,
>-			       map->flags, map->fd, map->offset >> PAGE_SHIFT);
>-		if((ret & ~PAGE_MASK) == 0)
>-			ret = count;
>-
>-		break;
>-	}
>-	case MM_MUNMAP: {
>-		struct mm_munmap *unmap = &req.u.munmap;
>-
>-		down_write(&mm->mmap_sem);
>-		ret = do_munmap(mm, unmap->addr, unmap->len);
>-		up_write(&mm->mmap_sem);
>-
>-		if(ret == 0)
>-			ret = count;
>-		break;
>-	}
>-	case MM_MPROTECT: {
>-		struct mm_mprotect *protect = &req.u.mprotect;
>-
>-		ret = do_mprotect(mm, protect->addr, protect->len,
>-				  protect->prot);
>-		if(ret == 0)
>-			ret = count;
>-		break;
>-	}
>-
>-	case MM_COPY_SEGMENTS: {
>-		struct mm_struct *from = proc_mm_get_mm(req.u.copy_segments);
>-
>-		if(IS_ERR(from)){
>-			ret = PTR_ERR(from);
>-			break;
>-		}
>-
>-		mm_copy_segments(from, mm);
>-		break;
>-	}
>-	default:
>-		ret = -EINVAL;
>-		break;
>-	}
>-
>-	return(ret);
>-}
>-
>-static int open_proc_mm(struct inode *inode, struct file *file)
>-{
>-	struct mm_struct *mm = mm_alloc();
>-	int ret;
>-
>-	ret = -ENOMEM;
>-	if(mm == NULL)
>-		goto out_mem;
>-
>-	ret = init_new_context(current, mm);
>-	if(ret)
>-		goto out_free;
>-
>-	spin_lock(&mmlist_lock);
>-	list_add(&mm->mmlist, &current->mm->mmlist);
>-	mmlist_nr++;
>-	spin_unlock(&mmlist_lock);
>-
>-	file->private_data = mm;
>-
>-	return(0);
>-
>- out_free:
>-	mmput(mm);
>- out_mem:
>-	return(ret);
>-}
>-
>-static int release_proc_mm(struct inode *inode, struct file *file)
>-{
>-	struct mm_struct *mm = file->private_data;
>-
>-	mmput(mm);
>-	return(0);
>-}
>-
>-static struct file_operations proc_mm_fops = {
>-	.open		= open_proc_mm,
>-	.release	= release_proc_mm,
>-	.write		= write_proc_mm,
>-};
>-
>-static int make_proc_mm(void)
>-{
>-	struct proc_dir_entry *ent;
>-
>-	ent = create_proc_entry("mm", 0222, &proc_root);
>-	if(ent == NULL){
>-		printk("make_proc_mm : Failed to register /proc/mm\n");
>-		return(0);
>-	}
>-	ent->proc_fops = &proc_mm_fops;
>-
>-	return(0);
>-}
>-
>-__initcall(make_proc_mm);
>-
>-/*
>- * Overrides for Emacs so that we follow Linus's tabbing style.
>- * Emacs will notice this stuff at the end of the file and automatically
>- * adjust the settings for this buffer only.  This must remain at the end
>- * of the file.
>- * ---------------------------------------------------------------------------
>- * Local variables:
>- * c-file-style: "linux"
>- * End:
>- */
>diff -puN mm/shmem.c~remove-devanon-skas mm/shmem.c
>--- um-linux-2.4.27/mm/shmem.c~remove-devanon-skas	2004-11-25 12:57:47.000000000 +0100
>+++ um-linux-2.4.27-paolo/mm/shmem.c	2004-11-25 12:57:47.000000000 +0100
>@@ -128,17 +128,16 @@ static void shmem_removepage(struct page
>  * 	      	       +-> 48-51
>  * 	      	       +-> 52-55
>  */
>-static void *shmem_block(unsigned long index, unsigned long *page,
>-			 unsigned long *direct, void ***indirect)
>+static swp_entry_t *shmem_swp_entry(struct shmem_inode_info *info, unsigned long index, unsigned long *page)
> {
> 	unsigned long offset;
> 	void **dir;
>
> 	if (index < SHMEM_NR_DIRECT)
>-		return direct+index;
>-	if (!*indirect) {
>+		return info->i_direct+index;
>+	if (!info->i_indirect) {
> 		if (page) {
>-			*indirect = (void **) *page;
>+			info->i_indirect = (void **) *page;
> 			*page = 0;
> 		}
> 		return NULL;			/* need another page */
>@@ -147,7 +146,7 @@ static void *shmem_block(unsigned long i
> 	index -= SHMEM_NR_DIRECT;
> 	offset = index % ENTRIES_PER_PAGE;
> 	index /= ENTRIES_PER_PAGE;
>-	dir = *indirect;
>+	dir = info->i_indirect;
>
> 	if (index >= ENTRIES_PER_PAGE/2) {
> 		index -= ENTRIES_PER_PAGE/2;
>@@ -170,21 +169,7 @@ static void *shmem_block(unsigned long i
> 		*dir = (void *) *page;
> 		*page = 0;
> 	}
>-	return (unsigned long **) *dir + offset;
>-}
>-
>-static swp_entry_t *shmem_swp_entry(struct shmem_inode_info *info, unsigned long index, unsigned long *page)
>-{
>-	return((swp_entry_t *) shmem_block(index, page,
>-					   (unsigned long *) info->i_direct,
>-					   &info->i_indirect));
>-}
>-
>-static unsigned long *shmem_map_count(struct shmem_inode_info *info,
>-				      unsigned long index, unsigned long *page)
>-{
>-	return((unsigned long *) shmem_block(index, page, info->map_direct,
>-					     &info->map_indirect));
>+	return (swp_entry_t *) *dir + offset;
> }
>
> /*
>@@ -862,7 +847,6 @@ static int shmem_mmap(struct file *file,
> 	ops = &shmem_vm_ops;
> 	if (!S_ISREG(inode->i_mode))
> 		return -EACCES;
>-
> 	UPDATE_ATIME(inode);
> 	vma->vm_ops = ops;
> 	return 0;
>@@ -1752,125 +1736,4 @@ int shmem_zero_setup(struct vm_area_stru
> 	return 0;
> }
>
>-static int adjust_map_counts(struct shmem_inode_info *info,
>-			     unsigned long offset, unsigned long len,
>-			     int adjust)
>-{
>-	unsigned long idx, i, *count, page = 0;
>-
>-	spin_lock(&info->lock);
>-	offset >>= PAGE_SHIFT;
>-	len >>= PAGE_SHIFT;
>-	for(i = 0; i < len; i++){
>-		idx = (i + offset) >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
>-
>-		while((count = shmem_map_count(info, idx, &page)) == NULL){
>-			spin_unlock(&info->lock);
>-			page = get_zeroed_page(GFP_KERNEL);
>-			if(page == 0)
>-				return(-ENOMEM);
>-			spin_lock(&info->lock);
>-		}
>-
>-		if(page != 0)
>-			free_page(page);
>-
>-		*count += adjust;
>-	}
>-	spin_unlock(&info->lock);
>-	return(0);
>-}
>-
> EXPORT_SYMBOL(shmem_file_setup);
>-
>-struct file_operations anon_file_operations;
>-
>-static int anon_mmap(struct file *file, struct vm_area_struct *vma)
>-{
>-        struct file *new;
>-	struct inode *inode;
>-	loff_t size = vma->vm_end - vma->vm_start;
>-	int err;
>-
>-	if(file->private_data == NULL){
>-	        new = shmem_file_setup("dev/anon", size);
>-		if(IS_ERR(new))
>-			return(PTR_ERR(new));
>-
>-		new->f_op = &anon_file_operations;
>-		file->private_data = new;
>-	}
>-
>-	if (vma->vm_file)
>-		fput(vma->vm_file);
>-	vma->vm_file = file->private_data;
>-	get_file(vma->vm_file);
>-
>-	inode = vma->vm_file->f_dentry->d_inode;
>-	err = adjust_map_counts(SHMEM_I(inode), vma->vm_pgoff, size, 1);
>-	if(err)
>-		return(err);
>-
>-	vma->vm_ops = &shmem_vm_ops;
>-	return 0;
>-}
>-
>-static void anon_munmap(struct file *file, struct vm_area_struct *vma,
>-			unsigned long start, unsigned long len)
>-{
>-	struct inode *inode = file->f_dentry->d_inode;
>-	struct shmem_inode_info *info = SHMEM_I(inode);
>-	pgd_t *pgd;
>-	pmd_t *pmd;
>-	pte_t *pte;
>-	struct page *page;
>-	unsigned long addr, idx, *count;
>-
>-	for(addr = start; addr < start + len; addr += PAGE_SIZE){
>-		idx = (addr - vma->vm_start + vma->vm_pgoff);
>-		idx >>= PAGE_CACHE_SHIFT;
>-
>-		count = shmem_map_count(info, idx, NULL);
>-		BUG_ON(count == NULL);
>-
>-		(*count)--;
>-		if(*count > 0)
>-			continue;
>-
>-		pgd = pgd_offset(vma->vm_mm, addr);
>-		if(pgd_none(*pgd))
>-			continue;
>-
>-		pmd = pmd_offset(pgd, addr);
>-		if(pmd_none(*pmd))
>-			continue;
>-
>-		pte = pte_offset(pmd, addr);
>-		if(!pte_present(*pte)) /* XXX need to handle swapped pages */
>-			continue;
>-
>-		*pte = pte_mkclean(*pte);
>-
>-		page = pte_page(*pte);
>-		LockPage(page);
>-		lru_cache_del(page);
>-		ClearPageDirty(page);
>-		remove_inode_page(page);
>-		UnlockPage(page);
>-
>-		page_cache_release(page);
>-	}
>-}
>-
>-int anon_release(struct inode *inode, struct file *file)
>-{
>-	if(file->private_data != NULL)
>-		fput(file->private_data);
>-	return(0);
>-}
>-
>-struct file_operations anon_file_operations = {
>-	.mmap		= anon_mmap,
>-	.munmap 	= anon_munmap,
>-	.release	= anon_release,
>-};
>diff -puN arch/um/config.in~remove-devanon-skas arch/um/config.in
>--- um-linux-2.4.27/arch/um/config.in~remove-devanon-skas	2004-11-25 13:05:25.000000000 +0100
>+++ um-linux-2.4.27-paolo/arch/um/config.in	2004-11-25 13:07:26.000000000 +0100
>@@ -52,7 +52,6 @@ fi
> int 'Nesting level' CONFIG_NEST_LEVEL 0
> int 'Kernel address space size (in .5G units)' CONFIG_KERNEL_HALF_GIGS 1
> bool 'Highmem support' CONFIG_HIGHMEM
>-bool '/proc/mm' CONFIG_PROC_MM
> int 'Kernel stack size order' CONFIG_KERNEL_STACK_ORDER 2
> bool 'Real-time Clock' CONFIG_UML_REAL_TIME_CLOCK
> endmenu
>diff -puN arch/um/defconfig~remove-devanon-skas arch/um/defconfig
>--- um-linux-2.4.27/arch/um/defconfig~remove-devanon-skas	2004-11-25 13:05:37.000000000 +0100
>+++ um-linux-2.4.27-paolo/arch/um/defconfig	2004-11-25 13:07:26.000000000 +0100
>@@ -37,7 +37,6 @@ CONFIG_MAGIC_SYSRQ=y
> CONFIG_NEST_LEVEL=0
> CONFIG_KERNEL_HALF_GIGS=1
> # CONFIG_HIGHMEM is not set
>-CONFIG_PROC_MM=y
> CONFIG_KERNEL_STACK_ORDER=2
> CONFIG_UML_REAL_TIME_CLOCK=y
>
>diff -puN arch/um/kernel/ptrace.c~remove-devanon-skas arch/um/kernel/ptrace.c
>--- um-linux-2.4.27/arch/um/kernel/ptrace.c~remove-devanon-skas	2004-11-25 13:05:49.000000000 +0100
>+++ um-linux-2.4.27-paolo/arch/um/kernel/ptrace.c	2004-11-25 13:07:26.000000000 +0100
>@@ -7,9 +7,6 @@
> #include "linux/mm.h"
> #include "linux/errno.h"
> #include "linux/smp_lock.h"
>-#ifdef CONFIG_PROC_MM
>-#include "linux/proc_mm.h"
>-#endif
> #include "asm/ptrace.h"
> #include "asm/uaccess.h"
> #include "kern_util.h"
>@@ -231,57 +228,6 @@ int sys_ptrace(long request, long pid, l
> 		ret = set_fpxregs(data, child);
> 		break;
> #endif
>-	case PTRACE_FAULTINFO: {
>-		struct ptrace_faultinfo fault;
>-
>-		fault = ((struct ptrace_faultinfo)
>-			{ .is_write	= child->thread.err,
>-			  .addr		= child->thread.cr2 });
>-		ret = copy_to_user((unsigned long *) data, &fault,
>-				   sizeof(fault));
>-		if(ret)
>-			break;
>-		break;
>-	}
>-	case PTRACE_SIGPENDING:
>-		ret = copy_to_user((unsigned long *) data,
>-				   &child->pending.signal,
>-				   sizeof(child->pending.signal));
>-		break;
>-
>-	case PTRACE_LDT: {
>-		struct ptrace_ldt ldt;
>-
>-		if(copy_from_user(&ldt, (unsigned long *) data,
>-				  sizeof(ldt))){
>-			ret = -EIO;
>-			break;
>-		}
>-
>-		/* This one is confusing, so just punt and return -EIO for
>-		 * now
>-		 */
>-		ret = -EIO;
>-		break;
>-	}
>-#ifdef CONFIG_PROC_MM
>-	case PTRACE_SWITCH_MM: {
>-		struct mm_struct *old = child->mm;
>-		struct mm_struct *new = proc_mm_get_mm(data);
>-
>-		if(IS_ERR(new)){
>-			ret = PTR_ERR(new);
>-			break;
>-		}
>-
>-		atomic_inc(&new->mm_users);
>-		child->mm = new;
>-		child->active_mm = new;
>-		mmput(old);
>-		ret = 0;
>-		break;
>-	}
>-#endif
> 	default:
> 		ret = -EIO;
> 		break;
>diff -puN include/linux/mm.h~remove-devanon-skas include/linux/mm.h
>--- um-linux-2.4.27/include/linux/mm.h~remove-devanon-skas	2004-11-25 13:15:05.310753896 +0100
>+++ um-linux-2.4.27-paolo/include/linux/mm.h	2004-11-25 13:16:05.670577808 +0100
>@@ -517,9 +517,6 @@ extern int ptrace_check_attach(struct ta
> int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
> 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
>
>-extern long do_mprotect(struct mm_struct *mm, unsigned long start,
>-			size_t len, unsigned long prot);
>-
> /*
>  * On a two-level page table, this ends up being trivial. Thus the
>  * inlining and the symmetry break with pte_alloc() that does all
>@@-567,10 +564,9 @@ extern void exit_mmap(struct mm_struct *
>
> extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
>
>-extern unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file *file,
>-				   unsigned long addr, unsigned long len,
>-				   unsigned long prot, unsigned long flag,
>-				   unsigned long pgoff);
>+extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
>+	unsigned long len, unsigned long prot,
>+	unsigned long flag, unsigned long pgoff);
>
> static inline unsigned long do_mmap(struct file *file, unsigned long addr,
> 	unsigned long len, unsigned long prot,
>@@ -580,8 +576,7 @@ static inline unsigned long do_mmap(stru
> 	if ((offset + PAGE_ALIGN(len)) < offset)
> 		goto out;
> 	if (!(offset & ~PAGE_MASK))
>-		ret = do_mmap_pgoff(current->mm, file, addr, len, prot, flag,
>-				    offset >> PAGE_SHIFT);
>+		ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
> out:
> 	return ret;
> }
>_
>
>

--
db


--------------enig067D73710CEBEA04A568DC38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCJfHs3XQ4zakZ3z4RAoviAJ0TY4BqDQBJQWzxBghY3PaDYM1PTwCeLa28
YB1jUlILH7tfRimGWBS+Rs4=
=Hpmm
-----END PGP SIGNATURE-----

--------------enig067D73710CEBEA04A568DC38--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

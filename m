Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uXL9-0001z2-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 06:06:27 -0700
Received: from snoopy.pacific.net.au ([61.8.0.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uXL8-0006Su-7Y
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 06:06:26 -0700
Received: from sunny.pacific.net.au (sunny.pacific.net.au [203.2.228.40])
	by snoopy.pacific.net.au (8.12.3/8.12.3/Debian-6.4) with ESMTP id h83D6MBt021755
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 3 Sep 2003 23:06:22 +1000
Received: from zeus.zipworld.com.au (zeus.zipworld.com.au [61.8.0.1])
          by sunny.pacific.net.au with ESMTP
          id h83D6Lkv004226 for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 3 Sep 2003 23:06:21 +1000 (EST)
Received: from zeus.zipworld.com.au (localhost [127.0.0.1])
	by zeus.zipworld.com.au (8.12.3/8.12.3/Debian-6.4) with ESMTP id h83D5VSG013911
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 3 Sep 2003 23:05:31 +1000
Received: (from fozzy@localhost)
	by zeus.zipworld.com.au (8.12.3/8.12.3/Debian-6.4) id h83D5Vo5013910
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 3 Sep 2003 23:05:31 +1000
From: Andrew Steele <fozzy@zip.com.au>
Message-ID: <20030903130531.GB8159@zipworld.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] vmware vmmon and skas
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
Date: Wed, 3 Sep 2003 23:05:31 +1000
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm setting up a server for hosting various types of virtual machines.
The server is running Mandrake 9.0 for which I've just loaded the latest
cooker kernel onto (2.4.22-1mdk).  I've added the skas3 patch to this.
This went fairly well but there were places I had to manually fix as a
result of GR security patch that is part of Mandrake's kernel.

Then I went to the next task.  Setting up vmware to work with this
new kernel.  I have vmware Workstation 3.2 and I've applied the
vmware-any-any-update39 patch to it to get it to work with the latest
kernels.  When I went to build/install the various vmware bits it
failed to build the vmmon module.  The problem is that in hostif.c
it calls do_mmap_pgoff to which the skas patch has added an additional
argument.

I must admit, the application of the skas patch to the Mandrake kernel
was a good lesson in what sort of changes would be required for vmmon

Based on what I saw in other files I simply added a new first argument
	current->mm

But I don't really understand enough about what I'm doing and hope
someone might be able to check if what I've done is correct.

I've attached at the end this email the hostif.c file.  The change is at
line 637 on the do_mmap_pgoff call.

The entire vmmon source I've put up on:
	http://cust.idl.com.au/fozzy/vmmon/vmmon.tbz
	
Could you please respond to me directly as I'm not subscribed to this
list.

Thanks
Andrew


/* **********************************************************
 * Copyright 1998 VMware, Inc.  All rights reserved. -- VMware Confidential
 * **********************************************************/
#   define FILECODE "F(303)"


/*
 * hostif.c --
 *
 *    This file implements the platform-specific (here Linux) interface that
 *    the cross-platform code uses --hpreg
 *
 */


/* Must come before any kernel header file --hpreg */
#include "driver-config.h"

/* Must come before vm_types.h --hpreg */
#include "compat_page.h"
#include <linux/binfmts.h>
#include <linux/fs.h>
#include <linux/sched.h>
#include <linux/file.h>
#ifdef KERNEL_2_2
   #include <linux/slab.h>
#else
   #include <linux/malloc.h>
#endif

#include <asm/fixmap.h>	// for IO_APIC address
#include <linux/poll.h>
#include <linux/file.h>
#include <linux/mman.h>

#include <linux/smp.h>
#include <linux/smp_lock.h>

#include <asm/io.h>

#include "machine.h"
#include "vm_types.h"
#include "vm_assert.h"
#include "vm_asm.h"
#include "modulecall.h"
#include "memtrack.h"
#include "phystrack.h"
#include "cpuid.h"
#include "cpuid_info.h"
#include "hostif.h"
#include "driver.h"
#include "vmhost.h"

#include "compat_uaccess.h"
#include "compat_highmem.h"
#include "compat_mm.h"
#include "compat_file.h"
#include "compat_wait.h"
#include "pgtbl.h"
#include "vmmonInt.h"


/*
 * First Page Locking strategy
 * ---------------------------
 *
 * An early implementation hacked the lock bit for the purpose of locking
 * memory. This had a couple of advantages:
 *   - the vmscan algorithm would never eliminate mappings from the process
 *     address space
 *   - easy to assert that things are ok
 *   - it worked with anonymous memory. Basically, vmscan jumps over these
 *     pages, their use count stays high, ....
 *
 * This approach however had a couple of problems:
 *
 *   - it relies on an undocumented interface. (in another words, a total hack)
 *   - it creates deadlock situations if the application gets a kill -9 or
 *     otherwise dies ungracefully. linux first tears down the address space,
 *     then closes file descriptors (including our own device). Unfortunately,
 *     this leads to a deadlock of the process on pages with the lock bit set.
 *
 *     There is a workaround for that, namely to detect that condition using
 *     a linux timer. (ugly)
 *
 * Current Page Locking strategy
 * -----------------------------
 *
 * The current scheme does not use the lock bit, rather it increments the use
 * count on the pages that need to be locked down in memory.
 *
 * The problem is that experiments on certain linux systems (e.g. 2.2.0-pre9)
 * showed that linux somehow swaps out anonymous pages, even with the
 * increased ref counter.
 * Swapping them out to disk is not that big of a deal, but bringing them back
 * to a different location is.  In any case, anonymous pages in linux are not
 * intended to be write-shared (e.g. try to MAP_SHARED /dev/zero).
 *
 * As a result, the current locking strategy requires that all locked pages are
 * backed by the filesystem, not by swap. For now, we use both mapped files and
 * sys V shared memory. The user application is responsible to cover these
 * cases.
 *
 * About MemTracker and PhysTracker
 * --------------------------------
 *
 * Redundancy is good for now. 
 * 
 * MemTracker is actually required for the NT host version
 * For the linux host, we use both for now
 *
 */


#define HOST_UNLOCK_PFN(_vm, _pfn) do {          \
   put_page(pfn_to_page(_pfn));                  \
   PhysTrack_Remove((_vm)->physTracker, (_pfn)); \
} while (0)

#define HOST_ISTRACKED_PFN(_vm, _pfn) (PhysTrack_Test(_vm->physTracker, _pfn))


#ifdef CONFIG_SMP
static spinlock_t vm_lock;
#else
static int vm_lock;
#endif


/* If the lock is held, this is the task that holds it --hpreg */
static struct task_struct *vm_lock_task;
/*
 * If the lock is held, this is the location in the code where the lock was
 * acquired --hpreg
 */
static int vm_lock_holder;


/*
 *----------------------------------------------------------------------
 *
 * HostIF_InitSpinLock --
 *
 *      Initialize the vm spin lock
 *
 * Results:
 *      
 *     zero on success, non-zero on error.
 *      
 *
 * Side effects:
 *     None
 *
 *----------------------------------------------------------------------
 */

void
HostIF_InitSpinLock(void)
{
#ifdef CONFIG_SMP
   spin_lock_init(&vm_lock);
#endif
}


#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 3)
static INLINE void
down_write_mmap(void)
{
   down_write(&current->mm->mmap_sem);
}


static INLINE void
up_write_mmap(void)
{
   up_write(&current->mm->mmap_sem);
}


static INLINE void
down_read_mmap(void)
{
   down_read(&current->mm->mmap_sem);
}


static INLINE void
up_read_mmap(void)
{
   up_read(&current->mm->mmap_sem);
}
#else
static INLINE void
down_write_mmap(void)
{
   down(&current->mm->mmap_sem);
}


static INLINE void
up_write_mmap(void)
{
   up(&current->mm->mmap_sem);
}


static INLINE void
down_read_mmap(void)
{
   down_write_mmap();
}


static INLINE void
up_read_mmap(void)
{
   up_write_mmap();
}
#endif

/*
 *----------------------------------------------------------------------
 *
 * HostIFHostMemInit --
 *
 *      Initialize per-VM pages lists.
 *
 * Results:
 *      0 on success,
 *      non-zero on failure.
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */

static int
HostIFHostMemInit(VMDriver *vm)
{
   VMHost *vmh = vm->vmhost;
   
   vmh->allocatedPages = PhysTrack_Alloc();
   if (!vmh->allocatedPages) {
      return -1;
   }
   return 0;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIFHostMemCleanup --
 *
 *      Release per-VM pages lists.
 *
 * Results:
 *      None.
 *
 * Side effects:
 *      Allocated pages released.
 *
 *----------------------------------------------------------------------
 */

static void
HostIFHostMemCleanup(VMDriver *vm)
{
   VMHost *vmh = vm->vmhost;

   if (!vmh) {
      return;
   }
   if (vmh->allocatedPages) {
      MPN mpn;
      unsigned count;
      
      for (mpn = 0, count=0; 
           INVALID_MPN != (mpn = PhysTrack_GetNext(vmh->allocatedPages, mpn));
           count++, mpn++) {
	 PhysTrack_Remove(vmh->allocatedPages, mpn);
         __free_page(pfn_to_page(mpn));
      }
      PhysTrack_Cleanup(vmh->allocatedPages);
      vmh->allocatedPages = NULL;
      if (count != 0) {
         printk(KERN_DEBUG "vmmon: Had to deallocate %u pages from "
                "vm driver %p\n", count, vm);
      }
   }
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_HostAllocLockedPages --
 *
 *      Alloc non-swappable memory.
 *
 * Results:
 *      negative value on complete failure
 *      non-negative value on partial/full completion, number of MPNs
 *          allocated & filled in pmpn returned.
 *
 * Side effects:
 *      Pages allocated.
 *
 *----------------------------------------------------------------------
 */

int
HostIF_HostAllocLockedPages(VMDriver *vm, MPN *pmpn, unsigned int numPages, int kspc)
{
   VMHost *vmh = vm->vmhost;
   unsigned int cnt;
   int err = 0;

   if (!vmh || !vmh->allocatedPages) {
      return -EINVAL;
   }
   for (cnt = 0; cnt < numPages; cnt++) {
      struct page* pg;
      MPN mpn;
      
      pg = alloc_page(GFP_HIGHUSER);
      if (!pg) {
         err = -ENOMEM;
	 break;
      }
      mpn = page_to_pfn(pg);
      if (kspc) {
         *pmpn = mpn;
      } else if (HostIF_CopyToUser(pmpn, &mpn, sizeof mpn)) {
         __free_page(pg);
	 err = -EFAULT;
	 break;
      }
      pmpn++;
      PhysTrack_Add(vmh->allocatedPages, mpn);
   }
   return cnt ? cnt : err;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_HostFreeLockedPages --
 *
 *      Free non-swappable memory.
 *
 * Results:
 *      zero on success,
 *      non-zero on failure.
 *
 * Side effects:
 *      Pages allocated.
 *
 *----------------------------------------------------------------------
 */

int
HostIF_HostFreeLockedPages(VMDriver *vm, MPN *pmpn, unsigned int numPages, int kspc)
{
   VMHost *vmh = vm->vmhost;
   unsigned int cnt;

   if (!vmh || !vmh->allocatedPages) {
      return -EINVAL;
   }
   for (cnt = 0; cnt < numPages; cnt++) {
      struct page* pg;
      MPN mpn;
      
      if (kspc) {
         mpn = *pmpn++;
      } else if (HostIF_CopyFromUser(&mpn, pmpn++, sizeof mpn)) {
         printk(KERN_DEBUG "Cannot read from process address space at %p\n", pmpn - 1);
	 continue;
      }
      if (!PhysTrack_Test(vmh->allocatedPages, mpn)) {
         printk(KERN_DEBUG "Attempted to free unallocated MPN %08X\n", mpn);
	 continue;
      }
      pg = pfn_to_page(mpn);
      PhysTrack_Remove(vmh->allocatedPages, mpn);
      if (page_count(pg) != 1) {
         printk(KERN_DEBUG "Page %08X is still used by someone (use count %u, VM %p)\n", 
	 	mpn, page_count(pg), vm);
      }
      __free_page(pg);
   }
   return 0;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIFFindVMA --
 *
 *      Find VMA for given VA.
 *
 * Results:
 *      negative value on complete/partial failure
 *      zero on success
 *
 * Side effects:
 *      Error message may be printed in kernel log.
 *
 *----------------------------------------------------------------------
 */

int
HostIFFindVMA(VMDriver *vm,			//IN: Which driver
	      VA va,				//IN: VA, page aligned
	      unsigned int numPages,		//IN: region size, in pages
	      struct VMLinux **pvmLinux,	//OUT: VMLinux found
	      unsigned long *pfirst,		//OUT: offset into mapped area
	      struct file **pfile)		//OUT: backing file
{
   struct vm_area_struct *vma;
   struct VMLinux *vmLinux;
   unsigned long first;

   if (va & (PAGE_SIZE - 1)) {
      printk(KERN_DEBUG "VA not page aligned (%08X)\n", va);
      return -EINVAL;
   }
   vma = find_vma(current->mm, va);
   if (!vma || vma->vm_start > va) {
      if (vma) {
         printk(KERN_DEBUG "No VMA found: requested %u pages at %08X, found vma %08lX-%08lX\n",
	        numPages, va, vma->vm_start, vma->vm_end);
      } else {
         printk(KERN_DEBUG "No VMA found: requested %u pages at %08X, found no vma\n", 
	 	numPages, va);
      }
      return -EFAULT;
   }
   if (vma->vm_ops != &vmuser_locked_mops) {
      printk(KERN_DEBUG "Found non-vmmon VMA (%08lX-%08lX) for VA %08X\n", vma->vm_start, vma->vm_end, va);
      return -EINVAL;
   }
   vmLinux = (VMLinux*)vma->vm_file->private_data;
   if (!vmLinux) {
      printk(KERN_DEBUG "Found vmmon VMA (%08lX-%08lX) for VA %08X with NULL vmLinux!\n", vma->vm_start, vma->vm_end, va);
      return -EINVAL;
   }
   if (vmLinux->vm != vm) {
      printk(KERN_DEBUG "VM %p tries to use VMA from VM %p\n", vm, vmLinux->vm);
      return -EINVAL;
   }
   first = ((va - vma->vm_start) >> PAGE_SHIFT) + compat_vm_pgoff(vma);
   if (first + numPages > vmLinux->sizeLocked) {
      printk(KERN_DEBUG "VMA %08lX-%08lX (off %08lX) is outside of reserved area (%08X ents)\n",
      	     vma->vm_start, vma->vm_end, compat_vm_pgoff(vma), vmLinux->sizeLocked);
      return -EINVAL;
   }
   *pvmLinux = vmLinux;
   *pfirst = first;
   if (pfile) {
      compat_get_file(*pfile = vma->vm_file);
   }
   return 0;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_HostMapLockedPages --
 *
 *      Map non-swappable memory.
 *
 * Results:
 *      negative value on complete/partial failure
 *      zero on success
 *
 * Side effects:
 *      Pages mapped.
 *
 *----------------------------------------------------------------------
 */

int
HostIF_HostMapLockedPages(VMDriver *vm, VA va, MPN *pmpn, unsigned int numPages, int kspc)
{
   struct VMLinux *vmLinux;
   unsigned long first;
   struct page* pg;
   struct VMHostEntry* vmhe = NULL;
   struct PhysTracker* pt;
   int err;
   
   down_read_mmap();
   err = HostIFFindVMA(vm, va, numPages, &vmLinux, &first, NULL);
   up_read_mmap();
   if (err) {
      return err;
   }
   pt = vmLinux->vm->vmhost->allocatedPages;
   pg = NULL;
   while (numPages--) {
      MPN mpn;
      
      if (HostIF_CopyFromUser(&mpn, pmpn++, sizeof mpn)) {
         printk(KERN_DEBUG "Cannot access MPN list at VA %p\n", pmpn - 1);
	 err = -EFAULT;
	 goto abort;
      }
      if (!PhysTrack_Test(pt, mpn)) {
         printk(KERN_DEBUG "Attempt to use unallocated MPN %08X\n", mpn);
	 err = -EFAULT;
	 goto abort;
      }
      if (!pg) {
         pg = vmLinux->pagesLocked->ent[first / VMHOST_MAPPING_PT];
         vmhe = kmap(pg);
      }
      if (vmhe->ent[first % VMHOST_MAPPING_PT]) {
         printk(KERN_DEBUG "Page %lu was already in use!\n", first);
	 err = -EINVAL;
	 goto abort;
      }
      vmhe->ent[first % VMHOST_MAPPING_PT] = pfn_to_page(mpn);
      first++;
      if (first % VMHOST_MAPPING_PT == 0) {
         kunmap(pg);
	 pg = NULL;
      }
   }
   if (pg) {
      kunmap(pg);
   }
   return 0;
abort:
   if (pg) {
      kunmap(pg);
   }
   return err;   
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_HostUnmapLockedPages --
 *
 *      Unmap non-swappable memory.
 *
 * Results:
 *      zero on success,
 *      non-zero on failure.
 *
 * Side effects:
 *      Pages allocated.
 *
 *----------------------------------------------------------------------
 */

int
HostIF_HostUnmapLockedPages(VMDriver *vm, VA va, MPN *pmpn, unsigned int numPages, int kspc)
{
   struct file *file;
   struct VMLinux *vmLinux;
   unsigned long first;
   struct page* pg;
   struct VMHostEntry* vmhe = NULL;
   struct PhysTracker* pt;
   unsigned int origsize;
   unsigned long range_pgoff;
   int err;

   down_read_mmap();
   err = HostIFFindVMA(vm, va, numPages, &vmLinux, &first, &file);
   up_read_mmap();
   if (err) {
      return err;
   }
   range_pgoff = first;
   origsize = numPages * PAGE_SIZE;
   pt = vmLinux->vm->vmhost->allocatedPages;
   pg = NULL;
   while (numPages--) {
      MPN mpn;
      
      if (HostIF_CopyFromUser(&mpn, pmpn++, sizeof mpn)) {
         printk(KERN_DEBUG "Cannot access MPN list at VA %p\n", pmpn - 1);
	 err = -EFAULT;
	 goto abort;
      }
      if (!pg) {
         pg = vmLinux->pagesLocked->ent[first / VMHOST_MAPPING_PT];
         vmhe = kmap(pg);
      }
      if (vmhe->ent[first % VMHOST_MAPPING_PT] != pfn_to_page(mpn)) {
         printk(KERN_DEBUG "Page %lu is used by %p and not by %p!\n",
	 	first, vmhe->ent[first % VMHOST_MAPPING_PT], pfn_to_page(mpn));
	 err = -EINVAL;
	 goto abort;
      }
      vmhe->ent[first % VMHOST_MAPPING_PT] = NULL;
      first++;
      if (first % VMHOST_MAPPING_PT == 0) {
         kunmap(pg);
	 pg = NULL;
      }
   }
   if (pg) {
      kunmap(pg);
   }
   /*
    * We actually want
    *    zap_page_range(vma, va, va + origsize)
    * but unfortunately zap_page_range is not available for modules.
    *
    * Remapping range does approximately same thing, but slower.
    * And unfortunately on 2.4.x this splits VMAs :-(
    */

   /*
    * If there is more than 100 users on file which backs our VMAs,
    * it means that VMA is fragmented too much. In such case we
    * remap whole region to get rid of fragmentation.
    */
   if (compat_file_count(file) > 100) {
      va = vmLinux->baseLocked;
      origsize = vmLinux->sizeLocked * PAGE_SIZE;
      range_pgoff = 0;
   }
   down_write_mmap();
   /* Added the current->mm argument to the following function call */
   first = do_mmap_pgoff(current->mm, file, va, origsize,
			 PROT_READ | PROT_WRITE | PROT_EXEC, 
   			 MAP_SHARED | MAP_FIXED, 
			 range_pgoff);
   up_write_mmap();
   compat_fput(file);
   if (first > (unsigned long)-1000) {
      printk(KERN_DEBUG "do_mmap_pgoff unexpectedly failed with error %ld\n", first);
      return (int)first;
   }
   return 0;
abort:
   if (pg) {
      kunmap(pg);
   }
   compat_fput(file);
   return err;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_Init --
 *
 *      Initialize the host-dependent part of the driver.
 *
 * Results:
 *      
 *     zero on success, non-zero on error.
 *
 * Side effects:
 *     None
 *
 *----------------------------------------------------------------------
 */

int
HostIF_Init(VMDriver *vm)
{
   int i;

   vm->memtracker = MemTrack_Init();
   if (vm->memtracker == NULL) {
      return -1;
   }
   vm->physTracker = PhysTrack_Init();
   if (vm->physTracker == NULL) {
      return -1;
   }

   vm->vmhost = (VMHost *) HostIF_AllocKernelMem(sizeof *vm->vmhost, TRUE);
   if (vm->vmhost == NULL) {
      return -1;
   }
   memset(vm->vmhost, 0, sizeof *vm->vmhost);

   init_waitqueue_head(&vm->vmhost->callQueue);
   atomic_set(&vm->vmhost->pendingUserCalls, 0);

   for (i = 0; i < VMX86_MAX_VCPUS; i++) {
      init_waitqueue_head(&vm->vmhost->replyQueue[i]);
   }

   if (HostIFHostMemInit(vm)) {
      return -1;
   }
   return 0;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_InitEvent --
 *
 *      Initialize the user call return event objects on Windows.
 *      Nothing to do on Linux.
 *
 * Results:
 *     No.
 *
 * Side effects:
 *     No.
 *
 *----------------------------------------------------------------------
 */

void
HostIF_InitEvent(VMDriver *vm)
{
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostifVa2Mpn --
 *
 *    Walks through the hardware page tables of the current process to try to
 *    find the the Machine Page Number (i.e. page number in the host physical
 *    address space) associated to a virtual address.
 *
 * Results:
 *    The MPN if the page is found in the tables
 *    0 if the page is not found in the tables
 *
 * Side effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

static INLINE MPN
HostifVa2Mpn(VA addr) // IN
{
   return page_to_pfn(PgtblVa2Page(addr));
}


/*
 *------------------------------------------------------------------------------
 *
 * HostIF_LookupUserMPN --
 *
 *      Lookup the MPN of a locked user page.
 *
 * Results:
 *      
 *      Returned page is a valid MPN, zero on error. 
 *
 * Side effects:
 *     None
 *
 *------------------------------------------------------------------------------
 */

MPN 
HostIF_LookupUserMPN(VMDriver *vm, // IN
                     void *uvAddr) // IN
{
   MPN mpn = HostifVa2Mpn((VA)uvAddr);

   /*
    * On failure, check whether the page is locked.
    *
    * While we don't require the page to be locked by HostIF_LockPage(),
    * it does provide extra information.
    *
    * -- edward
    */

   if (mpn == 0) {
      mpn = INVALID_MPN;
      if (vm == NULL) {
	 mpn += PAGE_LOOKUP_NO_VM;
      } else {
	 MemTrackEntry *entryPtr =
	    MemTrack_LookupVPN(vm->memtracker, PTR_2_VPN(uvAddr));
	 if (entryPtr == NULL) {
	    mpn += PAGE_LOOKUP_NOT_TRACKED;
	 } else if (entryPtr->mpn == 0) {
	    mpn += PAGE_LOOKUP_NO_MPN;
	 } else if (!HOST_ISTRACKED_PFN(vm, entryPtr->mpn)) {
	    mpn += PAGE_LOOKUP_NOT_LOCKED;
	 } else {
	    /*
	     * Kernel can remove PTEs/PDEs from our pagetables even if pages
	     * are locked...
	     */
	    volatile int c;

	    compat_get_user(c, (char *)uvAddr);
	    mpn = HostifVa2Mpn((VA)uvAddr);
	    if (mpn == entryPtr->mpn) {
#ifdef VMX86_DEBUG	    
	       printk(KERN_DEBUG "Page %p disappeared from %s(%u)... now back at %08X\n", 
		      uvAddr, current->comm, current->pid, mpn);
#endif
	    } else if (mpn) {
	       printk(KERN_DEBUG "Page %p disappeared from %s(%u)... now back at %08X (old=%08X)\n",
		      uvAddr, current->comm, current->pid, mpn, entryPtr->mpn);
	       mpn = INVALID_MPN;
	    } else {
#ifdef VMX86_DEBUG
	       printk(KERN_DEBUG "Page %p disappeared from %s(%u)... and is lost (old=%08X)\n",
		      uvAddr, current->comm, current->pid, entryPtr->mpn);
#endif		      
	       mpn = entryPtr->mpn;
	    }
	 }
      }
   }

   return mpn;
}

/*
 *----------------------------------------------------------------------
 *
 * HostIF_InitFP --
 *
 *      masks IRQ13 if not previously the case.
 *
 * Results:
 *      
 *      prevents INTR #0x2d (IRQ 13) from being generated --
 *      assume that Int16 works for interrupt reporting
 *      
 *
 * Side effects:
 *      PIC
 *
 *----------------------------------------------------------------------
 */
void
HostIF_InitFP(VMDriver *vm)
{
   int mask = (1<<(0xd-0x8));
  
   uint8 val = inb(0xA1);
   
#ifdef VMX86_DEVEL
   Log("HostIF_InitFP PIC1=0x%x  %s\n",
       val,
       ((val & mask) ? "Already Masked" : "To mask"));
#endif

   if (!(val & mask)) { 
      val = val | mask;
      outb(val,0xA1);
   }
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIFGetUserPage --
 *
 *      Lock the page of an user-level address space in memory.
 *	If ppage is NULL, page is only marked as dirty.
 *
 * Results:
 *      
 *      Zero on success, non-zero on failure. 
 *
 * Side effects:
 *      None
 *
 *-----------------------------------------------------------------------------
 */

static int
HostIFGetUserPage(void *uvAddr,		// IN
		  struct page** ppage)	// OUT
{
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 19)
   int retval;
      
   down_read(&current->mm->mmap_sem);
   retval = get_user_pages(current, current->mm, (unsigned long)uvAddr, 
   			   1, 1, 0, ppage, NULL);
   up_read(&current->mm->mmap_sem);

   return retval != 1;
#else
   struct page* page;
   struct page* check;
   volatile int c;

   compat_get_user(c, (char *)uvAddr);

   /*
    * now locate it and write the results back to the pmap
    *
    * Under extreme memory pressure, the page may be gone again.
    * Just fail the lock in that case.  (It was ASSERT_BUG(6339, mpn).)
    * -- edward
    */

   page = PgtblVa2Page((VA)uvAddr);
   if (page == pfn_to_page(0)) {
      return 1;
   }
   get_page(page);
   check = PgtblVa2Page((VA)uvAddr);
   if (page != check) {
      put_page(page);
      return 1;
   }
   if (ppage) {
      *ppage = page;
   } else {
      put_page(page);
   }
   return 0;
#endif
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_LockPage --
 *
 *      Lockup the MPN of an pinned user-level address space 
 *
 * Results:
 *      
 *      The MPN or zero on an error. 
 *
 * Side effects:
 *      None
 *
 *-----------------------------------------------------------------------------
 */

MPN
HostIF_LockPage(VMDriver *vm, // IN
                void *uvAddr) // IN
{
   struct page *page;
   MPN mpn;
   VPN vpn;
   MemTrackEntry *entryPtr;

   vpn = PTR_2_VPN(uvAddr);
   entryPtr = MemTrack_LookupVPN(vm->memtracker, vpn);

   /*
    * Already tracked and locked
    */

   if (entryPtr != NULL && entryPtr->mpn != 0) {
      return PAGE_LOCK_ALREADY_LOCKED;
   }

   if (HostIFGetUserPage(uvAddr, &page)) {
      return PAGE_LOCK_FAILED;
   }
   mpn = page_to_pfn(page);

   /*
    * XXXSMP.
    * XXX critical region
    */
   if (HOST_ISTRACKED_PFN(vm, mpn)) {
      Warning("HostIF_LockPage vpn=0x%06x mpn=%06x already tracked\n",vpn,mpn);
      put_page(page);
      return PAGE_LOCK_PHYSTRACKER_ERROR;
   }

   PhysTrack_Add(vm->physTracker, mpn);

   /*
    * If the entry doesn't exist, add it to the memtracker
    * otherwise we just update the mpn.
    */

   if (entryPtr != NULL) {
      entryPtr->mpn = mpn;  
   } else {
      entryPtr = MemTrack_Add(vm->memtracker, vpn, mpn);
      if (entryPtr == NULL) {
	 HOST_UNLOCK_PFN(vm,mpn);
	 return PAGE_LOCK_MEMTRACKER_ERROR;
      }
   }

   return mpn;
}



/*
 *----------------------------------------------------------------------
 *
 * HostIF_UnlockPage --
 *
 *      Unlock an pinned user-level page.
 *
 * Results:
 *      0 if successful, otherwise non-zero
 *      
 *
 * Side effects:
 *     None
 *
 *----------------------------------------------------------------------
 */
int
HostIF_UnlockPage(VMDriver *vm, void *addr)
{
   VPN vpn;
   MemTrackEntry *e;

   vpn = VA_2_VPN((VA)addr);
   e = MemTrack_LookupVPN(vm->memtracker, vpn);
    
   if (e == NULL) {
      return PAGE_UNLOCK_NOT_TRACKED;
   }
   if (e->mpn == 0) {
      return PAGE_UNLOCK_NO_MPN;
   }

   HOST_UNLOCK_PFN(vm, e->mpn);
   e->mpn = 0;

   return PAGE_UNLOCK_NO_ERROR;
}



/*
 *----------------------------------------------------------------------
 *
 * HostIF_ReleaseAnonPage --
 *
 *      The page with given mpn is unlocked and released. The page
 *      is put into a cache of released pages. Released pages can be 
 *      recycled later by calling HostIF_GetRecycledPage.
 *
 * Results:
 *      PAGE_UNLOCK_NO_ERROR
 *
 *----------------------------------------------------------------------
 */
int
HostIF_ReleaseAnonPage(VMDriver *vm, MPN mpn)
{
   MemTrackEntry *e;

   e = MemTrack_LookupMPN(vm->memtracker, mpn);
   if (e != NULL) {
      ASSERT(e->mpn == mpn);

      HOST_UNLOCK_PFN(vm, mpn);
      e->mpn = 0;

      MemTrack_RecyclePage(vm->memtracker, e);
   }
   return PAGE_UNLOCK_NO_ERROR;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_GetRecycledPage --
 *
 *      Returns the VPN of a previously released anonymous page, if
 *      one is available.
 *
 * Results:
 *      VPN of the page if one is available, INVALID_VPN otherwise
 *
 *----------------------------------------------------------------------
 */
VPN
HostIF_GetRecycledPage(VMDriver *vm)
{
   MemTrackEntry *e;

   e = MemTrack_GetRecycledPage(vm->memtracker);
   if (e != NULL) {
      return e->vpn;
   } else {
      return INVALID_VPN;
   }
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_FreeAllResources --
 *
 *      Unlock all the pages pinned for a vm. 
 *
 * Results:
 *      0 if successful, otherwise non-zero
 *      
 *      
 *
 * Side effects:
 *     None
 *
 *----------------------------------------------------------------------
 */

static void 
UnlockEntry(void *clientData,
            MemTrackEntry *entryPtr)
{
   VMDriver *vm = (VMDriver *)clientData;

   if (entryPtr->mpn) {
      if (HOST_ISTRACKED_PFN(vm, entryPtr->mpn)) {
         vm->releaseCount++;
         HOST_UNLOCK_PFN(vm,entryPtr->mpn);
      } else { 
         Warning("UnlockEntry vpn=0x%06x mpn=0x%06x not owned\n",
                 entryPtr->vpn,entryPtr->mpn);
      }
      entryPtr->mpn = 0;
   }
  
}


int
HostIF_FreeAllResources(VMDriver *vm)
{
   unsigned int cnt;

   HostIFHostMemCleanup(vm);
   vm->releaseCount = 0;
   for (cnt = vm->vmhost->crosspagePagesCount; cnt > 0; ) {
      struct page* p = vm->vmhost->crosspagePages[--cnt];
      
      kunmap(p);
      put_page(p);
   }
   vm->vmhost->crosspagePagesCount = 0;
   if (vm->memtracker) {
      MemTrack_Cleanup(vm->memtracker, UnlockEntry,vm);
      vm->memtracker = 0;
   }
   if (vm->physTracker) { 
      PhysTrack_Cleanup(vm->physTracker);
      vm->physTracker = 0;
   }
   return 0;
}



/*
 *----------------------------------------------------------------------
 *
 * HostIF_AllocKernelMem
 *
 *      Allocate some kernel memory for the driver. 
 *
 * Results:
 *      The address allocated or NULL on error. 
 *      
 *
 * Side effects:
 *      memory is malloced
 *----------------------------------------------------------------------
 */

void *
HostIF_AllocKernelMem(size_t size, int wired)
{
   void * ptr = kmalloc(size, GFP_KERNEL);
   
   if (ptr==NULL) { 
      Warning("HostIF_AllocKernelMem failed (size=0%x)\n",size);
   }

   return ptr;
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_AllocPage --
 *
 *    Allocate a page (whose content is undetermined)
 *
 * Results:
 *    The kernel virtual address of the page
 *
 * Side effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

void *
HostIF_AllocPage(void)
{
   VA kvAddr;

   kvAddr = __get_free_page(GFP_KERNEL);
   if (kvAddr == 0) {
      Warning("__get_free_page() failed\n");
   }
   return (void *)kvAddr;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_FreeKernelMem
 *
 *      Free kernel memory allocated for the driver. 
 *
 * Results:
 *      None.
 *
 * Side effects:
 *      memory is freed.
 *----------------------------------------------------------------------
 */

void
HostIF_FreeKernelMem(void *ptr)
{
   kfree(ptr);
}
   


void
HostIF_FreePage(void *ptr)
{
   VA vAddr = (VA)ptr;
   if (vAddr & (PAGE_SIZE-1)) {
      Warning("HostIF_FreePage 0x%08x misaligned\n", (uintptr_t)ptr);
   } else {
      free_page((VA)ptr);
   }
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_ReadUptime
 *
 *      Read the system uptime since boot.
 *
 * Results:
 *      Units are given by HostIF_UptimeFrequency.
 *
 * Side effects:
 *      None
 *
 *----------------------------------------------------------------------
 */

uint64
HostIF_ReadUptime(void)
{
   return jiffies;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_UptimeFrequency
 *
 *      Return the frequency of the counter that HostIF_ReadUptime reads.
 *
 * Results:
 *      Frequency in Hz.
 *
 * Side effects:
 *      None
 *
 *----------------------------------------------------------------------
 */

uint64
HostIF_UptimeFrequency(void)
{
   return HZ;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIFCheckGlobalVMLock
 *
 *    Warn if this task holds the global VM lock --hpreg
 *
 * Results:
 *    None
 *
 * Side effects:
 *    None
 *
 *----------------------------------------------------------------------
 */

static INLINE void
HostIFCheckGlobalVMLock(char const *file,  // IN
                        unsigned int line) // IN
{
   if (vm_lock_task == current) {
      /* This task holds the global VM lock --hpreg */
      printk("/dev/vmmon: PID %u holds the global VM lock at %s:%u.\n",
             current->pid, file, line);
   }
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_CopyFromUser --
 *
 *    Copy memory from the user application into a kernel buffer --hpreg
 *
 * Results:
 *    0 on success
 *    != 0 on failure. In this implementation, this is the number of trailing
 *                     bytes that we failed to copy
 *
 * Side effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

int
HostIF_CopyFromUser(void *dst, // OUT
                    void *src, // IN
                    int len)   // IN
{
   /*
    * copy_from_user() can deschedule this task on kernels where the low
    * latency patch has been applied, so make sure that this task doesn't hold
    * any spin lock --hpreg
    */
   HostIFCheckGlobalVMLock(FILECODESTRING, __LINE__);

   return copy_from_user(dst, src, len);
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_CopyToUser --
 *
 *    Copy memory to the user application from a kernel buffer --hpreg
 *
 * Results:
 *    0 on success
 *    != 0 on failure. In this implementation, this is the number of trailing
 *                     bytes that we failed to copy
 *
 * Side effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

int 
HostIF_CopyToUser(void *dst, // OUT
                  void *src, // IN
                  int len)   // IN
{
   /*
    * copy_to_user() can deschedule this task on kernels where the low
    * latency patch has been applied, so make sure that this task doesn't hold
    * any spin lock --hpreg
    */
   HostIFCheckGlobalVMLock(FILECODESTRING, __LINE__);

   return copy_to_user(dst, src, len);
}


/*
 *-----------------------------------------------------------------------------
 *
 * __mod_user_asm --
 *
 *    Mark page dirty. Does not check for kernel address or for broken
 *    write protect on i386.
 *
 * Results:
 *    err unmodified on success
 *    err set to errret on failure.
 *
 * Side effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

#define __mod_user_asm(addr, err, errret)	\
   asm volatile (				\
      "1:    lock; orb $0,%1\n"			\
      "2:\n"					\
      ".section .fixup,\"ax\"\n"		\
      "3:    movl %2,%0\n"			\
      "      jmp 2b\n"				\
      ".previous\n"				\
      ".section __ex_table,\"a\"\n"		\
      "      .align 4\n"			\
      "      .long 1b,3b\n"			\
      ".previous"				\
      : "=r"(err)				\
      : "m"(__m(addr)), "i"(errret), "0"(err))


/*
 *-----------------------------------------------------------------------------
 *
 * mod_user_check --
 *
 *    Mark page dirty.
 *
 * Results:
 *    0 on success
 *    -EFAULT on failure - address not mapped, or read-only, or not user address
 *
 * Side effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

#define mod_user_check(addr)				\
({							\
   long __mu_err = -EFAULT;				\
   void *__mu_addr = (addr);				\
   if (access_ok(VERIFY_WRITE, __mu_addr, 1)) {		\
      __mu_err = 0;					\
      __mod_user_asm(__mu_addr, __mu_err, -EFAULT);	\
   }							\
   __mu_err;						\
})


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_MarkPageDirty --
 *
 *    Mark page dirty.
 *
 * Results:
 *    0 on success
 *    != 0 on failure.
 *
 * Side effects:
 *    Complain loudly if global VM lock is held.
 *
 *-----------------------------------------------------------------------------
 */

int
HostIF_MarkPageDirty(void *addr) // IN/OUT
{
   /*
    * Touching userspace can deschedule this task on kernels where the low
    * latency patch has been applied, so make sure that this task doesn't hold
    * any spin lock
    */
   HostIFCheckGlobalVMLock(FILECODESTRING, __LINE__);

#ifdef MODULE_X86_64
   /* XXX not implemented on x86-64. */
   return 0;
#elif defined(CONFIG_X86_4G) || defined(CONFIG_X86_UACCESS_INDIRECT)
   HostIFGetUserPage(addr, NULL);
   return 0;
#else
   return mod_user_check(addr);
#endif
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_MapCrossPage --
 *    
 *    Obtain kernel pointer to crosspage. 
 *
 *    If we are running on the kernel where entire user address space is
 *    directly available to the kernel, we can use userland mapping of the 
 *    crosspage directly.  This address is guaranteed to not overlap with 
 *    monitor (see PR 25698).
 *
 *    If we are running on the kernel where entire user address space is not
 *    directly available to the kernel, we have to explicitly map page to the
 *    kernel address space.  In this case we need crosspage allocated from 
 *    the low memory to guarantee that page's LA will not overlap with monitor.
 *
 * Results:
 *    The kernel virtual address on success
 *    NULL on failure
 *
 * Side effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

void *
HostIF_MapCrossPage(VMDriver *vm,     // IN
                    void *p,          // IN
                    LA *linearAddr)   // OUT
{
#if defined(CONFIG_X86_4G) || defined(CONFIG_X86_UACCESS_INDIRECT)
   struct page *page;
   void *ptr;
   LA ret;

   if (HostIFGetUserPage(p, &page)) {
      return NULL;
   }
   ptr = kmap(page);
   if ((unsigned long)ptr >= 0xFFC00000) { // MONITOR BASE
      kunmap(page);
      put_page(page);
      printk(KERN_DEBUG "vmmon: Bad luck: crosspage at user VA %p, page %p[%lu] is available only through kmap at %p\n",
      	     p, page, page_to_pfn(page), ptr);
      return NULL;
   }
   HostIF_GlobalVMLock(16);
   if (vm->vmhost->crosspagePagesCount >= MAX_INITBLOCK_CPUS) {
      HostIF_GlobalVMUnlock(16);
      kunmap(page);
      put_page(page);
      return NULL;
   }
   vm->vmhost->crosspagePages[vm->vmhost->crosspagePagesCount++] = page;
   HostIF_GlobalVMUnlock(16);
   ret = (LA)(uintptr_t)ptr | (((unsigned long)p) & (PAGE_SIZE - 1));
   *linearAddr = ret;
   return (void*)ret;
#else
   /* Make sure we can read and write the crosspage on this side. */
   if (verify_area(VERIFY_READ, p, PAGE_SIZE) ||
       verify_area(VERIFY_WRITE, p, PAGE_SIZE)) {
      return NULL;
   }
   *linearAddr = (LA)(uintptr_t)p;
   return p;
#endif
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_UserToDriverPtr 
 *
 *    Convert a user virtual address into a kernel virtual address to access
 *    the same physical memory address --hpreg
 *
 * Results:
 *    The kernel virtual address on success
 *    NULL on failure
 *
 * Side effects:
 *    XXX Use 1 per-VM storage location. So for example, we leak kernel memory
 *        when we run a SMP VM on a host with more than 850 MB of RAM --hpreg
 *
 *-----------------------------------------------------------------------------
 */

void *
HostIF_UserToDriverPtr(VMDriver *vm, // IN
                       VA32 uvAddr) // IN
{
   struct page *page;

   if (HostIFGetUserPage((void *)uvAddr, &page)) {
      return NULL;
   }

   HostIF_GlobalVMLock(17);
   if (vm->vmhost->crosspagePagesCount >= MAX_INITBLOCK_CPUS) {
      HostIF_GlobalVMUnlock(17);
      put_page(page);
      return NULL;
   }
   vm->vmhost->crosspagePages[vm->vmhost->crosspagePagesCount++] = page;
   HostIF_GlobalVMUnlock(17);

   return (char *)kmap(page) + (uvAddr & (PAGE_SIZE - 1));
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_IsMPNLocked
 *
 *      Return entryPtr if MPN is locked into memory
 *
 * Results:
 *      0 if sucessful and non-zero or error.
 *
 * Side effects:
 *      None.
 *----------------------------------------------------------------------
 */

static void *
FindFunc(void *arg, MemTrackEntry *entryPtr)
{
   MPN mpn = (MPN) arg;
   
   if (entryPtr->mpn == mpn) {
      return entryPtr;
   }
   return NULL;
}

int
HostIF_IsMPNLocked(VMDriver *vm, MPN mpn)
{
  MemTrackEntry *entry;

  entry = MemTrack_Scan(vm->memtracker,vm, FindFunc);
  return (entry != NULL);
}


static void *
CheckFunc(void *arg,               // IN
          MemTrackEntry *entryPtr) // IN
{
   VMDriver *vm = (VMDriver *)arg;
   MPN mpn;
   
   if (entryPtr->mpn == 0) {
      return NULL;
   }

   mpn = HostifVa2Mpn(VPN_2_VA(entryPtr->vpn));
   if (mpn == 0) { 
      /* Unmapped */
      return entryPtr;
   }

   if (entryPtr->mpn != mpn) {
      Warning("CheckFunc vpn 0x%x mpn 0x%x and not 0x%x \n", 
              entryPtr->vpn, mpn, entryPtr->mpn);
      vm->checkFuncFailed = TRUE;
   }
    
   return NULL;
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_CheckMemory
 *
 *      Make sure memory locking is OK.
 *
 *      This function runs as part of the application process, as such
 *      HostifVa2Mpn is fine
 *
 * Results:
 *      None
 *
 * Side effects:
 *      None.
 *
 *-----------------------------------------------------------------------------
 */

VA
HostIF_CheckMemory(VMDriver *vm) // IN
{
   MemTrackEntry *entryPtr;
   
   vm->checkFuncFailed = FALSE;
   entryPtr = MemTrack_Scan(vm->memtracker, vm, CheckFunc);
   
   if (vm->checkFuncFailed) {
      return 1;
   }

   if (entryPtr) {
      return VPN_2_VA(entryPtr->vpn);
   }

   return 0;
}
   

/*
 *----------------------------------------------------------------------
 *
 * HostIF_LockKernel --
 *
 *      grabs the global kernel lock
 *      For the UP driver, do nothing
 *
 * Results:
 *      
 *      void
 *
 * Side effects:
 *      lock held
 *
 *----------------------------------------------------------------------
 */
void
HostIF_LockKernel(void)
{
   lock_kernel();
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_UnlockKernel --
 *
 *      releases the global kernel lock
 *      For the UP driver, do nothing
 *
 * Results:
 *      
 *      void
 *
 * Side effects:
 *      lock released
 *
 *----------------------------------------------------------------------
 */
void
HostIF_UnlockKernel(void)
{
   unlock_kernel();
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_GlobalVMLock --
 *
 *      grabs the global data structure lock.
 *      For the UP driver, assert that the lock counter is zero and increment
 *
 * Results:
 *      
 *      void
 *
 * Side effects:
 *      Should be a very low contention lock.
 *
 *----------------------------------------------------------------------
 */
void
HostIF_GlobalVMLock(int callerID)
{
#ifdef CONFIG_SMP
   if (! spin_trylock(&vm_lock)) {
      /*
       * Don't rely too much on this information: imagine the following
       * scenario:
       *
       * process 1               process 2
       * ---------               --------  
       * Acquire vm_lock
       * Set vm_lock_holder to 1
       * Release vm_lock
       * Acquire vm_lock
       *                         Try to acquire vm_lock and fail, so report
       *                         a bogus vm_lock of 1 instead of the correct 2
       * Set vm_lock_holder to 2
       * Release vm_lock
       *                         Acquire vm_lock
       *                         Set vm_lock_holder to 3
       *                         Release vm_lock
       *
       *  --hpreg
       */
      printk(KERN_WARNING "/dev/vmmon: %d wait for global VM lock %d\n",
	     callerID, vm_lock_holder);

      spin_lock(&vm_lock);
   }
#else
   if (vm_lock) { 
      Panic("/dev/vmmon: %d global VM lock held -- no SMP version\n",
            callerID);
   }
   vm_lock++;
#endif
   vm_lock_task = current;
   vm_lock_holder = callerID;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_GlobalVMUnlock --
 *
 *      releases the global data structure lock.
 *      For the UP driver, assert that the lock counter is 1 and decrement
 *
 * Results:
 *      
 *      void
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */
void
HostIF_GlobalVMUnlock(int callerID)
{
   if (vm_lock_holder != callerID) {
      printk(KERN_WARNING "/dev/vmmon: %d releasing global VM lock %d\n",
	     callerID, vm_lock_holder);
   }
   vm_lock_task = NULL;
   vm_lock_holder = -1;
#ifdef CONFIG_SMP
   spin_unlock(&vm_lock);
#else
   if (vm_lock != 1) { 
      Panic("/dev/vmmon: %d global lock not held -- no SMP version\n",
            callerID);
   }
   vm_lock--;
#endif
}


/*
 * Utility routines for accessing and enabling the APIC
 */

/*
 * Defines for accessing the APIC.  We use readl/writel to access the APIC
 * which is how Linux wants you to access I/O memory (though on the x86
 * just dereferencing a pointer works just fine).
 */
#define APICR_TO_ADDR(apic, reg)      (apic + (reg << 4))
#define GET_APIC_REG(apic, reg)       (readl(APICR_TO_ADDR(apic, reg)))
#define SET_APIC_REG(apic, reg, val)  (writel(val, APICR_TO_ADDR(apic, reg)))

#define APIC_MAXLVT(apic)             ((GET_APIC_REG(apic, APICR_VERSION) >> 16) & 0xff)
#define APIC_VERSIONREG(apic)         (GET_APIC_REG(apic, APICR_VERSION) & 0xff)


/*
 *----------------------------------------------------------------------
 *
 * GetMSR --
 *
 *      Wrapper for the macro that calls the rdmsr instruction.
 *
 * Results:
 *      Returns the value of the MSR.
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */

static INLINE uint64
GetMSR(int index)
{
   uint64 msr;
   msr = __GET_MSR (index);
   return msr;
}

uint64
HostIF_RDMSR(int index)
{
   return GetMSR(index);
}

void
HostIF_WRMSR(int index, uint64 val)
{
   uint32 hi = val >> 32;
   uint32 low = val & (-1UL);
   asm("wrmsr" : : "c" (index), "a" (low), "d" (hi));
}

/*
 *----------------------------------------------------------------------
 *
 * GetCPUID --
 *
 *      Wrapper for the macro that calls the cpuid instruction.
 *
 * Results:
 *      Returns the value of cpuid in regs.
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */

static INLINE void
GetCPUID(int index, uint32 *regs)
{
   __GET_CPUID (index, regs);
}

void
HostIF_GetCPUID(int index, uint32 *regs)
{
   GetCPUID(index, regs);
}


#if defined(CONFIG_SMP) || defined(CONFIG_X86_UP_IOAPIC) || defined(CONFIG_X86_UP_APIC)
/*
 *----------------------------------------------------------------------
 *
 * isVAReadable --
 *
 *      Verify that passed VA is accessible without crash...
 *
 * Results:
 *      TRUE if address is readable, FALSE otherwise.
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */
 
static Bool
isVAReadable(VA r)
{
   mm_segment_t old_fs;
   uint32 dummy;
   int ret;
   
   old_fs = get_fs();
   set_fs(get_ds());
   r = APICR_TO_ADDR(r, APICR_VERSION);
   ret = HostIF_CopyFromUser(&dummy, (void*)r, sizeof(dummy));
   set_fs(old_fs);
   return ret == 0;
}
#endif


/*
 *----------------------------------------------------------------------
 *
 * SetVMAPICPtr --
 *
 *      Sets a pointer to the APIC's virtual address in the VMDriver
 *      structure.  
 *
 * Results:
 *      None.
 *
 * Side effects:
 *      The VMDriver structure is updated.
 *
 *----------------------------------------------------------------------
 */

static void
SetVMAPICPtr(VMDriver *vm, MPN mpn)
{
   volatile void *hostapic;

   hostapic = (volatile void *) ioremap_nocache(MPN_2_MA(mpn), PAGE_SIZE);
   if (hostapic) {
      if ((APIC_VERSIONREG(hostapic) & 0xF0) == 0x10) {
	 vm->hostAPIC = (volatile uint32 (*)[4]) hostapic;
      }
   }
}


/*
 *----------------------------------------------------------------------
 *
 * ProbeAPIC --
 *
 *      Find the base physical address of the APIC.  On P6 family
 *      processors, this is done by reading the address from an MSR.
 *
 * Results:
 *      Returns the physical address of the APIC if found, 0 otherwise.
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */

MA
ProbeAPIC(VMDriver *vm,       // IN/OUT: driver state
	  Bool setVMPtr,      // IN: set a pointer to the APIC's virtual address
	  Bool forceEnable)   // IN: APIC is being enabled here in the driver 
{
   uint64 msr;
   MPN mpn;
   CPUOem cpuOem = CPUID_GetOEM();

   if (cpuOem == CPUID_OEM_INTEL) {
      uint32 version = CPUID_GetVersion();
      uint32 features = CPUID_GetFeatures();

      if ((features & CPUID_FEATURE_COMMON_MSR) &&
	  (forceEnable || (features & CPUID_FEATURE_COMMON_APIC))) {

	 /* APIC is present and enabled */
         if (CPUID_FAMILY_IS_P6(version) || CPUID_FAMILY_IS_PENTIUM4(version)) {
	    /* P6 allows APIC relocation */
	    msr = GetMSR(APIC_BASE_MSR);
	    mpn = (msr >> 12) & 0xFFFFFF;
	    if (setVMPtr) {
	       /* obtain a system address the APIC, only for P6.
		  Not recommended for P5, per Intel Book 3, page 7-16 */
	       SetVMAPICPtr(vm, mpn);
	    } else {
	       vm->hostAPIC = NULL;
	    }
	    return MPN_2_MA(mpn);
	 } else if (!forceEnable) {
	    return APIC_DEFAULT_ADDRESS;
	 }
      }
   }
   return 0;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_APICBase --
 *
 *      Lookup the APIC physical address
 *
 * Results:
 *      
 *      Returned value is APIC physical address
 *      
 *
 * Side effects:
 *     None
 *
 *----------------------------------------------------------------------
 */

MA
HostIF_APICBase(VMDriver *vm, Bool setVMPtr, Bool probe)
{
#if defined(CONFIG_SMP) || defined(CONFIG_X86_UP_IOAPIC) || defined(CONFIG_X86_UP_APIC)
   VA kAddr;
   MA ma;

   if (probe) {
      ma = ProbeAPIC(vm, setVMPtr, FALSE);
      if (ma != 0) {
	 return ma;
      }
   }

   kAddr = __fix_to_virt(FIX_APIC_BASE);
   if (!isVAReadable(kAddr)) {
      return 0;
   }
   if (setVMPtr) {
      vm->hostAPIC = (void *)kAddr;
   } else {
      vm->hostAPIC = NULL;
   }

   return MPN_2_MA(HostifVa2Mpn(kAddr));
#else
   return 0;
#endif
}


#ifdef USE_PERFCTRS_HOSTED

/* 
 * Defines for masking/unmasking PIC interrupts. 
 */
#define PIC_PRIMARY_MASK_PORT         0x21
#define PIC_SECONDARY_MASK_PORT       0xA1

#define MaskPICIRQs(mask1, mask2)        \
   mask1 = INB(PIC_PRIMARY_MASK_PORT);   \
   OUTB(PIC_PRIMARY_MASK_PORT, 0xff);    \
   mask2 = INB(PIC_SECONDARY_MASK_PORT); \
   OUTB(PIC_SECONDARY_MASK_PORT, 0xff);     

#define UnmaskPICIRQs(mask1, mask2)      \
   OUTB(PIC_PRIMARY_MASK_PORT, mask1);   \
   OUTB(PIC_SECONDARY_MASK_PORT, mask2); 


/*
 *----------------------------------------------------------------------
 *
 * HostIF_APICEnable --
 *
 *      Enable the APIC, if not already enabled.  The APIC is put into
 *      through local mode.  In this mode the APIC passes interrupts 
 *      along to the processor just as if they had come directly from the PIC.
 *
 * Results:
 *      Returned value is APIC physical address.
 *      
 * Side effects:
 *      APIC gets enabled.      
 *
 *----------------------------------------------------------------------
 */

MA 
HostIF_APICEnable(VMDriver *vm)
{
   MA ma;
   volatile void *va;
   volatile uint8 picMask1, picMask2;
   uint32 apicMSR, dummy;
   uint32 tempMSR;
   uint32 flags;

   ASSERT(vm);
   ASSERT(vm->hostAPIC == 0);

   /*
    *  Find the APIC's physical address. 
    */
   ma = ProbeAPIC(vm, FALSE, TRUE);
   if (ma == 0) {
      printk(KERN_WARNING "/dev/vmmon: Unable to find APIC's physaddr\n");
      return 0;
   }

   /*
    * Map APIC's physical address into a virtual address.
    */
   va = (volatile void *) ioremap_nocache(ma, PAGE_SIZE);
   if (va == 0) {
      printk(KERN_WARNING "/dev/vmmon: Unable to map APIC at physaddr 0x%Lx\n", ma);
      return 0;
   } 

   /*
    * Mask interrupts and enable the APIC.  Intel's Software Developer's Guide
    * Guide Vol III, Appendix E says that we need to mask PIC interrupts before
    * programming the local interrupt pins.
    */
   SAVE_FLAGS(flags); 
   CLEAR_INTERRUPTS();
   MaskPICIRQs(picMask1, picMask2);

   RDMSR(APIC_BASE_MSR, apicMSR, dummy);
   tempMSR = apicMSR;

   if (!(apicMSR & APIC_MSR_ENABLED)) {
      apicMSR |= APIC_MSR_ENABLED;

      /*
       * The enable bit of the APIC_BASE_MSR must be set before
       * we can even read the APIC.
       */
      WRMSR(APIC_BASE_MSR, apicMSR, dummy);
   }

   /*
    * Set up the local vector table entries.
    */
   SET_APIC_REG(va, APICR_SVR, APIC_SVR_ONES|APIC_SVR_VECTOR|APIC_SVR_APICENABLE);
   SET_APIC_REG(va, APICR_LVT0, APIC_VTE_MODE_EXTINT);
   SET_APIC_REG(va, APICR_LVT1, APIC_VTE_MODE_NMI);
   SET_APIC_REG(va, APICR_ERRLVT, APIC_VTE_MASK);
   SET_APIC_REG(va, APICR_TIMERLVT, APIC_VTE_MASK);

   UnmaskPICIRQs(picMask1, picMask2);
   RESTORE_FLAGS(flags); 

   vm->hostAPIC =  (volatile uint32 (*)[4]) va;
   return ma;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_APICSetPerfCtr --
 *
 *      Set the performance counter entry in the APIC. 
 *
 * Results:
 *      TRUE if successful, FALSE otherwise.
 *      
 * Side effects:
 *      APIC's PCLVT register is written.
 *
 *----------------------------------------------------------------------
 */

Bool
HostIF_APICSetPerfCtr(VMDriver *vm,   // IN: driver state
		      int gate)       // IN: interrupt gate for perfctr interrupts
{
   volatile void *apic;
   uint32 maxlvt;


   if (vm->hostAPIC == 0) {
      printk(KERN_WARNING "PerfCtr: Could not set PCLVT, APIC not available\n");
      return FALSE;
   }

   apic = (volatile void *) vm->hostAPIC;
   maxlvt = APIC_MAXLVT(apic);

   /*
    * We need maximum LVT entries to be >= 4 in order for there to be
    * an entry for the performance counters.
    */
   if (maxlvt >= 4) {
      SET_APIC_REG(apic, APICR_PCLVT, APIC_VTE_MODE_FIXED | gate);
   } else {
      printk(KERN_WARNING "PerfCtr: Could not set PCLVT, APIC maxlvt %d < 4", maxlvt);
      return FALSE;
   }

   return TRUE;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_APICAck --
 *
 *      Send an ack to the APIC
 *
 * Results:
 *      None.
 *      
 * Side effects:
 *      APIC's EOI register is written.
 *
 *----------------------------------------------------------------------
 */

void 
HostIF_APICAck(VMDriver *vm)
{
   volatile void *apic;
   volatile uint32 dummy;

   apic = (volatile void *) vm->hostAPIC;

   /*
    * Send the APIC an EOI.  Dummy read is copied from Linux 
    * ack_APIC_irq() routine. 
    */
   if (apic) {
      dummy = GET_APIC_REG(apic, APICR_SVR);
      SET_APIC_REG(apic, APICR_EOI, 0);
   }
}

#endif // ifdef USE_PERFCTRS_HOSTED


/*
 *----------------------------------------------------------------------
 *
 * HostIF_IOAPICBase --
 *
 *      Lookup the IO-APIC physical address
 *
 * Results:
 *      
 *      Returned value is IO-APIC physical address
 *      
 *
 * Side effects:
 *     None
 *
 *----------------------------------------------------------------------
 */
#define PCI_CONF_ADDR_REG_PORT   0xcf8
#define PCI_CONF_DATA_REG_PORT   0xcfc
#define VMWARE__PCI_DEVICE_ID_INTEL_82371SB 0x70008086
#define VMWARE__PCI_DEVICE_ID_INTEL_82371AB 0x71108086

MA
HostIF_IOAPICBase(VMDriver *vm)
{
#if defined(CONFIG_SMP) || defined(CONFIG_X86_UP_IOAPIC)
   int bus, slot, confword;
   uint32 id, apicbase;

   bus = 0;
   for (slot = 0; slot < 32; slot++) {
      confword = 0x80000000 | (bus << 16) |  (slot << 11);
      OUT32(PCI_CONF_ADDR_REG_PORT, confword);
      id = IN32(PCI_CONF_DATA_REG_PORT);
      if ((id == VMWARE__PCI_DEVICE_ID_INTEL_82371SB) ||
	  (id == VMWARE__PCI_DEVICE_ID_INTEL_82371AB)) {
#ifdef VMX86_DEVEL
	 Log("IOAPIC: detected %s on PCI bus %d, slot %d\n",
	     (id == VMWARE__PCI_DEVICE_ID_INTEL_82371SB) ? "PIIX3" : "PIIX4",
	     bus, slot);
#endif
	 confword |= 20; /* register 80 */
	 OUT32(PCI_CONF_ADDR_REG_PORT, confword);
	 apicbase = IN32(PCI_CONF_DATA_REG_PORT);
	 apicbase = apicbase & 0x3f;
	 return (IOAPIC_DEFAULT_ADDRESS | (apicbase << 10));
      }
   }
   
   return MPN_2_MA(HostifVa2Mpn(__fix_to_virt(VMWARE__FIX_IO_APIC_BASE)));
#else
   return 0;
#endif
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_SemaphoreWait --
 *
 *    Perform the semaphore wait (P) operation, possibly blocking.
 *
 * Result:
 *    1 (which equals MX_WAITNORMAL) if success, 
 *    negated error code otherwise.
 *
 * Side-effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

int   
HostIF_SemaphoreWait(VMDriver *vm, 
                     Vcpuid vcpuid,
                     int fd)
{
   struct file *file;
   mm_segment_t old_fs;
   char ch;
   int res;

   file = vmware_fget(fd);
   if (file == NULL) {
      return MX_WAITERROR;
   }

   old_fs = get_fs();
   set_fs(get_ds());

   {
      compat_poll_wqueues table;
      poll_table *wait;
      unsigned int mask;
      
      compat_poll_initwait(wait, &table);
      current->state = TASK_INTERRUPTIBLE;
      mask = file->f_op->poll(file, wait);
      if (!(mask & (POLLIN | POLLERR | POLLHUP))) {
#ifdef KERNEL_2_4_0
	 vm->vmhost->vcpuSemaTask[vcpuid] = current;
#else
	 vm->vmhost->vcpuSemaWait[vcpuid] = wait;
#endif
	 schedule_timeout(MX_WAITTIMEOUT * HZ / 1000);	// ms converted to Hz
#ifdef KERNEL_2_4_0
	 vm->vmhost->vcpuSemaTask[vcpuid] = NULL;
#else
	 vm->vmhost->vcpuSemaWait[vcpuid] = NULL;
#endif
      }
      current->state = TASK_RUNNING;
      compat_poll_freewait(wait, &table);
   }

   res = file->f_op->read(file, &ch, 1, &file->f_pos);

   set_fs(old_fs);
   compat_fput(file);

   /*
    * Handle benign errors:
    * EAGAIN is MX_WAITTIMEOUT.
    * The signal-related errors are all mapped into MX_WAITINTERRUPTED.
    */

   switch (res) {
   case -EAGAIN:
      res = MX_WAITTIMEDOUT;
      break;
   case -EINTR:
   case -ERESTART:
   case -ERESTARTSYS:
   case -ERESTARTNOINTR:
   case -ERESTARTNOHAND:
      res = MX_WAITINTERRUPTED;
      break;
   }
   return res;
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_SemaphoreForceWakeup --
 *
 *    If the target process is sleeping lightly(i.e. TASK_INTERRUPTIBLE)
 *    wake it up.
 *
 * Result:
 *    None.
 *
 * Side-effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

void 
HostIF_SemaphoreForceWakeup(VMDriver *vm, 
                            Vcpuid vcpuid)
{
#ifdef KERNEL_2_4_0
   struct task_struct *t;

   t = vm->vmhost->vcpuSemaTask[vcpuid];
   if (t && (t->state & TASK_INTERRUPTIBLE)) {
      wake_up_process(t);
   }
#else
   poll_table *wait = vm->vmhost->vcpuSemaWait[vcpuid];

   if (wait != NULL) {
      ASSERT(wait->nr == 1);
      wake_up(wait->entry->wait_address);
   }
#endif
}


/*
 *-----------------------------------------------------------------------------
 *
 * HostIF_SemaphoreSignal --
 *
 *    Perform the semaphore signal (V) operation.
 *
 * Result:
 *    1 if success, negated error code otherwise.
 *
 * Side-effects:
 *    None
 *
 *-----------------------------------------------------------------------------
 */

int
HostIF_SemaphoreSignal(int fd) // IN
{
   struct file *file;
   mm_segment_t old_fs;
   int res;

   file = vmware_fget(fd);
   if (!file) {
      return MX_WAITERROR;
   }
   old_fs = get_fs();
   set_fs(get_ds());
   {
      char ch;
      res = file->f_op->write(file, &ch, 1, &file->f_pos);
   }
   set_fs(old_fs);
   compat_fput(file);

   /*
    * Handle benign errors:
    * EAGAIN is MX_WAITTIMEOUT.
    * The signal-related errors are all mapped into MX_WAITINTERRUPTED.
    */

   switch (res) {
   case -EAGAIN:
      res = MX_WAITTIMEDOUT;
      break;
   case -EINTR:
   case -ERESTART:
   case -ERESTARTSYS:
   case -ERESTARTNOINTR:
   case -ERESTARTNOHAND:
      res = MX_WAITINTERRUPTED;
      break;
   }
   return res;
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_IPI --
 *
 *    If the passed VCPU threads are on some CPUs in the system, attempt
 *    to hit them with an IPI. On Linux hosts, we abuse a mechanism that
 *    allows us to send broadcast IPIs. This is a big hammer, but we feel
 *    ok using it on the grounds that we don't license the hosted products
 *    for huge machines.
 *
 * Result:
 *    0 if success, negated error code otherwise.
 *
 *----------------------------------------------------------------------
 */

int
HostIF_IPI(VMDriver *vm, VCPUSet vcs)
{
   return compat_smp_call_function(LinuxDriverIPIHandler, NULL, FALSE, FALSE);
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_UserCall --
 *
 *	Ask the main thread to process a cross user call.
 *
 * Results:
 *	None.
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */

void
HostIF_UserCall(VMDriver *vm,
                Vcpuid vcpuid)
{
   ASSERT(!vm->vmhost->replyWaiting[vcpuid]);
   vm->vmhost->replyWaiting[vcpuid] = TRUE;
   atomic_inc(&vm->vmhost->pendingUserCalls);
   wake_up(&vm->vmhost->callQueue);
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_UserCallWait --
 *
 *	Wait for a cross user call to complete.
 *
 * Results:
 *	TRUE if successful (call completed).
 *	FALSE otherwise
 *	   signals pending,
 *	   timed out,
 *	   or otherwise unsuccessful
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */

Bool
HostIF_UserCallWait(VMDriver *vm,
                    Vcpuid vcpuid)
{
   if (vm->vmhost->replyWaiting[vcpuid]) {
      wait_queue_t wait;
      wait_queue_head_t *q = &vm->vmhost->replyQueue[vcpuid];

      current->state = TASK_INTERRUPTIBLE;
      init_waitqueue_entry(&wait, current);
      add_wait_queue(q, &wait);
      if (vm->vmhost->replyWaiting[vcpuid]) {
	 schedule_timeout(MX_WAITTIMEOUT * HZ / 1000);	// ms converted to Hz
      }
      current->state = TASK_RUNNING;
      remove_wait_queue(q, &wait);
   }

   return !vm->vmhost->replyWaiting[vcpuid] && !signal_pending(current);
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_AwakenVcpu --
 *
 *      Make the VCPU thread continue upon completion of a user call.
 *
 * Results:
 *      None.
 *
 * Side effects:
 *      VCPU thread continues.
 *
 *----------------------------------------------------------------------
 */

void
HostIF_AwakenVcpu(VMDriver *vm,
                  Vcpuid vcpuid)
{
   ASSERT(vm->vmhost->replyWaiting[vcpuid]);
   vm->vmhost->replyWaiting[vcpuid] = FALSE;
   wake_up(&vm->vmhost->replyQueue[vcpuid]);
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_AckUserCall --
 *
 *      Host-dependent part of acknowledgement of user call notification.
 *
 * Results:
 *      None.
 *
 * Side effects:
 *      Yes.
 *
 *----------------------------------------------------------------------
 */

void
HostIF_AckUserCall(VMDriver *vm,
                   Vcpuid vcpuid)
{
   atomic_sub(1, &vm->vmhost->pendingUserCalls);
}


/*
 *----------------------------------------------------------------------
 *
 * HostIFFillCPUID --
 *
 *      Callback function to collect cpuid information on
 *      current logical CPU.
 *
 *	Function must not block, and is invoked from interrupt context.
 *
 * Results:
 *      None.
 *
 * Side effects:
 *      None.
 *
 *----------------------------------------------------------------------
 */

static void 
HostIFFillCPUID(void *clientData) // OUT 
{
   CPUIDInfo *info = (CPUIDInfo*) clientData;
   unsigned int pid = smp_processor_id();

   if (pid < info->numLogicalCPUs) {
      CPUIDRegs *reg = &info->regs[pid];

      cpuid(info->eaxArg, &reg->eax, &reg->ebx, &reg->ecx, &reg->edx);
   }
}


/*
 *----------------------------------------------------------------------
 *
 * HostIF_GetAllCpuInfo --
 *
 *      Collect cpuid information on all logical CPUs.
 *
 * Results:
 *      None.
 *
 * Side effects:
 *      Cpuid array is filled.
 *
 *----------------------------------------------------------------------
 */

void
HostIF_GetAllCpuInfo(CPUIDInfo *info) // OUT: output of cpuid on all logical cpus
{
   HostIFFillCPUID((void*)info);
   (void)compat_smp_call_function(HostIFFillCPUID, (void*)info, 1, 1);
}




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

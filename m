Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYO2z-0006Tz-GZ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 05:53:13 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYO2w-0002bw-Rf	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 05:53:13 -0700
Message-Id: <200505180420.j4I4KDvv017310@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/9] UML - Page fault fixes
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
Date: Wed, 18 May 2005 00:20:13 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Any access to a PROT_NONE page should segfault the process.  A JVM seems to
do this on purpose.  Also, Al noticed some bogus code, which is now deleted.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/trap_kern.c	2005-05-17 16:34:45.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/trap_kern.c	2005-05-17 18:03:10.000000000 -0400
@@ -57,10 +57,11 @@ int handle_page_fault(unsigned long addr
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
+
+        if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
+                goto out;
+
 	page = address & PAGE_MASK;
-	pgd = pgd_offset(mm, page);
-	pud = pud_offset(pgd, page);
-	pmd = pmd_offset(pud, page);
 	do {
  survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

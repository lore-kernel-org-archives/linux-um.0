Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BeuPF-0007vM-C4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 04:34:37 -0700
Received: from ns.sysgo.de ([213.68.67.98] helo=mailgate.sysgo.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BeuPE-0006MQ-3p for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 04:34:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by mailgate.sysgo.de (Postfix) with ESMTP id 34D4447C34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Jun 2004 13:33:59 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mailgate.sysgo.de (Postfix) with ESMTP id 294DF47C34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Jun 2004 13:33:59 +0200 (CEST)
Message-ID: <40E0036D.2070108@sysgo.de>
From: azu <azu@sysgo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Patch for arch/um/kernel/trap_kern.c to fix bad panic
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
Date: Mon, 28 Jun 2004 13:39:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I triggered the following panic from userspace in skas mode
by mapping pages above 0xa0000000 ...

The check is useless in skas-mode (kernel faults get filtered
in segv() before handle_page_fault() is called),
so I added an ifdef for tt mode.


-Alex


--- orig/arch/um/kernel/trap_kern.c     2004-06-28 13:08:41.000000000 +0200
+++ u4/arch/um/kernel/trap_kern.c       2004-06-28 13:08:52.000000000 +0200
@@ -52,8 +52,10 @@
         if(is_write && !(vma->vm_flags & VM_WRITE))
                 goto out;
         page = address & PAGE_MASK;
+#ifdef CONFIG_MODE_TT
         if(page == (unsigned long) current + PAGE_SIZE)
                 panic("Kernel stack overflow");
+#endif
         pgd = pgd_offset(mm, page);
         pmd = pmd_offset(pgd, page);
         do {




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

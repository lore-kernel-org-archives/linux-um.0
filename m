Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AUqJx-00012M-PW
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 08:39:17 -0800
Received: from linuxhacker.ru
	([217.76.32.60] helo=shrek.linuxhacker.ru ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AUqJx-0005IF-4R
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 08:39:17 -0800
From: Oleg Drokin <green@linuxhacker.ru>
Message-ID: <20031212163816.GA10993@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] export ket_kmem_end()
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Dec 2003 18:38:17 +0200
To: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Hello!

   The functions get_kmem_end() should be exported which patch below
   does.
   This function is called as part of calculation of various FIXADDR_*
   constants (and hence everything that depends on those). If some
   module tries to use one of such "constants", it is doomed.
   Please apply.

--- uml-2.4/arch/um/kernel/ksyms.c.orig	2003-12-12 18:16:28.000000000 +0200
+++ uml-2.4/arch/um/kernel/ksyms.c	2003-12-12 18:16:39.000000000 +0200
@@ -33,6 +33,7 @@
 EXPORT_SYMBOL(flush_tlb_range);
 EXPORT_SYMBOL(host_task_size);
 EXPORT_SYMBOL(arch_validate);
+EXPORT_SYMBOL(get_kmem_end);
 
 EXPORT_SYMBOL(region_pa);
 EXPORT_SYMBOL(region_va);

Bye,
    Oleg


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

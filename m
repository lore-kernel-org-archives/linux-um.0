Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFcva-0000qY-2h for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:23:46 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CFcvV-000865-Ox for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:23:45 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041007175526.E04FC5000@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: remove wrong declaration
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
Date: Thu, 07 Oct 2004 19:55:26 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Avoid compile failure due to the addition of sys_timer_create to linux/syscalls.h

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/sys_call_table.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/kernel/sys_call_table.c~uml-remove-wrong-decl arch/um/kernel/sys_call_table.c
--- linux-2.6.9-current/arch/um/kernel/sys_call_table.c~uml-remove-wrong-decl	2004-10-07 19:09:54.946142664 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/sys_call_table.c	2004-10-07 19:09:59.675423704 +0200
@@ -47,7 +47,6 @@ extern syscall_handler_t sys_rt_sigactio
 extern syscall_handler_t sys_sigaltstack;
 extern syscall_handler_t sys_vfork;
 extern syscall_handler_t sys_mmap2;
-extern syscall_handler_t sys_timer_create;
 extern syscall_handler_t old_mmap_i386;
 extern syscall_handler_t old_select;
 extern syscall_handler_t sys_modify_ldt;
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

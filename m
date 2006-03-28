Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOO8t-0004Wg-C9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 16:02:31 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOO8r-0000uy-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 16:02:31 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060328235650.13838.60908.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 1/7] uml idle thread needn't take access to init_mm
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
Date: Wed, 29 Mar 2006 01:56:50 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Comparing this code which is the actual body of the arch-independent cpu_idle(),
it is clear that it's unnecessary to set ->mm and ->active_mm; beyond that, a
kernel thread is not supposed to have ->mm != NULL, only active_mm.

This showed up because I used the assumption (which is IMHO valid) that kernel
thread have their ->mm == NULL, and it failed for this thread.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/process_kern.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
index 3113cab..f9948fd 100644
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -185,10 +185,6 @@ void default_idle(void)
 {
 	CHOOSE_MODE(uml_idle_timer(), (void) 0);
 
-	atomic_inc(&init_mm.mm_count);
-	current->mm = &init_mm;
-	current->active_mm = &init_mm;
-
 	while(1){
 		/* endless idle loop with no priority at all */
 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLDTu-0007VJ-Ci for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 21:26:18 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CLDTt-0001gf-CM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 21:26:18 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041023035318.EB65795D1@zion.localdomain>
Subject: [uml-devel] [patch 3/5] uml-unused-label
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
Date: Sat, 23 Oct 2004 05:53:18 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/tt/process_kern.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/kernel/tt/process_kern.c~uml-unused-label arch/um/kernel/tt/process_kern.c
--- linux-2.6.9-current/arch/um/kernel/tt/process_kern.c~uml-unused-label	2004-10-12 02:13:03.528818872 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/tt/process_kern.c	2004-10-12 02:13:23.258819456 +0200
@@ -305,7 +305,6 @@ int copy_thread_tt(int nr, unsigned long
 
 	change_sig(SIGUSR1, 0);
 	err = 0;
- out:
 	return(err);
 }
 
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

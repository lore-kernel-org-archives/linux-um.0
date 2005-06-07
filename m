Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfeCv-0001ud-JL	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 06:33:29 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DfeCs-0000Eb-Hc
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 06:33:28 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050607004216.72956EB2A@zion.home.lan>
Subject: [uml-devel] [patch 1/2] uml: complete "[RFC] uml: add and use generic
	hw_controller_type->release"
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
Date: Tue, 07 Jun 2005 02:42:16 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, mingo@redhat.com, blaisorblade@yahoo.it


This occurrence of free_irq_by_irq_and_dev() was missed when converting UML to
the use of hw_controller_type->release.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/line.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/drivers/line.c~uml-gen-irq-release-missed arch/um/drivers/line.c
--- linux-2.6.git/arch/um/drivers/line.c~uml-gen-irq-release-missed	2005-06-07 02:25:22.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/line.c	2005-06-07 02:25:22.000000000 +0200
@@ -756,7 +756,6 @@ static void unregister_winch(struct tty_
         if(winch->pid != -1)
                 os_kill_process(winch->pid, 1);
 
-        free_irq_by_irq_and_dev(WINCH_IRQ, winch);
         free_irq(WINCH_IRQ, winch);
         list_del(&winch->list);
         kfree(winch);
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

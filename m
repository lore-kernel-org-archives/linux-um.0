Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVHZC-0002Y7-Ku	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:21:38 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DVHZA-0006W6-Re	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:21:38 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050509224512.A9DFB13C214@zion>
Subject: [uml-devel] [patch 2/6] uml: critical change memcpy to memmove
	[critical, for 2.6.12]
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
Date: Tue, 10 May 2005 00:45:12 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Replace one memcpy() call with overlapping source and dest arguments with one
call to memmove(), to avoid data corruption.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/irq_user.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/irq_user.c~uml-critical-change-memcpy-to-memmove arch/um/kernel/irq_user.c
--- linux-2.6.12/arch/um/kernel/irq_user.c~uml-critical-change-memcpy-to-memmove	2005-05-02 17:54:20.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/irq_user.c	2005-05-02 17:54:20.000000000 +0200
@@ -236,9 +236,15 @@ static void free_irq_by_cb(int (*test)(s
 				       (*prev)->fd, pollfds[i].fd);
 				goto out;
 			}
-			memcpy(&pollfds[i], &pollfds[i + 1],
-			       (pollfds_num - i - 1) * sizeof(pollfds[0]));
+
 			pollfds_num--;
+
+			/* This moves the *whole* array after pollfds[i] (though
+			 * it doesn't spot as such)! */
+
+			memmove(&pollfds[i], &pollfds[i + 1],
+			       (pollfds_num - i) * sizeof(pollfds[0]));
+
 			if(last_irq_ptr == &old_fd->next) 
 				last_irq_ptr = prev;
 			*prev = (*prev)->next;
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

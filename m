Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVHGn-0000tO-4Q	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:02:37 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DVHGl-0002mI-CZ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:02:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100051.26918.blaisorblade@yahoo.it>
Subject: [uml-devel] 3-level pagetables broken on i386
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
Date: Tue, 10 May 2005 00:51:26 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

  CC      arch/um/kernel/mem.o
arch/um/kernel/mem.c: In function `fixaddr_user_init':
arch/um/kernel/mem.c:198: warning: right shift count >= width of type
(because you right-shift addr by 32 bits)
  CC      arch/um/kernel/mem_user.o
  CC      arch/um/kernel/physmem.o
  CC      arch/um/kernel/process.o
  CC      arch/um/kernel/process_kern.o
arch/um/kernel/process_kern.c: In function `um_virt_to_phys':
arch/um/kernel/process_kern.c:248: warning: cast to pointer from integer of 
different size
(because you cast a long long to a 32-bit pointer).

If 3-level pagetables is only for x86-64, then let me know and I'll add an 
appropriate dependency. If not (and IIRC it worked some time ago), then 
choose how to fix that.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkXli-00033j-Lk	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 18:41:38 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DkXlf-0001zP-Qm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 18:41:38 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050621013522.678D355FCD@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml: add profile_pc for i386
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
Date: Tue, 21 Jun 2005 03:35:21 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Cope with a conditional i386 definition, which is wrong for UML. Before we
just used that one, but it wasn't defined for CONFIG_SMP, so in that case we
got link errors.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/ptrace-i386.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN include/asm-um/ptrace-i386.h~uml-add-profile-pc-i386 include/asm-um/ptrace-i386.h
--- linux-2.6.git/include/asm-um/ptrace-i386.h~uml-add-profile-pc-i386	2005-06-07 18:57:00.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/ptrace-i386.h	2005-06-07 18:59:26.000000000 +0200
@@ -32,6 +32,10 @@
 #define PT_REGS_SYSCALL_RET(r) PT_REGS_EAX(r)
 #define PT_FIX_EXEC_STACK(sp) do ; while(0)
 
+/* Cope with a conditional i386 definition. */
+#undef profile_pc
+#define profile_pc(regs) PT_REGS_IP(regs)
+
 #define user_mode(r) UPT_IS_USER(&(r)->regs)
 
 #endif
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

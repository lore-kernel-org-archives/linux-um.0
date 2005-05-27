Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTIP-0006RG-0b	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:53 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbTHs-0006sj-VE	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:52 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050527003840.7A4A41AEE86@zion.home.lan>
Subject: [uml-devel] [patch 3/8] uml: fix PREEMPT_ACTIVE
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
Date: Fri, 27 May 2005 02:38:40 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, paulus@samba.org, mingo@elte.hu


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>

This is a continuation for UML of:

http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbDYKQ

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/thread_info.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-um/thread_info.h~uml-fix-interrupts include/asm-um/thread_info.h
--- linux-2.6.git/include/asm-um/thread_info.h~uml-fix-interrupts	2005-05-27 02:30:48.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/thread_info.h	2005-05-27 02:36:42.000000000 +0200
@@ -62,7 +62,7 @@ static inline struct thread_info *curren
 
 #endif
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
 
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
_


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

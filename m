Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJqHD-0002Wg-Jm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 04:08:51 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HJqHB-0004bG-Q2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 04:08:51 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Wed, 21 Feb 2007 13:07:41 +0100
Message-Id: <11720596612428-git-send-email-blaisorblade@yahoo.it>
Subject: [uml-devel] x86_64: PTRACE_[GS]ET_THREAD_AREA should be accepted
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch backports from 2.6.19 a fix to a 2.6.18 regression.

Like for PTRACE_OLDSETOPTIONS, we should fix PTRACE_[GS]ET_THREAD_AREA. This had
been done already for 2.6.19, so this is for 2.6.18-stable only.
This was tested with UML/32bit as API consumer, both before and after this
patch.

Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.18/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux-2.6.18.orig/arch/x86_64/ia32/ptrace32.c
+++ linux-2.6.18/arch/x86_64/ia32/ptrace32.c
@@ -241,6 +241,8 @@ asmlinkage long sys32_ptrace(long reques
 	case PTRACE_SYSCALL:
 	case PTRACE_OLDSETOPTIONS:
 	case PTRACE_SETOPTIONS:
+	case PTRACE_SET_THREAD_AREA:
+	case PTRACE_GET_THREAD_AREA:
 		return sys_ptrace(request, pid, addr, data); 
 
 	default:


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

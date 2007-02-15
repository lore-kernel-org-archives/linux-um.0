Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHWYB-0008Dy-VA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 18:40:48 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HHWY9-0003k2-9N
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 18:40:47 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 15 Feb 2007 03:34:23 +0100
Message-Id: <11715068631914-git-send-email-blaisorblade@yahoo.it>
Subject: [uml-devel] x86_64: fix 2.6.18 regression - PTRACE_OLDSETOPTIONS
	should be accepted
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
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Also PTRACE_OLDSETOPTIONS should be accepted, as done by kernel/ptrace.c and
forced by binary compatibility. UML/32bit breaks because of this - since it is wise
enough to use PTRACE_OLDSETOPTIONS to be binary compatible with 2.4 host
kernels.

Until 2.6.17 (commit f0f2d6536e3515b5b1b7ae97dc8f176860c8c2ce) we had:

       default:
                return sys_ptrace(request, pid, addr, data);

Instead here we have:
        case PTRACE_GET_THREAD_AREA:
	case ...:
                return sys_ptrace(request, pid, addr, data);

        default:
                return -EINVAL;

This change was a style change - when a case is added, it must be explicitly
tested this way. In this case, not enough testing was done.

Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux-2.6.git.orig/arch/x86_64/ia32/ptrace32.c
+++ linux-2.6.git/arch/x86_64/ia32/ptrace32.c
@@ -246,6 +246,7 @@ asmlinkage long sys32_ptrace(long reques
 	case PTRACE_SINGLESTEP:
 	case PTRACE_DETACH:
 	case PTRACE_SYSCALL:
+	case PTRACE_OLDSETOPTIONS:
 	case PTRACE_SETOPTIONS:
 	case PTRACE_SET_THREAD_AREA:
 	case PTRACE_GET_THREAD_AREA:

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

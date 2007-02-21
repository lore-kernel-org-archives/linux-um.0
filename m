Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJgfJ-0002P7-01 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Feb 2007 17:53:05 -0800
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HJgfI-0006Pd-8G
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Feb 2007 17:53:05 -0800
Date: Tue, 20 Feb 2007 17:51:37 -0800
From: Greg KH <greg@kroah.com>
Message-ID: <20070221015137.GS3684@kroah.com>
References: <20070221014413.282048309@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline;
	filename="x86_64-fix-2.6.18-regression-ptrace_oldsetoptions-should-be-accepted.patch"
In-Reply-To: <20070221014927.GA3684@kroah.com>
Subject: [uml-devel] [patch 18/18] x86_64: fix 2.6.18 regression -
	PTRACE_OLDSETOPTIONS should be accepted
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Justin Forbes <jmforbes@linuxtx.org>, Andi Kleen <ak@suse.de>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, torvalds@linux-foundation.org, Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>, alan@lxorguk.ukuu.org.uk

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/x86_64/ia32/ptrace32.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.7.orig/arch/x86_64/ia32/ptrace32.c
+++ linux-2.6.18.7/arch/x86_64/ia32/ptrace32.c
@@ -239,6 +239,7 @@ asmlinkage long sys32_ptrace(long reques
 	case PTRACE_SINGLESTEP:
 	case PTRACE_DETACH:
 	case PTRACE_SYSCALL:
+	case PTRACE_OLDSETOPTIONS:
 	case PTRACE_SETOPTIONS:
 		return sys_ptrace(request, pid, addr, data); 
 

--

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

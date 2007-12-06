Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J08UN-0000d9-2L for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 20:37:31 -0800
Received: from jade.aracnet.com ([216.99.193.136])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J08UL-00006m-OI
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 20:37:31 -0800
Message-ID: <47577C8A.8060104@BitWagon.com>
Date: Wed, 05 Dec 2007 20:37:30 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
References: <4755E360.4030505@BitWagon.com>	<20071205002223.GC10763@c2.user-mode-linux.org>	<4755F4EC.4050902@BitWagon.com>
	<20071206021016.GB10961@c2.user-mode-linux.org>
In-Reply-To: <20071206021016.GB10961@c2.user-mode-linux.org>
Subject: Re: [uml-devel] reading uninit memory in do_io (ubd_kern.c)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> It'll be easier to let the userspace child escape - invent an
> annotation for "don't follow this clone".

Thanks for the tip.  I was getting stuck trying to figure out the
ptrace() shenanigans involved with the stub [skas0 mode] that turns
SIGSEGV into SIGUSR1.  Valgrind has its own ideas about what
should happen with signals, and the ptracing gets complicated.

> Longer-term, following this clone and allowing full-system analysis
> would require some thought.  The first problem, of course, is that
> about the first the stub does in the new process is unmap everything
> but itself, including valgrind.

The very first thing that the skas0 stub does is field SIGSEGV because
the page which contains the entry point of the PT_INTERP of /sbin/init
is not present.   The signal handler in the stub forwards this SIGSGEV
to uml as SIGUSR1, and the ptrace()ing code inside uml "understands"
what the child is doing.  Not so when valgrind (or any other
virtualization) is involved.  Perhaps valgrind could recognize the
skas0 stub (SIGSEGV.sa_handler >= 0xbffe0000, etc.) and adapt,
or perhaps both valgrind and uml should cooperate here.  I'm still
puzzling over this one.

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2qUd-00019b-WE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 03:42:51 -0800
Received: from mekong.darkman.de
	([217.69.160.53] helo=mail.darkman.de ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B2qUY-0004l7-L8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 03:42:46 -0800
Message-ID: <405596A9.4020601@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] host context switch reduction
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
In-Reply-To: <20040229043549.GA8583@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 15 Mar 2004 12:42:33 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> The patches below are from Laurent Vivier who didn't make them public.  They
> add a new feature to ptrace on the host which cuts down on the number of
> context switches needed for a UML system call, plus makes UML use it.
> 
> There's some interest in this, so I'm putting it out as-is.  I haven't played
> with it.

Well, we did now a bit. First, we need to change the patch a bit:
the patch for uml failed in arch/um/kernel/skas/process.c.
There was a call:
err = ptrace(PTRACE_SYSCALL, userspace_pid, 0, 0);
which is now:
err = ptrace(PTRACE_SYSCALL, pid, 0, 0);

so we changed all userspace_pid's in the patch to just pid. After that,
the uml kernel was ready to build which was done without any error.
But UML seem to go crazy a bit with the patch. In 2 of 3 times uml
crashed at startup:
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Lernel panic: check_ptrace : ptrace failed, errno = 3
In idle task - not syncing

Well, but since it sometimes starts we just start it as long as
it need to run ;) (for testing ok..)


> Laurent did some performance testing and found ~40% speedup on a getpid
> loop, and a 3.5% speedup on a kernel build.

Well, we just looked at the context switches. We started 3 UMLs which
were doing a make world for xfree. Without patches the number of
context switches per second was around 60k, with the patch it was around
40k - so it's noticeable, at least from the cs.

Sven







-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

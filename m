Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6wix-0006Hl-As for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 12:42:51 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C6wiu-0005Ha-Tv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 12:42:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] handle_trap - failed to wait at end of syscall
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<411CE23C.4070903@nortelnetworks.com>
	<4145BF3F.3090502@nortelnetworks.com>
In-Reply-To: <4145BF3F.3090502@nortelnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409132139.33256.blaisorblade_spam@yahoo.it>
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
Date: Mon, 13 Sep 2004 21:39:33 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, Jeff Dike <jdike@addtoit.com>

On Monday 13 September 2004 17:39, Joe Marzot wrote:
> remeber this one?...the latest take on this is that because we launch
> UMLs from a perl script (using fork/exec) when the perl script exits a
> SIGHUP is transmitted to the UML proc which sometimes interrupts a
> waitpid()...if that interruption occurs during the nullification of a
> syscall (now that I know what that means:) then you get a kernel panic
> like below.

> I made a small fix that seems to be working for me and looks like what's
> going on in CATCH_EINTR

> can't do this globally in CATCH_EINTR since some waitpids don't check
> status...maybe they should...maybe there is a more correct way to do
> this altogether...
I'm going to merge something like this. Also, sorry - it's about a month that 
I should do this and keep forgetting to work on other stuff.

However, it is not possible nor desirable to do this in CATCH_EINTR - retry if 
errno == EINTR is a general rule valid in every Unix program ever, while this 
is very specific to this call.

> do {
>    CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
> } while (WIFSTOPPED(status) && (STOPSIG(status) == SIGHUP))

I'll turn that to STOPSIG(status) != SIGTRAP. I'm getting the same problem 
with SIGSEGV instead (IIRC).

However, maybe that must be != SIGTRAP and != <other signal>. I don't think 
so, but I must check to be sure. Jeff, what do you think?

Also, we don't make a distinction between real SIGTRAP and syscall stop.

Jeff, would you agree to using PTRACE_O_SYSGOOD?
See arch/i386/kernel/ptrace.c:do_syscall_trace for an explaination of this 
func.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ea34D-0001wX-CF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 19:25:37 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ea34B-00038g-Uh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 19:25:37 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Making UML Single Threader
Message-ID: <20051110041818.GD15002@ccure.user-mode-linux.org>
References: <200511061723.32848.rob@landley.net>
	<200511081917.22963.rob@landley.net>
	<200511090231.57373.blaisorblade@yahoo.it>
	<200511082118.58614.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511082118.58614.rob@landley.net>
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
Date: Wed, 9 Nov 2005 23:18:18 -0500
To: Rob Landley <rob@landley.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 08, 2005 at 09:18:58PM -0600, Rob Landley wrote:
> 1) Is there any documentation on SKAS0's design?  (A couple things floated by, 
> but it was piecemeal and I didn't have the necessary context.)

There was a big message when I first announced it.  Also, the changelog on
that patch was fairly comprehensive, so you can dig that out of git or 
an LKML archive or somewhere.

> 2) What's the memory layout of the various SKAS0 threads?  (Or where in the 
> code is it set up?  I can work this out for myself if necessary, it'll just 
> take a while...)

On x86:
	0 - 0x7fffe000 - normal process address space
	7fffe000 - the stub data page - contains the segfault handler and
system call stub
	7ffff000 - the stub data page - used as the segfault stack and for
passing page fault info back to UML

> 3) What can -tt mode still do that -skas0 can't?  (Something about running 
> under gdb, was it?)

SMP is about it.

On nice process names with skas0, that might not be too possible with stack
randomization.  Without that, it would be very similar to tt mode nice process
names -
	Find where the process name is on the stack for the main UML
thread - grep for argv1_begin and argv1_end to see how that's set up
	Make sure that address range won't be used in any of the process
address spaces
	Copy the process name there

Without stack randomization, the process name will be (for the main
UML thread) at an address that corresponds to the stub data page in
the processes.  You can just copy the process name there.  The one
thing you need to be careful about is that you make the segfault stack
end below that address range so the name doesn't get trashed.

With stack randomization, the process name could be almost anywhere in
the high end of the address space.  You'd have to map a page there,
copy the process name to the right spot in it, and make sure that the
process doesn't use any of its address space from there on up.  That
sounds pretty nasty to me.

The first case is fairly easy, if you want this to just work in the no
stack randomization case.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

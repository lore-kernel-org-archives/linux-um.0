Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060328200219.GC21540@ccure.user-mode-linux.org>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<200603241534.01844.blaisorblade@yahoo.it>
	<20060324172644.GB5400@ccure.user-mode-linux.org>
	<200603280030.05911.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603280030.05911.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: (implementation idea) Re: uml and nonstandard memory
	splits?
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
Date: Tue, 28 Mar 2006 15:02:19 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 27, 2006 at 11:30:05PM +0100, Blaisorblade wrote:
> That is problem #1, and exists; but when answering I thought to problem #2, 
> i.e. that the stub code currently hardcodes the location of the stub data 
> page, and that this must be fixed; I didn't notice that we must first put the
> stubs somewhere.

I see - you're one problem ahead of me.

I'm wondering if we can play some linker tricks for this.  Stick a
word of data on the code page and put the data page address in it.
Then the stub just reads that in order to get the data.

> 
> So I remembered that trick to get EIP which I read time ago (the purpose was 
> to make some code Position-Independent exactly injecting some code into 
> another process address space).

That's the standard way of getting your EIP on x86 since there's no
move from EIP instruction.  That will work, too, but (as you point
out) requires a register.

> > Another approach is to start with the current top of stack

Hmmmm :-)  Maybe easier said than done.  I was thinking about figuring
that out as basically the first thing in main, but I can think of
reasons that wouldn't be robust.

Other schemes, which involve a binary search for the boundary by using
test mmaps, involve the risk of unmapping part of the stack.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

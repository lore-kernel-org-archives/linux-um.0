Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FO0Dy-0001ur-3P for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:30:10 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FO0Dv-0003gz-V5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:30:09 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<200603241534.01844.blaisorblade@yahoo.it>
	<20060324172644.GB5400@ccure.user-mode-linux.org>
In-Reply-To: <20060324172644.GB5400@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603280030.05911.blaisorblade@yahoo.it>
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
Date: Mon, 27 Mar 2006 23:30:05 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net

On Friday 24 March 2006 18:26, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 03:34:01PM +0100, Blaisorblade wrote:
> > The EIP is inside the stub code page, and the two pages are one near the
> > other.

> I think you're going to have to talk more slowly and use shorter words.

Yes, I've been a bit too fast :-)

> The problem is that we need to figure out at runtime where to put the
> stub pages, correct?  And we can't use the code stub page to figure out
> where it is, because we haven't mapped it yet, because we don't know where
> to put it, correct?

That is problem #1, and exists; but when answering I thought to problem #2, 
i.e. that the stub code currently hardcodes the location of the stub data 
page, and that this must be fixed; I didn't notice that we must first put the 
stubs somewhere.

So I remembered that trick to get EIP which I read time ago (the purpose was 
to make some code Position-Independent exactly injecting some code into 
another process address space).

Btw, PIC library are another story because they're told their location (IIRC, 
I forget the details).

Actually, we need to figure were to place the pages, so we could _maybe_ as 
well pass the address to the stub in a register. I'm quite unsure of this 
however as at least clone.c for i386 uses _all_ available registers for the 
6-param syscall call.

> How much can stack randomization vary?  If it can vary more than the
> split varies, which I would expect, then rounding the stack pointer
> isn't going to work.

Dunno, but even if it currently works, we'd better find a solution without the 
assumption that stack randomization doesn't create problem.

> Another approach is to start with the current top of stack

How do you get that?

> and try 
> mapping pages at increments equal to the smallest split granularity
> that we think we are going to see, until one fails.

I don't like the idea of parsing /proc/XXX/maps, but I must mention it too; 
however, the format changed slightly in the various kernels, so it's 
particularly a bad idea.

bfff9000-c0000000 rwxp bfff9000 00:00 0 [stack]

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

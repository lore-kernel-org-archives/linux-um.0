Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMnMj-00038k-Jj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 06:34:13 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMnMh-0007Pg-TY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 06:34:13 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<200603240156.36646.blaisorblade@yahoo.it>
	<20060324023029.GD8104@ccure.user-mode-linux.org>
In-Reply-To: <20060324023029.GD8104@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241534.01844.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 15:34:01 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net

On Friday 24 March 2006 03:30, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 01:56:32AM +0100, Blaisorblade wrote:
> > I don't think it's easy - however, it can be done. Below my idea - Jeff,
> > please comment on this

> > In assembly.
> > It goes like this:

> > call label /*this is coded like a relative jump, i.e. call +1*/
> > label: pop $eax /*we got the saved EIP*/
> >
> > /* Now we can round EIP and subtract an offset to calculate the data page
> > location.
> > */

> How does this give us the location of the data page?

The EIP is inside the stub code page, and the two pages are one near the 
other.

> You really want to know the end of the process address space, which
> you can do by taking the address of a convenient local and rounding up
> to the nearest 1G or .5G or so.

You can't do that in the stub; however, what you suggest or something similar 
is probably needed outside the stub, from the kernel code, when you need to 
map it somewhere inside the process memory.

However, currently, the rounding can't be 0.5G, it must be 0.25G with the 
current code, and it's still fragile if the host code is changed.

(arch/i386/Kconfig)
config PAGE_OFFSET
        hex
        default 0xB0000000 if VMSPLIT_3G_OPT
        default 0x78000000 if VMSPLIT_2G
        default 0x40000000 if VMSPLIT_1G
        default 0xC0000000

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

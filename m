Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARKgC-0001rD-7C
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:15:44 -0800
Received: from hongkong.cs.nmsu.edu ([128.123.64.160] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARKgB-0001Z1-Qa
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:15:43 -0800
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200312030015.hB30Fbto016621@hongkong.cs.nmsu.edu>
Subject: Re: [uml-devel] compile problem iin 2.4.23 + 2.4.22-6
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 2 Dec 2003 18:15:37 -0600
To: caker@theshore.net, user-mode-linux-devel@lists.sourceforge.net
Cc: rocombs@cs.nmsu.edu

"Christopher S. Aker" <caker@theshore.net> wrote:

> Hello Ross,
>
> > It looks like every arch uses a macro like this:
> >
> >  ELF_PLAT_INIT(_r, load_addr)
> >
> > but uml defines it like this:
> >
> >  ELF_PLAT_INIT(regs)
> >
> > Has anyone updated the patch to 2.4.23 yet?  If not, I'll be backporting
> > the missing brk() range check from 2.4.23.
>
> Change "include/asm-um/archparam.h" to read
>
> #define ELF_PLAT_INIT(regs, load_addr) do { \
>
> There is a very good chance this isn't correct (/me is not a kernel hacker), but
> I've been running the kernel since yesterday and so far so good.

That's working perfectly here as well.  I didn't realize the macro was so
simple.  The second parameter is unused and all it does is initialize the
registers to zero on i386.

Thanks for your help.

-Ross


-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZDDV-0005NN-5G for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 10:59:13 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CZDDU-0007W5-1o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 10:59:13 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Skas0 security problems (was: Re: [uml-devel] skas mode on a non-skas
	host)
References: <200411292250.iATMoWOF004837@ccure.user-mode-linux.org>
	<200411301912.21155.blaisorblade_spam@yahoo.it>
	<41ACB90C.7070209@fujitsu-siemens.com>
In-Reply-To: <41ACB90C.7070209@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411302002.17224.blaisorblade_spam@yahoo.it>
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
Date: Tue, 30 Nov 2004 20:02:17 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 30 November 2004 19:16, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Tuesday 30 November 2004 13:11, Bodo Stroesser wrote:
> >>Jeff Dike wrote:
> >>>Prompted by some questions from Blaisorblade about whether something
> >>> like skas mode might be implemented on unpatched hosts, I went ahead
> >>> and did exactly that.

> >>>The basic idea is that in place of /proc/mm and PTRACE_FAULTINFO, we
> >>> have a couple of extra pages in the userspace process to hold code that
> >>> we are going to use to make it change its address space and to handle
> >>> segfaults so addresses and access modes can be reported back to the
> >>> kernel process.

> >>>The end result is something that is very close to skas mode, just as
> >>>secure, loses two pages of address space to UML rather than .5G, should
> >>>be almost as fast, and runs on a stock host kernel.

(From Bodo):

> >>Looks like a very good idea!
> >>But, please, be careful regarding security. If I understand the code
> >> right, the stubs always are readable and executable, but not writable
> >> for the user code. Thus, we have to ensure, that no one can singlestep a
> >> syscall that resides there.

> >>Unfortunatly, if IIRC, the generic kernel code doesn't
> >>support more than one fixaddr range.

> > Yes, I think. But why do you need it to be a fixaddr range? I guess you
> > just need to mark it as reserved, right? The copy_from_user check, i.e.
> > address_ok, can easily be fixed like we want. The cost is not relevant
> > either, since a SKAS copy_from_user requires manually walking the page
> > tables.
> >
> > But it's a different thing: you haven't got the requirement to map it at
> > a fixed address in the kernel space, and it's the only purpose that only
> > fixmap can accomplish.
>
> I agree. But no matter, which method is choosen, the relevant thing is to
> make copy_from_user() work on this area.
>
> >>And it isn't possible to join the
> >>stubs and vsyscall in a common area. So the obvious way to handle the
> >> stubs with the same method as vsyscall won't work.

> >>Since this is a security
> >>issue, I decided not to CC the list.

> > I hope that nobody is running that on production systems,

I.e. "I hope" means that nobody should at all being running it on production, 
since it's a bad idea...

> > so I hope it's 
> > a different case here. However, for now

> For now, I agree.

> But SKAS0 by design can be as safe as SKAS, so IMHO, we 
> should try do have the same security in both.
Yes, that is *just* for now. I meant that this kind of security issue is 
different.

In this case, publicising it, since we are speaking of beta-quality code, is a 
good idea. In fact, this time, I'm CC:ing the list.

Publicising a vulnerability on production code, instead, is different, 
especially when it comes to posting exploits for testing.

> >>By the way: Could you please shift the assembler-parts to sys-i386/XXX?

> >>Bodo

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

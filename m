Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBGBj-0000sL-LA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Sep 2004 10:18:23 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CBGBf-0005Rm-R6 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Sep 2004 10:18:23 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [Openswan CVS] openswan-2/linux/net/ipsec
	addrtot.c, 1.16, 1.17
References: <20040915214906.02A1F138028@tla.xelerance.com>
	<26724.1095652408@marajade.sandelman.ottawa.on.ca>
	<20040920044512.GA6672@zip.com.au>
In-Reply-To: <20040920044512.GA6672@zip.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409251915.25579.blaisorblade_spam@yahoo.it>
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
Date: Sat, 25 Sep 2004 19:15:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: CaT <cat@zip.com.au>, Michael Richardson <mcr@sandelman.ottawa.on.ca>, dev@lists.openswan.org

On Monday 20 September 2004 06:45, CaT wrote:
> On Sun, Sep 19, 2004 at 11:53:28PM -0400, Michael Richardson wrote:
> >     CaT> In include/asm-i386/string.h for example. Not all arches have
> >     CaT> it defined but a few do.
> >
> >     CaT> With the change btw, the kernel compiled.
> >
> >   Using __HAVE_ARCH_STRSTR doesn't work on UML.
> >   It appears that the strstr.c from arch/i386/lib/strstr.c doesn't get
> > compiled. I tried to get it compiled, but I seem to be missing some
> > symbol table magic. (Adding EXPORT_SYMTAB(strstr) to the file didn't
> > help).
> >
> >   Any ideas on this?

> I'm not expert (seriously - this isn't just modesty :) but it looks
> like that uml is undefining strstr but not __HAVE_ARCH_STRSTR so that
> when it's compiled on an arch that defines __HAVE_ARCH_STRSTR because
> it has strstr it's only half undefined.

> If I'm right it appears to 
> be a bug in the part of uml.
Ok, that's not a bug, but one UML choice: it will use the host libc version of 
strstr. 

> Check linux/arch/um/os-Linux/user_syms.c.
The problem is just the fact that "EXPORT_SYMBOL(strstr)" is commented out in 
THAT file. If you compile the code which uses that statically, it will work, 
so you're not on the right road.

> It includes string.h 
> which includes asm/string.h which includes asm/arch/string.h which
> points to asm-i386/string.h which would define the above.

> I've CCed the happy-fun folks at UML to be sure because my feeling that
> I'm talking sheer bollocks is about as strong as my feeling that I am
> not. :)
I don't know what "sheer bollocks" means, but I guess this is the case...

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CA9Vl-0003fF-L0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 08:58:29 -0700
Received: from nessie.weebeastie.net ([220.233.7.36]
	helo=theirongiant.lochness.weebeastie.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CA9Vh-00087G-Is
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Sep 2004 08:58:29 -0700
From: CaT <cat@zip.com.au>
Message-ID: <20040920044512.GA6672@zip.com.au>
References: <20040915214906.02A1F138028@tla.xelerance.com>
	<20040918151657.GG953@zip.com.au>
	<21443.1095535410@marajade.sandelman.ottawa.on.ca>
	<20040918235319.GH953@zip.com.au>
	<26724.1095652408@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26724.1095652408@marajade.sandelman.ottawa.on.ca>
Subject: [uml-devel] Re: [Openswan CVS] openswan-2/linux/net/ipsec addrtot.c,
	1.16, 1.17
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
Date: Mon, 20 Sep 2004 14:45:13 +1000
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: dev@lists.openswan.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Sep 19, 2004 at 11:53:28PM -0400, Michael Richardson wrote:
>     CaT> In include/asm-i386/string.h for example. Not all arches have
>     CaT> it defined but a few do.
> 
>     CaT> With the change btw, the kernel compiled.
> 
>   Using __HAVE_ARCH_STRSTR doesn't work on UML.
>   It appears that the strstr.c from arch/i386/lib/strstr.c doesn't get
> compiled. I tried to get it compiled, but I seem to be missing some
> symbol table magic. (Adding EXPORT_SYMTAB(strstr) to the file didn't
> help).
> 
>   Any ideas on this?

I'm not expert (seriously - this isn't just modesty :) but it looks
like that uml is undefining strstr but not __HAVE_ARCH_STRSTR so that
when it's compiled on an arch that defines __HAVE_ARCH_STRSTR because
it has strstr it's only half undefined. If I'm right it appears to
be a bug in the part of uml.

Check linux/arch/um/os-Linux/user_syms.c. It includes string.h
which includes asm/string.h which includes asm/arch/string.h which
points to asm-i386/string.h which would define the above.

I've CCed the happy-fun folks at UML to be sure because my feeling that
I'm talking sheer bollocks is about as strong as my feeling that I am
not. :)

-- 
    Red herrings strewn hither and yon.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

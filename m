Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzRjF-0002XG-M0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 19:44:25 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CzRjF-0002qz-2c
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 19:44:25 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
	<200502101931.19744.rob@landley.net>
	<200502110333.14243.blaisorblade@yahoo.it>
In-Reply-To: <200502110333.14243.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502102142.12750.rob@landley.net>
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
Date: Thu, 10 Feb 2005 21:42:10 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Stian Skjelstad <stian@nixia.no>

On Thursday 10 February 2005 09:33 pm, Blaisorblade wrote:
> > Sorry, meant UML.
> >
> > (I have a cold.)
>
> Best wishes for your health... (please, someone translate this to real
> English :-) )

Oh, it's real english.  (Or at least it seems so to someone who just burned 
french toast to charcoal due to being too dizzy to walk down the street to a 
sandwich shop.  I'm not exactly firing on all cylinders at present...)

> > So if I build 2.6.11-rc3-bk? I can fire up SKAS0 mode and run it on an
> > unmodified kernel?  If so, I'm happy to test this...  (I read Jeff Dike's
> > blog entry on SKAS0, but it didn't really have any implementation
> > details.)
>
> Well, code already exists. Get the appropriate -mm tree and apply on top of
> it the "incrementals" tree at
> http://user-mode-linux.sourceforge.net/patches.html.
>
> Give a quick read to the changelogs to get a feeling about what's actually
> needed and what won't at all compile. I guess that in this moment skas0-ldt
> is a good point to stop at.

Cool.  "Not tonight, I have a headache", but cool.

> Yes, obviously... actually, I also have made some confusion (I actually
> answered to "why UML in TT mode is built static?", not to the bug in TT
> mode).
>
> ***MARKED***
> The bug in TT mode: actually, it happens when and because UML is statically
> linked, against NPTL glibc. It does not happen on normal distros, which
> provide a LinuxThreads glibc in /lib and for static linking to be 2.4
> compatible; nor in Gentoo with nptl disabled (which was the default when I
> installed it).
>
> The problem, currently, is that there are problems (and linker assertion
> failures) probably because the linking scripts do not play well with
> the /usr/lib/libc.a sections. The error, if I recall it correctly, is
> posted in the comment #6.

Gee, Red Hat, the distro that brought us gcc 2.96, is now having ld throw 
assertion failures trying to build UML.  It's nice to see tradition 
maintained...

I can't debug this one.  I gave up on Fedora when FC2 wouldn't boot on my 
desktop because the kernel was optimized for a processor more recent than the 
machine had (brand new Via Samuel 2, basically a Pentium clone with MMX and 
3DNow).

I was a loyal Red Hat user for years, but Fedora just left me cold.  (And the 
_courage_ they've shown, yanking things like mp3 player support and xpdf...  
Obviously they're a good ally to stand up for decss someday.)

> Stuff below refers to "Why UML in TT mode is built static?"
>
> > but first
> > I want to confirm that you looked at the new 2.6 nonlinear mappings
> > support (mm/fremap.c, sys_remap_file_pages() and friends...)
>
> Hmm, I know that feature, only I don't understand how it could help
> *here*... basically, I think everything that you can do through
> remap_file_pages() can be done through mmap() / munmap() / mremap(), and
> the advantage is only for performance... and since the mappings in this
> case are created
>
> So, when and if there will be a remap_file_pages where you can also change
> protections and we'll drop all the mmap() we must create

Tried asking on linux-kernel?

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzQdN-0007ai-U7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 18:34:17 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CzQdN-0004G8-1A for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 18:34:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
References: <E1Cytuz-0002nD-OP@nuthatch.gentoo.org>
	<200502101644.08326.blaisorblade@yahoo.it>
	<200502101931.19744.rob@landley.net>
In-Reply-To: <200502101931.19744.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110333.14243.blaisorblade@yahoo.it>
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
Date: Fri, 11 Feb 2005 03:33:13 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Stian Skjelstad <stian@nixia.no>

Stian, can you please read this and provide some help? The point of interest 
for you is ***MARKED***

On Friday 11 February 2005 01:31, Rob Landley wrote:
> On Thursday 10 February 2005 10:44 am, Blaisorblade wrote:
> > > And requiring SKAS mode to use uclibc
> >
> > uclibc doesn't allow static linking? It's strange...
>
> Sorry, meant UML.

> (I have a cold.) 
Best wishes for your health... (please, someone translate this to real 
English :-) )

> > > Any idea when SKAS0 might be ready for testing?
> >
> > You can already test it I guess, but probably it's not for production
> > yet.
> >
> > I (Wildly) guess a month could be enough, maybe... however for now you
> > can do some testing in SKAS mode (the setup inside UML is not different).
>
> So if I build 2.6.11-rc3-bk? I can fire up SKAS0 mode and run it on an
> unmodified kernel?  If so, I'm happy to test this...  (I read Jeff Dike's
> blog entry on SKAS0, but it didn't really have any implementation details.)
Well, code already exists. Get the appropriate -mm tree and apply on top of it 
the "incrementals" tree at 
http://user-mode-linux.sourceforge.net/patches.html.

Give a quick read to the changelogs to get a feeling about what's actually 
needed and what won't at all compile. I guess that in this moment skas0-ldt 
is a good point to stop at.

> > > is roughly equivalent to requiring a
> > > kernel module in order to work.

> > Ok, are you able to figure out a way to copy the whole binary (+ libs) to
> > the VM file and remap it from the file to arbitrary address spaces?

> Not with this cold and without a lot more study of how UML works,
Yes, obviously... actually, I also have made some confusion (I actually 
answered to "why UML in TT mode is built static?", not to the bug in TT 
mode).

***MARKED***
The bug in TT mode: actually, it happens when and because UML is statically 
linked, against NPTL glibc. It does not happen on normal distros, which 
provide a LinuxThreads glibc in /lib and for static linking to be 2.4 
compatible; nor in Gentoo with nptl disabled (which was the default when I 
installed it).

The problem, currently, is that there are problems (and linker assertion 
failures) probably because the linking scripts do not play well with 
the /usr/lib/libc.a sections. The error, if I recall it correctly, is posted 
in the comment #6.

Linking scripts give instructions about how to merge / order symbols of 
various sections inside the final binary; more info is provided in the info 
pages for ld. Uml's linking script are a mix of 
arch/i386/kernel/vmlinux.lds.S (which contains special kernels definition, 
used for instance for initcalls) and of the normal linking scripts used to 
build userspace executables (they are visible in the output of "strings ld", 
and maybe there is even some special option).

To dissect binary and library sections, objdump is also useful (and also the 
elfutils version of it).

Now, I don't understand why that error is born - it guesses wrongly the number 
of physical headers, and I could describe in detail the physical headers I 
want (each physical header groups a number of sections with similar mapping 
requirements).

***MARKED***
Stuff below refers to "Why UML in TT mode is built static?"

> but first 
> I want to confirm that you looked at the new 2.6 nonlinear mappings support
> (mm/fremap.c, sys_remap_file_pages() and friends...)

Hmm, I know that feature, only I don't understand how it could help *here*... 
basically, I think everything that you can do through remap_file_pages() can 
be done through mmap() / munmap() / mremap(), and the advantage is only for 
performance... and since the mappings in this case are created 

So, when and if there will be a remap_file_pages where you can also change 
protections and we'll drop all the mmap() we must create (one mmap for each 
page is not very nice... in fact with >=256 M of RAM for single process 
inside UML you must increase the max number of mappings a single process can 
create). Having 65536 mappings, put together inside a red-black tree, is not 
nice at all.

> > This is why in TT mode UML is statically linked, it's done so that we
> > must not understand where libraries are located and remap them, too. I
> > don't think there is a clean way (other than parsing /proc/self/maps, but
> > that is a horrible kludge).
>
> Is there a post somewhere describing the problem in more detail?
No idea, if it exists, (about why UML is statically linked) it is older than 
me here (and I follow UML only since 1 year and a half).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

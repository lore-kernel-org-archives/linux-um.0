Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbkoA-0003v3-5J for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:20:06 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ebko8-0006OZ-A7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 12:20:06 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<200511131854.12656.blaisorblade@yahoo.it>
	<200511131726.22036.rob@landley.net>
In-Reply-To: <200511131726.22036.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511142040.55175.blaisorblade@yahoo.it>
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
Date: Mon, 14 Nov 2005 20:40:54 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 14 November 2005 00:26, Rob Landley wrote:
> On Sunday 13 November 2005 11:54, Blaisorblade wrote:
> > On Sunday 13 November 2005 02:36, Rob Landley wrote:
> > > I needed to patch two things to get 2.6.15-rc1 to build on an x86-64
> > > system running PLD linux:
> > >
> > > diff -ru linux-2.6.15-rc1/arch/um/Kconfig.x86_64
> > > linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64 ---
> > > linux-2.6.15-rc1/arch/um/Kconfig.x86_64 2005-11-13 02:08:34.318108152
> > > +0100 +++ linux-2.6.15-rc1-new/arch/um/Kconfig.x86_64 2005-11-13
> > > 01:55:47.761861224 +0100 @@ -9,7 +9,7 @@
> > >  #XXX: this is so in the underlying arch, but it's wrong!!!
> > >  config RWSEM_GENERIC_SPINLOCK
> > >   bool
> > > - default y
> > > + default n

> > The patch for this (which fixes a couple of other things, too) is
> > attached in this thread and has been sent to -mm (cc'ing uml-devel):

> > [uml-user] 2.6.14.git: user-mode-linux/x86_64 does not build
> > [uml-devel] [PATCH 4/9] uml - fixups for "reuse i386 cpu-specific tuning"

> The second one doesn't seem related, and I couldn't find the first one in
> 2.6.14-mm2 (which is the most recent kernel.org lists)...

The titles are for ML archives... and the second _is_ related. The problem is 
that RWSEM_GENERIC_SPINLOCK is the right thing for x86_64, but the i386 
Kconfig enables instead RWSEM_XCHGADD_ALGORITHM, which is wrong for x86_64. 
It compiles, was used at some time, but isn't really tested currently, and 
Andi Kleen is going to drop the code. So, indeed, your patch is wrong.

What the patch does is making sure that Kconfig.i386 is included for _i386_, 
not for any arch. And it fixes your problem.


> > Is that _needed_ on your system? I ask because it always worked and it's
> > highly host distro-dependant, I guess.
>
> Yes it's needed.  Otherwise:
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> /usr/bin/ld: warning: ld-linux-x86-64.so.2, needed by /lib64/libc.so.6, not
> found (try using -rpath or -rpath-link)
> collect2: ld returned 1 exit status

Ok, it's your distro. On mine:

# ls -l /lib
lrwxrwxrwx  1 root root 5 30 lug 21:17 /lib -> lib64

Anyway, what it's doing could be correct enough to do... except we do the 
linking with GCC! So probably we could simply remove that -rlink altogether 
(though the documentation would say otherwise).

> > 0x90 is the pad used to fill holes in binaries..., and it's strange it's
> > there.

> I just applied Jeff's patch.  I dunno what the output means.

Talking mainly to Jeff there
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJGSu-0002Jv-B2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:45:28 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJGSq-00082k-Ib for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:45:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<200504062117.45623.blaisorblade@yahoo.it>
	<425437F0.70804@fujitsu-siemens.com>
In-Reply-To: <425437F0.70804@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504062150.36496.blaisorblade@yahoo.it>
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
Date: Wed, 6 Apr 2005 21:50:36 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Wednesday 06 April 2005 21:26, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Wednesday 06 April 2005 20:57, Bodo Stroesser wrote:
> >>Jeff Dike wrote:
> >>>On Wed, Apr 06, 2005 at 03:27:50PM +0200, Bodo Stroesser wrote:
> >>>>Here are the patches (tarball attached), that I've applied to
> >>>>UML 2.6.11 + incrementals, before adding s390-files.
> >>>>These patches are tested a bit on x86, but not on x86_64.
> >>>
> >>>I merged these, except for the restartnointr one because I don't have
> >>>ERESTARTNOINTR in my /usr/include, inside a #ifdef KERNEL or not.
> >>>
> >>>    Jeff
> >>
> >>That's bad. Do you have any suggestions how to solve this?
> >
> > Add it to the compilation-generated header files (the output of
> > mk_constants, mk_thread and such), so we catch it from the definition
> > given by ourselves and expose to the whole of UML.
>
> Yeah, tx, that would be possible.
> But the reason for using /usr/include/linux/errno.h was to have the host's
> definition, not the one from guest.

> Currently they are the same for 2.4 and 2.6, but worst case that might
> change in future versions.
Yes maybe in principle, however the errno values are part of the ABI.
> Only debugger could note this, as ERESTART_XXXX 
> is unvisible to user programs.
Well, the debugger is a user program, so even this one, which is almost 
internal, is part of the ABI. Actually, you might ask on LKML if you want.
> So, when implementing your idea, maybe I should add a further test, that
> our ERESTARTNOINTR *does* trigger a syscall restart on the host.

Well, maybe adding a runtime test is worth, however let's start by fixing it 
compile-time as I say below. I don't know if adding a test now is "excessive 
planification and over-coding", but I feel like this (especially even for the 
above ABI reasons).

A simpler idea:

get our value as I said
get the host value if defined (it's a macro so no problem)

#ifdef HOST_ERESTARTNOINTR
#define ERESTARTNOINTR HOST_ERESTARTNOINTR
#else
#define ERESTARTNOINTR KERN_ERESTARTNOINTR
#endif

Or, actually:

#ifndef ERESTARTNOINTR
#define ERESTARTNOINTR KERN_ERESTARTNOINTR
#endif

Btw, we currently solved this for PTRACE_SYSEMU, SETOPTIONS and many similar 
things by copying the value we provide. It wouldn't be bad, when applicable 
(not PTRACE_SYSEMU since mainline hasn't the SYSEMU patch), to use the above 
construct (i.e. taking the fallback value from the kernel instead of 
specifying it and copying it - they aren't supposed to change, but anyway).

However, I'll have to merge the refactoring of the userspace programs sooner 
or later. Don't let this stop you, anyway.
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

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHXu-0004uM-Qx
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:19:54 -0800
Received: from i164-068.nv.iinet.net.au ([203.59.164.68] helo=cp.yi.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHXt-0007h8-JJ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:19:54 -0800
Received: from erdos.home ([10.0.1.2] helo=erdos)
	by cp.yi.org with esmtp (Exim 3.36 #1 (Debian))
	id 1AYHXr-0008FX-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 22 Dec 2003 12:19:51 +0800
Received: from cameron by erdos with local (Exim 3.36 #1 (Debian))
	id 1AYHXr-0000pT-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 22 Dec 2003 12:19:51 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] UML on Alpha
Message-ID: <20031222041951.GB1023@erdos.home>
References: <20031220052032.GC1152@erdos.home> <20031220173249.GC10692@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220173249.GC10692@ccure.user-mode-linux.org>
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
Date: Mon, 22 Dec 2003 12:19:51 +0800
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Dec 20, 2003 at 12:32:49PM -0500, Jeff Dike wrote:
| >         setup_arch_frame_raw(&raw_si->common.arch,
| >                              ucontext->uc_mcontext.fpregs, raw_si->common.sr);
[...]
| 
| >From /usr/include/asm/sigcontext.h on my laptop:
| 
| struct sigcontext {
| 	...
|         struct _fpstate * fpstate;
| 	...
| };

Yeah, but that's fpstate, not fpregs.  Looking at it more closely, on
i386, uc_mcontext is /not/ of type sigcontext, but mcontext_t, which
includes an fpregs member.  On alpha, uc_mcontext is a sigcontext, and
it has a sc_fpregs member.  I'm not sure that that's the appropriate
thing to change it to though - I'll have to look to see exactly what
it's using it for.

| > - Since Alpha is a 64-bit architecture, there are no *64 system calls
| >   either.  This also affects other parts of the kernel which use #if to
| >   check for Alpha/sparc64/S390/etc to determine whether or not we're on
| >   a 64-bit platform.  I've worked around this by adding a -D__um_alpha__
| >   to CFLAGS and changing some places which check for __alpha__ to also
| >   check for __um_alpha__.  This may not be the cleanest way to do things
| >   thought :(
| 
| This is a problem.  There should be a CONFIG_64BITS which all the 64 bit
| arches set, so we don't have to add #ifdef UML && UML_ALPHA to all these
| places.

Okay.  It doesn't seem to be there in 2.4.x, but I'll have a look at 2.6
some time and see if that makes this problem disappear.

| > cross-compile UML.  Unfortunately that would mean some way of getting
| > rid of mk_sc/mk_thread/mk_kern/etc, and I'm not sure what the best
| > approach to doing that would be :-/
| 
| There was a bit of work in that direction a while back.  What I think would
| be a good way to go is to have a arch_headers rule in the Makefile, which
| would execute on the target, and generate the headers.  They would land
| in a single directory, which you would then copy over to the build box.
| The build there would use those headers, or generate them itself if they
| weren't present.

Yeah, that sounds sensible.  I'll have a shot at munging the Makefiles
to do just that. :-)

Cheers,

Cameron.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

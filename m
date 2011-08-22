Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hpa@zytor.com>) id 1QvKLO-0000jd-Fj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 02:34:30 +0000
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvKLN-000440-MH
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 02:34:30 +0000
Message-ID: <4E51C026.7000702@zytor.com>
Date: Sun, 21 Aug 2011 19:34:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
	<CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
	<20110821144352.GJ2203@ZenIV.linux.org.uk>
	<20110821164124.GL2203@ZenIV.linux.org.uk>
	<CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
	<20110822011645.GM2203@ZenIV.linux.org.uk>
	<CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
	<4E51B56F.3080301@zytor.com>
	<CAObL_7HLDD=FVSN58W7a0g0R--8x7OVrQVCBxWD1DirVZxRn2w@mail.gmail.com>
	<20110822020737.GP2203@ZenIV.linux.org.uk>
	<CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
In-Reply-To: <CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Andrew Lutomirski <luto@mit.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On 08/21/2011 07:26 PM, Andrew Lutomirski wrote:
> 
> Which still leaves the question of how to fix it.  Restarting via an
> int 0x80-based helper might be the only option that leaves everything
> fully functional.
> 

The issue is that we don't represent the entire state ... we represent
only one metalevel of it, currently the "cooked" one.  The problem is
that we need the "raw" one as well, and in order to have *both* we need
to know the entry mechanism.

We need that IN EITHER CASE.

This is reasonably straightforward... we can carry the entry mechanism
forward inside the kernel, and fix it up in the IRET path.

The *really* big issue is what we drop as the sigcontext since this is
an ABI carried out to userspace.  We could just say "it's currently
totally broken for SYSCALL" and just change it to drop the raw state,
but which has the potential for breaking unknown programs, *or* we could
add a bit of state (presumably by reclaiming one of the padding fields
around cs and ss) ... which *also* has the potential for breaking programs.

Right now, SYSCALL -> signal -> restart *is broken*, however, so there
is also the option of just doing nothing in this case, I guess.
	
	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


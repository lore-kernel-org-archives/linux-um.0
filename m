Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvyMJ-0002fO-7x
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 21:18:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvyMI-0005Wa-HU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 21:18:07 +0000
Date: Tue, 23 Aug 2011 22:17:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823211744.GL2203@ZenIV.linux.org.uk>
References: <20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<20110823164849.GF2203@ZenIV.linux.org.uk>
	<4E53FCF7.7060703@zytor.com>
	<CA+55aFyQTgXD6WeKJLvfOdsgqon=vhnhZ-h9oVpGF1uwQZkdDQ@mail.gmail.com>
	<20110823194103.GK2203@ZenIV.linux.org.uk>
	<CA+55aFzECeh_xRC=sF7qG_nc3bREqUNXXGmzcLHi4vndFvE6cg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFzECeh_xRC=sF7qG_nc3bREqUNXXGmzcLHi4vndFvE6cg@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 23, 2011 at 12:43:28PM -0700, Linus Torvalds wrote:
> On Tue, Aug 23, 2011 at 12:41 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > And it's not cheap - doing that on each syscall will be unpleasant...
> > Frankly, I'd rather stopped telling the uml userland about vdso in such
> > setups. ?And anything that plays with SYSCALL outside of vdso... <shrug>
> > we already have a "don't run it native on 32bit", adding "don't run
> > it on 32bit uml on amd64 host" is not too serious. ?At least for now...
> 
> I do agree that the solution might well be to just stop using the
> non-int80 vdsos for UML. That may just solve everything in practice.

SYSENTER works fine, actually...  And we can easily check if we have an
affected SYSCALL, simply by forking a child, tracing it into a syscall
and doing POKEUSER to ebp on the second stop (i.e. on the way out).
If the value ends up in ecx after __kernel_vsyscall(), we have SYSCALL-based
variant on amd64 host, if it's lost completely - it's SYSENTER, if it shows
up in ebp - int 0x80.

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


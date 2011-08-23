Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvuAF-0006nm-6E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:49:23 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvuAB-0002kn-W1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:49:21 +0000
Date: Tue, 23 Aug 2011 17:48:49 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823164849.GF2203@ZenIV.linux.org.uk>
References: <4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk>
	<4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
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

On Tue, Aug 23, 2011 at 09:03:04AM -0700, Linus Torvalds wrote:

> Suggested fixes:
> 
>  - instead of blindly doing SETREGS, just write the result registers
> individually like you suggested

Not enough.  There is also a PITA with signal handlers.  There we can't
avoid modifying ebp on the way out of handler (i.e. by emulated sigreturn).
And it lands us straight after syscall insn, with ebp "restored" to the
wrong value.

> OR (and perhaps preferably):
> 
>  - teach UML that when you do 'GETREGS' after a system call trapped,
> we have switched things around to match the "official system call
> order", and UML should just undo our swizzling, and do a "regs.ebp =
> regs.ecx" to make it be what the actual original registers were (or
> whatever the actual correct swizzle is - I didn't think that through
> very much).

Um...  How would it know which syscall variant had that been, to start
with?  For int 0x80 it would need to use registers as-is.  For SYSENTER
it also could use them as-is - ebp will differ from what we put there
when entering the sucker, but not critically so; on the way out of
syscall we'll overwrite it anyway immediately (either by pop or mov).
For SYSCALL... we don't really care about ecx contents prior to entering
the kernel (and it'll be blown out anyway), and ebp one could be found in
regs.ecx.  So yes, we can do it that way, but... how to tell what variant
had been triggered?  Examining two bytes prior to user eip?  Sounds bloody
brittle...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


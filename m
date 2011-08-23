Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvuEU-0006fh-Mx
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:53:46 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvuEU-0002ty-44
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:53:46 +0000
Date: Tue, 23 Aug 2011 17:53:20 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823165320.GG2203@ZenIV.linux.org.uk>
References: <4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<CAObL_7F-E2y_cd1MK4ayBx_CqszrewSrBt6V7=ndVuBQrrmTKQ@mail.gmail.com>
	<20110823162251.GC13138@aftab>
	<CA+55aFxJF88EJ=WhPq08j4+REBgpvVHVwbg5BR05DD+exRyp8A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFxJF88EJ=WhPq08j4+REBgpvVHVwbg5BR05DD+exRyp8A@mail.gmail.com>
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

On Tue, Aug 23, 2011 at 09:29:29AM -0700, Linus Torvalds wrote:

> Oh yes.
> 
> System call performance is *important*. And x86 is *important*.
> 
> UML? In comparison, not that important.
> 
> So quite frankly, if this is purely an UML issue (and unless we're
> missing something else, that's what it looks like, despite all the
> confusion we've had so far), then if we have a choice between "remove
> syscall instruction" and "remove UML", then ...

Agreed.  Note, BTW, that UML has perfectly usable workaround for 99% of
that - don't tell the binaries it has *any* vdso in such cases.  And
"remove UML" turns into "remove support under UML for 32bit binaries
that go out of their way to do SYSCALL directly, which wouldn't work
on native 32bit", which is really a no-brainer.

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


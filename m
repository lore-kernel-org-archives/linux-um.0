Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1XE0u9-00021x-Up
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Aug 2014 18:53:14 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1XE0u8-0007cb-HY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Aug 2014 18:53:13 +0000
Date: Sun, 3 Aug 2014 14:42:10 -0400
From: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20140803184210.GV24826@thunk.org>
References: <53DE3E92.3060304@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53DE3E92.3060304@gmx.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] fuzz testing an ext4fs file system under a 32 bit
 Linux user mode linux guest let task jbd2/ubda hang
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-ext4@vger.kernel.org, UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Aug 03, 2014 at 03:52:18PM +0200, Toralf F=F6rster wrote:
> Hello,
> =

> fuzzying a 32 bit stable Gentoo x86 linux with trinity (and without exclu=
ding the munmap syscall but it might be independed from this) gives within =
a 32 bit user mode linux guest :

The problem with these sorts of trinity bug reports is that we have no
idea which syscall or set of syscalls might have corrupted kernel
state to the point where the kernel started malfunctioning.

Sometimes, a trinity induced bug is obvious, when it causes a system
call to immediately access an illegal memory location.  But if it
causes some more subtle corruption, possibly in a completely unrelated
subsystem, figuring out what actually happened can be close to
impossible.

So there's not much I can do with this sort of bug report.  If you can
easily repeat it, and you can dump out the system call stream, we
might be able to make a smaller reproduction case, at which point
trying to debug this sort of failure would be tractable.

Cheers,

						- Ted

---------------------------------------------------------------------------=
---
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


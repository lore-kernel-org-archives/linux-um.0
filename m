Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1XGCxh-0004LU-6E
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 20:09:57 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1XGCxe-0000Nh-RR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 20:09:56 +0000
Date: Sat, 9 Aug 2014 16:00:18 -0400
From: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20140809200018.GG15431@thunk.org>
References: <53DE3E92.3060304@gmx.de> <20140803184210.GV24826@thunk.org>
	<53E66C57.8010303@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53E66C57.8010303@gmx.de>
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

On Sat, Aug 09, 2014 at 08:45:43PM +0200, Toralf F=F6rster wrote:
> =

> BTW may I just ask, if the following (same 32 bit system, host and
> UML guest are both at v3.16, 4 trinity childs hammering victims
> files in a ramdisk within the uML guest) matches the above too ? Or
> does the BUG output here more helpful data ? :

Unfortunately, there's nothing useful here.  There is more than one
BUG_ON() in this mpage_release_unused_pages function, and what's more,
we have no idea which syscall or combination of syscalls might have
left a page in a particular state.

					- Ted

---------------------------------------------------------------------------=
---
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


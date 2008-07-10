Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGz7E-0000cS-4T for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 09:35:32 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KGz7C-0006a5-LL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 09:35:32 -0700
Date: Thu, 10 Jul 2008 12:35:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080710163514.GA17561@c2.user-mode-linux.org>
References: <200807101619.54052.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200807101619.54052.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] UML kernel failed to start betvee 2.6.8-rc8 and
	current git	sources
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 10, 2008 at 04:19:51PM +0200, Toralf F=F6rster wrote:
> from v2.6.26-rc8 to v2.6.26-rc9-56-g6329d30 sth. affected UML, b/c my use=
r mode linux kernel produces this :
> =

> ...
> VFS: Mounted root (ext3 filesystem) readonly.
> Registers -
>         0       0x0
>         1       0x0
>         2       0x0
>         3       0x0
>         4       0x0
>         5       0x0
>         6       0x0
>         7       0x0
>         8       0x0
>         9       0x0
>         10      0x0
>         11      0x0
>         12      0x0
>         13      0x0
>         14      0x0
>         15      0x0
>         16      0x0
> Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed, errn=
o =3D 5
> =


I have 2.6.26-rc9-00010-g3bc5ab9 and it seems fine.  I'll pull the latest g=
it
and see if that's still OK.

What's the host?

				Jeff

-- =

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

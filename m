Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KH1qn-00041x-TU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 12:30:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KH1ql-0003u1-Vn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 12:30:45 -0700
Date: Thu, 10 Jul 2008 15:30:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080710193019.GA20112@c2.user-mode-linux.org>
References: <200807101619.54052.toralf.foerster@gmx.de>
	<20080710163514.GA17561@c2.user-mode-linux.org>
	<200807102010.02772.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200807102010.02772.toralf.foerster@gmx.de>
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jul 10, 2008 at 08:09:59PM +0200, Toralf F=F6rster wrote:
> At Thursday 10 July 2008 18:35:15 Jeff Dike wrote :
> =

> > What's the host?
> =

> tfoerste@n22 ~ $ uname -a
> Linux n22 2.6.25-gentoo-r6 #4 Thu Jul 10 19:49:36 CEST 2008 i686 Intel(R)=
 Pentium(R) M processor 1700MHz GenuineIntel GNU/Linux
> =

> BTW,  this works fine and shows only the config :
> n22 ~ # linux-v2.6.26-rc8-227 --showconfig =

> =

> whereas this failed:
> =

> n22 ~ # linux-v2.6.26-rc9-56 --showconfig
> Locating the bottom of the address space ... 0x0
> Locating the top of the address space ... 0xc0000000

OK, I believe you're seeing the same bug as Uli saw here:

    http://marc.info/?l=3Dlinux-kernel&m=3D121011518003727&w=3D2

More precise symptoms are here:

     http://marc.info/?l=3Dlinux-kernel&m=3D121011722806093&w=3D2

I never did figure that one out.  I had the same kernel version, same
toolchain, same everything as far as I could see, and I couldn't
reproduce it, except with a binary that he gave me.

You're seeing it on i386, whereas he saw it on x86_64.

The underlying problem is that somehow the UML initcalls aren't being
run, which is why you're seeing all zeros in the register dump.

If you bisect this, I bet you end up at the no-unit-at-a-time patch
that he ended up at.  And I have no idea what that has to do with
anything.

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

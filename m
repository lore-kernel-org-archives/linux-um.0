Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATTab-0005W9-MJ
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 14:10:49 -0800
Received: from home.nightdaughter.de ([194.95.224.141] helo=a141.shuttle.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATTab-0006EK-57
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 14:10:49 -0800
From: Joerg Hoh <joerg@devone.org>
Subject: Re: [uml-devel] Porting UML to other plattforms
Message-ID: <20031208221400.GC3553@hydra.joerghoh.de>
References: <20031206224535.GF3376@hydra.joerghoh.de> <200312082042.hB8KgmAv029431@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
In-Reply-To: <200312082042.hB8KgmAv029431@ccure.user-mode-linux.org>
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
Date: Mon, 8 Dec 2003 23:14:00 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Dec 08, 2003 at 03:42:48PM -0500, Jeff Dike wrote:
> joerg@devone.org said:
> > Can someone tell me, how hard is the job to port UML to other
> > plattforms than i386 (how far went the ppc port?).
>=20
> In principal, it shouldn't be too hard.  In practice, the immature arch=20
> abstraction layer inside UML is a problem, but this should be improved on=
ce
> I get the x86_64 port merged.

Good News.

> More troublesome are are host-specific problems.  Every architecture that=
 UML
> has run on has exposed toolchain problems of one sort or another.  Host k=
ernel
> and hardware bugs are also somewhat common.  These are what will hold up =
any
> new port, rather than any problems with UML itself.

How does a hardware bug affect UML? The bugs should be "fixed" by the host
kernel and therefore noone should see them (expect some very lowlevel
software and the kernel). Can you explain this point to me?

J=F6rg

--=20
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

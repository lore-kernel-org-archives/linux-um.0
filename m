Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1As0Zu-0002q3-K3
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 06:15:30 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1As0Tp-0000fE-Kn
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 06:09:13 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: modify_ldt_ldt_s vs. user_desc (Re: [uml-devel] Re: [uml-user] UML (unofficial) patches against vanilla 2.6.2)
References: <200402052107.37625.blaisorblade_spam@yahoo.it> <20040213071536.GJ19147@alcor.net> <20040213135929.GA27460@fieldses.org>
In-Reply-To: <20040213135929.GA27460@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402141514.46788.blaisorblade_spam@yahoo.it>
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
Date: Sat, 14 Feb 2004 15:14:46 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 14:59, venerd=EC 13 febbraio 2004, J. Bruce Fields ha scritto:
> On Thu, Feb 12, 2004 at 11:15:36PM -0800, Matt Zimmerman wrote:
> > I don't suppose there would be much harm in adding a macro to ldt.h so
> > that existing software could continue to work, but that change belongs =
in
> > the kernel.
>
> The policy as I understand it has always been that userland needs its
> own headers, and that kernel headers are not meant to be usable by
> applications unmodified.
This is the official policy. It's a bit wrong, but it's so (how do you=20
maintain ioctl's listes in glibc headers with the one in the kernels? Give =
a=20
look to the include/kernel-abi proposal, for more info about this, onto=20
lwn.net).
> Looks like a debian bug to me....

1) Not only Debian (Jeff Chua, with a RH, reported it, too)
2) It is glibc the one who should supply correct headers.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

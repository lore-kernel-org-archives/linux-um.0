Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Asm9C-0005Gg-5L
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 09:03:06 -0800
Received: from knight.innercite.com ([158.222.3.8])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Asm5b-0006FY-R5
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 08:59:23 -0800
Received: from [158.222.7.10] (rocket.innercite.com [158.222.7.10])
	by knight.innercite.com (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1GGnKmL032324
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 16 Feb 2004 08:49:20 -0800
Subject: Re: [uml-devel] Kernel idles in loop after loading IPv4
From: Phil Nadeau <phil@innercite.com>
In-Reply-To: <200402151801.38113.blaisorblade_spam@yahoo.it>
References: <1075236841.15950.10.camel@rocket.innercite.com>
	 <200401280439.i0S4dUZw005532@ccure.user-mode-linux.org>
	 <1075497812.22009.41.camel@rocket.innercite.com>
	 <200402151801.38113.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1076950110.2286.20.camel@rocket.innercite.com>
Mime-Version: 1.0
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
Date: Mon, 16 Feb 2004 08:48:31 -0800
Content-Transfer-Encoding: quoted-printable
To: UML Dev List <user-mode-linux-devel@lists.sourceforge.net>

On Sun, 2004-02-15 at 09:12, BlaisorBlade wrote:
> Alle 22:23, venerd=EC 30 gennaio 2004, Phil Nadeau ha scritto:
> > On Tue, 2004-01-27 at 20:39, Jeff Dike wrote:
>=20
> > Here's the last part of a debug session that I ran which produced the
> > error. The full transcript is attached. Thanks in advance.
>=20
> Could you try to reproduce this bug running onto a 2.4 host-skas kernel w=
ith=20
> the same guest kernel? Most people have no problem with the code; also, t=
he=20
> host-skas patch for 2.6 that you used has more than one bug (somebody eve=
n=20
> reported kernel Oopses with that applied). Also, I'd like more info on th=
e=20
> host configuration: glibc/gcc version and distro used.
>=20

gcc (GCC) 3.3.2 20031022 (Red Hat Linux 3.3.2-1)
glibc-2.3.2
libpthread-0.10

Kernel is Linux version 2.6.1 (root@build1.innercite.com) (gcc version
3.3.2 20031022 (Red Hat Linux 3.3.2-1))

Based on other things I've seen on the list, I suspect it's an issue
with the host using NPTL. This occurs with 2.4.22 Fedora Core kernels
and vanilla 2.6.0 and 2.6.1 kernels compiled with and without SKAS.
Since NPTL seems to be a Known Issue, I was leaving it alone for now.
Any other ideas?

--=20
Phil Nadeau
Software Services Manager
phil.nadeau@innercite.com
(916)932-3200, (800)921-5513



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

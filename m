Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNcHA-0007Mx-3W for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 May 2004 11:46:48 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BNcH9-0000Iv-He for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 May 2004 11:46:47 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Still can't get an 2.6.6-rcX UML
References: <20040504200555.13458.qmail@praize.com>
In-Reply-To: <20040504200555.13458.qmail@praize.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405111859.34514.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 11 May 2004 19:35:54 +0200
Content-Transfer-Encoding: quoted-printable
To: gboutwel <gboutwel@praize.com>, user-mode-linux-devel@lists.sourceforge.net

Alle 22:05, marted=EC 4 maggio 2004, gboutwel ha scritto:
> > Blaisorblade wrote:
> > Yes, what I mean is that the proper fix is probably to make
> it use the kernel
> > headers as it did before. Would you post the output of the
> failing make
> > command with the V=3D1 option added, to see the actual build
> command?
>
>
>
> Attached is the orgianl fail (before trying the symlink in /usr/include)
> with V=3D1 as uml-2.6.6-rc3-V.log
>
>
>
> Also, attached is the new fail (after trying the symlink in /usr/include)
> with an V=3D1 as uml-2.6.6-rc3.log
>
> > I think the 2nd thing holds, and that my suggestions is a workaround
>
> that
>
> > should work (I hope)...
>
> Don't look like it.

Well, it is an improvement; try disabling the SKAS mode in the UML .config =
and=20
post the new output, with V=3D1. However now I'm trying to solve the proble=
m=20
myself with 2.6.6 - restart again with the patches I'm posting today (see t=
he=20
"Patch for 2.6.6" thread).

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to=20
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From______________________________=
_________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BduaO-0003I9-QQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Jun 2004 10:34:00 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BduaO-0001Sk-6o for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Jun 2004 10:34:00 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] highmem support in 2.4 (2.4.26-1)
References: <1088118748.31490.48.camel@etrs-pc02.ets.enterasys.com>
In-Reply-To: <1088118748.31490.48.camel@etrs-pc02.ets.enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200406251946.18048.blaisorblade_spam@yahoo.it>
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
Date: Fri, 25 Jun 2004 19:46:17 +0200
Content-Transfer-Encoding: quoted-printable
To: "D. Bahi" <dbahi@enterasys.com>, user-mode-linux-devel@lists.sourceforge.net

Alle 01:12, venerd=EC 25 giugno 2004, D. Bahi ha scritto:
> hello UMLers
>
> i uml launch a guest with "mem=3D1024M"
> and i see "CONFIG_HIGHMEM not enabled".
> so i "make ARCH=3Dum xconfig" to enable it
> and rebuild.
>
> i no longer see "CONFIG_HIGHMEM not enabled"
> but i still see "Memory: 460188k available"
> which makes me think i'm missing something.

That support could be broken. I don't think you can have done anything wron=
g=20
(no configuration error possible; double-check that CONFIG_HIGHMEM =3D y in=
 the=20
.config, but you cannot have missed anything else).

But there could be some strange host configuration: what is your distro? Ha=
ve=20
you enabled exec-shield (which is enabled by default on Fedora and RedHat 9?

I think that the message could be wrong; could you check with the "free"=20
command inside the UML?

See the explainations:

> w/o CONFIG_HIGHMEM:

>CONFIG_HIGHMEM not enabled - physical memory shrunk to 499122176 bytes
>Kernel virtual memory size shrunk to 32505856 bytes

> On node 0 totalpages: 121856
> zone(0): 121856 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.

I.e. there are some pages (each one is 4k) in the zone 0 (normal).

> Memory: 474328k available


> w/ CONFIG_HIGHMEM:

> Kernel virtual memory size shrunk to 32 505 856 bytes

This is unrelated, but strange: is the kernel going to use just 32 Mega (in=
=20
both cases) for itself?

> On node 0 totalpages: 262144
> zone(0): 121856 pages.
> zone(1): 0 pages.
> zone(2): 140288 pages.

I.e. there are those pages in the normal zone plus some more ones in the zo=
ne=20
2, i.e. (IIRC) the HIGHMEM zone. So HIGHMEM seems to work, at least=20
partially.

> Memory: 460188k available

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

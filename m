Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApUtA-0007X0-Tv
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 08:01:00 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ApUtA-0006nP-5u
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 08:01:00 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: UML & 2.6.2
References: <20040204173846.7522.qmail@praize.com> <200402051800.19582.blaisorblade_spam@yahoo.it> <c00g1s$hkn$1@sea.gmane.org>
In-Reply-To: <c00g1s$hkn$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402071702.18101.blaisorblade_spam@yahoo.it>
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
Date: Sat, 7 Feb 2004 17:02:18 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 17:42, venerd=EC 6 febbraio 2004, Sven K=F6hler ha scritto:
> > http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/U=
ML
> >/2.6.2-v1/uml-patch-2.6.2-0.bz2
>
> This patch doesn't give me any option to turn on /proc/mm

Wait a moment:
1) That is a patch only for the UML kernel (no host-skas).
2) So, when you apply it, since it's for UML, you must not do:
  make menuconfig
but
  make menuconfig ARCH=3Dum
where ARCH=3Dum means "don't configure for the host but for the guest kerne=
l".=20
Also follow the "compiling it" link on the left bar on the Uml main site an=
d=20
read instructions carefully.

IIRC you won't be able to compile a host kernel with only that patch.
3) If you follow point 2, you will see the /proc/mm option under "UML-speci=
fic=20
options". However that's not what you need.

> > http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/U=
ML
> >/2.6.2-v1/00-Combo-v1.bz2
>
> This patch doesn't apply correctly to vanilla 2.6.2 sources

You must apply those in order and they are for the UML kernel.

I don't want to repeat myself, but I do

"1) Use Ingo's combo only for the host kernel (since the UML part for itsel=
f=20
is out-of-date)."

You must currently use that patch on a vanilla kernel tree to get host-skas.
Remember to use two separate kernel trees - one for the host (with Ingo's=20
combo) and one for the guest (with the two patches above from me).
For the host kernel (after applying Ingo's combo), you can find /proc/mm un=
der=20
"Processor type and features".

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

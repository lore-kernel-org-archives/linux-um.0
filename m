Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPih2-0006cj-1H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 06:34:28 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CPih0-0007B9-5N for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 06:34:27 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4512772.CgWUMq10Im";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411041534.31568.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] [PATCH] extend the limits for command line
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
Date: Thu, 4 Nov 2004 15:34:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, jdike@karaya.com, linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net

--nextPart4512772.CgWUMq10Im
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 08:08, Catalin(ux aka Dino) BOIE wrote:
> Hello!
>
> (I resend this because I get no feedback.)
Sorry, miss of time.

> Testing UML on my project, I hit the limit for command line with something
> like this:

> default \
>          mem=3D64M \
>          ubda=3DCOW,/data/UML4/roots/ROOT1 \
>          ubdb=3DSWAP \
>          ubdc=3DCONF.tar \
>          ${HSSTR} \
>          eth0=3Ddaemon,fe:fd:39:bd:cc:d7,,/data/UML4/conf/example1/socks/=
SW1
> eth1=3Ddaemon,fe:fd:01:01:01:12,,/data/UML4/conf/example1/socks/SW2
> eth2=3Ddaemon,fe:fd:01:01:01:99,,/data/UML4/conf/example1/socks/SW4
> eth3=3Ddaemon,fe:fd:01:01:01:03,,/data/UML4/conf/example1/socks/SW5
> eth4=3Ddaemon,fe:fd:01:01:01:04,,/data/UML4/conf/example1/socks/SW6
> eth5=3Ddaemon,fe:fd:01:01:01:81,,/data/UML4/conf/example1/socks/SW8p1
> eth6=3Ddaemon,fe:fd:3f:a9:35:e2,,/data/UML4/conf/EXTERN/E1  \
>          con=3Dnull \
>          ssl0=3Dport:9101 \
>          umid=3Dexample1-pc1 \
>          @pc1@

> Patch to extend the limits (buffer and number of args/envs) is attached.
> Please consider including it because UML is intended to be run with such
> long lines.
> I'm open to other alternatives as a Kconfig entry for this.

> Thank you!

> Signed-off-by: Catalin(ux aka Dino) BOIE <catab at umbrella dot ro>

The idea of the patch is correct.

The UML part should be mergeable immediately - however, I don't know if tha=
t=20
could be a security risk or has any bug (any place still using the old size=
).

Also, I'd like to understand what arch/um/kernel/user_util.c wants to do ne=
ar=20
its beginning!

=46or the arch-independent code, there needs to be something like a Kconfig=
=20
entry (not necessarily a user-question, see CONFIG_GENERIC_RWSEM for=20
instance).

Also, I'd like to cross-check this patch with the one used by Knoppix for a=
ges=20
to do the same thing.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart4512772.CgWUMq10Im
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBij33qH9OHC+5NscRAiphAJwMv49+bPMkoXfXGbAyGdujY6IpwQCcDPq2
rDoXRZrDnaF4CTEfLV1rA+E=
=PAIm
-----END PGP SIGNATURE-----

--nextPart4512772.CgWUMq10Im--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

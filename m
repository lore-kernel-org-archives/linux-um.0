Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <20041018210402.GB3049@localhost.localdomain>
References: <415408E40001A675@ms001msg.mail.fw>
	<200410181948.22460.blaisorblade_spam@yahoo.it>
	<20041018203757.GA28381@ixion.tartarus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20041018203757.GA28381@ixion.tartarus.org>
From: ste@openlabs.it (SteX)
Subject: [uml-devel] Re: [uml-user] UML on PPC? state of the art
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
Date: Mon, 18 Oct 2004 23:04:02 +0200
To: Chris Emerson <uml-devel@mail.nosreme.org>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2004 at 09:37:57PM +0100, Chris Emerson wrote:
Ciao Chris,
> > On Monday 18 October 2004 17:58, SteX wrote:
> > > Hi all,
> > > does anyone know if the porting of UML on PPC has still been staled? =
or
> > > anyone has started working on?
> > > My Apple Powerbook is crying! ((:-((
> >=20
> > > I found something about the porting on Chris Emerson's home page, but=
 it
> > > is staled sice july 2001!
> > Where's that page?
>=20
> That'd be http://www.nosreme.org/projects/umlppc/ (it used to be
> http://www.tartarus.org/~chris/user-mode-linux/).

in the last days I was looking at your work and today I started to apply
the latest (2001!!!) 2.4.6 patch to a vanilla kernel (2.4.6).

ste@monteverdi:/usr/src/dest$ sudo make linux ARCH=3Dum
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/usr/src/dest/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2  -fno-strict-aliasing -g  -U__powerpc__ -D__UM_PPC__
-D__arch_um__ -DSUBARCH=3D\"ppc\" -DNESTING=3D0 -D_LARGEFILE64_SOURCE   -c =
-o
init/main.o init/main.c
In file included from /usr/src/dest/include/asm/irq.h:4,
                 from /usr/src/dest/include/asm/hw_irq.h:4,
				 from /usr/src/dest/include/asm/arch/system.h:15,
				 from /usr/src/dest/include/asm/system.h:9,
				 from /usr/src/dest/include/asm/arch/page.h:19,
				 from /usr/src/dest/include/asm/page.h:6,
				 from /usr/src/dest/include/linux/wait.h:18,
				 from /usr/src/dest/include/linux/fs.h:12,
				 from /usr/src/dest/include/linux/capability.h:17,
				 from /usr/src/dest/include/linux/binfmts.h:5,
				 from /usr/src/dest/include/linux/sched.h:9,
				 from /usr/src/dest/include/linux/mm.h:4,
				 from /usr/src/dest/include/linux/slab.h:14,
				 from /usr/src/dest/include/linux/proc_fs.h:5,
				 from init/main.c:15:
/usr/src/dest/include/asm/arch/irq.h: In function `irq_cannonicalize':
/usr/src/dest/include/asm/arch/irq.h:213: error: structure has no member
named `irq_cannonicalize'
/usr/src/dest/include/asm/arch/irq.h:215: error: structure has no member
named `irq_cannonicalize'
In file included from /usr/src/dest/include/asm/arch/system.h:15,
				 from /usr/src/dest/include/asm/system.h:9,
				 from /usr/src/dest/include/asm/arch/page.h:19,
				 from /usr/src/dest/include/asm/page.h:6,
				 from /usr/src/dest/include/linux/wait.h:18,
				 from /usr/src/dest/include/linux/fs.h:12,
				 from /usr/src/dest/include/linux/capability.h:17,
				 from /usr/src/dest/include/linux/binfmts.h:5,
				 from /usr/src/dest/include/linux/sched.h:9,
				 from /usr/src/dest/include/linux/mm.h:4,
				 from /usr/src/dest/include/linux/slab.h:14,
				 from /usr/src/dest/include/linux/proc_fs.h:5,
				 from init/main.c:15:
/usr/src/dest/include/asm/hw_irq.h: At top level:
/usr/src/dest/include/asm/hw_irq.h:6: warning: `struct hw_interrupt_type'
declared inside parameter list
/usr/src/dest/include/asm/hw_irq.h:6: warning: its scope is only this
definition or declaration, which is probably not what you want
make: *** [init/main.o] Error 1
ste@monteverdi:/usr/src/dest$=20
>=20
> > Nobody is working on the PPC port. If someone wants to start helping,
> > we will welcome him.
>=20
> I'm hoping to do a bit more work on it soon.  It's tricky with a
> full-time day job and a wife who things (probably rightly) I should be
> doing more useful things when I'm at home.  :-)  So no promises...
>=20
> Anyway, the code has changed quite a bit in the last few years, so it'll
> take me a while to get my head around it again even if I do find the
> time.
Since you are the last who worked on it would be good if you help us to
find the way to help (you) and your work. Do you agree?

Regards

SteX

--=20
GPG key =3D D52DF829   --   Stex   --  <stefano.melchior@openlabs.it>
Keyserver: http://keyserver.kjsl.com - http://www.openlabs.it/~stex
Registered user #324592 on the Linux Counter, http://counter.li.org

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQCVAwUBQXQvwolnkxrVLfgpAQIv7AP6AurQ9kCMnguqyXsFiihA9lWOyLf3+kP8
wb0uiAZ8tN/ych38zutt5iNc3OMzA71Nmj+elwrXuVzuJYUXPSBpSFTO41bZHpT+
udSFp4FdnA+YGdaMklj7WrUgjiczcK9ojqNCuARtRfEGWbbSV/GZPeN9h/KQuXy6
USEfWEP2+7E=
=c1+D
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

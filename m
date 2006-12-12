Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gu85l-0006Mx-DE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 05:54:45 -0800
Received: from [62.123.212.160] (helo=demachaut.etinarcadiaego.dyndns.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gu85j-0006ag-CG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 05:54:45 -0800
Date: Tue, 12 Dec 2006 09:50:56 +0100
From: Stefano Melchior <stefano.melchior@openlabs.it>
Message-ID: <20061212085056.GB6194@SteX>
MIME-Version: 1.0
Subject: [uml-devel] [Pkg-uml-pkgs] Re: Bug#399328: linux-patch-skas:
	user-mode-linux seems to not work on 2.6.18 patched with this package]
Reply-To: stefano.melchior@openlabs.it
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1778845941=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: u-m-l devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Mattia Dongili <malattia@debian.org>, Peder =?iso-8859-1?Q?Chr=2E_N=F8rgaard?= <pcn@pogt.dk>


--===============1778845941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear all,
there is a guy who submitted a bug related to the Debian linux-patch-skas
package: he affirmed to encouter problem in working with the host kernel
once compiled and patched SKAS. The host kernel release is reported in the
subject.
At the end of his analysis, he noticed this problem occurred only with AMD
Athlon 2200+, then with -k7 CPU type [*]: in particular with 2.6.18-5
compiled for K7 and patched with debian's linux-patch-skas (the same of
Blaisorblade's).

You can get details of the thread (a few mails) at the following link:
http://lists.alioth.debian.org/pipermail/pkg-uml-pkgs/2006-November/000438.=
html

Cheers

SteX

[*]
http://lists.alioth.debian.org/pipermail/pkg-uml-pkgs/2006-November/000481.=
html

----- Forwarded message from Stefano Melchior <stefano.melchior@openlabs.it=
> -----

Date: Fri, 24 Nov 2006 14:54:20 +0100
=46rom: Stefano Melchior <stefano.melchior@openlabs.it>
To: "Peder Chr. N=EF=BF=BDrgaard" <pcn@pogt.dk>
Cc: Debian UML pkg Team <Pkg-uml-pkgs@lists.alioth.debian.org>
Subject: [Pkg-uml-pkgs] Re: Bug#399328: linux-patch-skas: user-mode-linux
	seems to not work on 2.6.18 patched with this package
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on=20
	demachaut.etinarcadiaego.dyndns.org
X-Spam-Level:=20
X-Spam-Status: No, score=3D-102.4 required=3D5.0 tests=3DAWL,BAYES_00,
	FORGED_RCVD_HELO,USER_IN_WHITELIST autolearn=3Dham version=3D3.1.7
X-Virus-Scanned: amavisd-new at email.it
X-Greylist: from auto-whitelisted by SQLgrey-1.7.4
X-My-Blog: http://etinarcadiaego.dyndns.org
X-Reply-To: stefano.melchior@openlabs.it
X-Registered-Linux-User: 324592 (http://counter.li.org)
X-OS: Linux demachaut.etinarcadiaego.dyndns.org 2.6.18-stex
X-Fingerprint: F478 0583 A292 F652 AF35 A9CE 8967 931A D52D F829
X-BeenThere: pkg-uml-pkgs@lists.alioth.debian.org
X-Mailman-Version: 2.1.5
Reply-To: stefano.melchior@openlabs.it
List-Id: Debian User-Mode-Linux Developers packages
	<pkg-uml-pkgs.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-uml-=
pkgs>,=20
	<mailto:pkg-uml-pkgs-request@lists.alioth.debian.org?subject=3Dunsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-uml-pkgs>
List-Post: <mailto:pkg-uml-pkgs@lists.alioth.debian.org>
List-Help: <mailto:pkg-uml-pkgs-request@lists.alioth.debian.org?subject=3Dh=
elp>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-uml-pk=
gs>,=20
	<mailto:pkg-uml-pkgs-request@lists.alioth.debian.org?subject=3Dsubscribe>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: pkg-uml-pkgs-bounces+stefano.melchior=3Dopenlabs.it@li=
sts.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to fal=
se
X-Bogosity: Unsure, tests=3Dbogofilter, spamicity=3D0.500565, version=3D0.9=
4.4

On Sun, Nov 19, 2006 at 11:34:43AM +0100, Peder Chr.N=EF=BF=BDrgaard wrote:
Dear Peder,
> Package: linux-patch-skas
> Version: 3-2
> Severity: important
>=20
> I apologize in advance if this should have been reported on
> user-mode-linux, or perhaps not at all, if it turns out to be my own
> fault.  But I don't know how to proceed.
>=20
> User-mode-linux seems to run quite well on latest debian sid kernel,
> 2.6.18-2-686.  But I want to use the SKAS3 patch for speed and
> correctness, and have done so earlier with success (during 2005, with
> kernels 2.6.9/10/11/12).
>=20
> This is how I build the modified kernel:
>=20
> tar xfvj /usr/src/linux-source-2.6.18.tar.bz2
>=20
> cd linux-source-2.6.18
>=20
> cp /boot/config-2.6.18-2-686 .config
>=20
> make-kpkg --append-to-version -pcn --subarch 686 --revision 1 --initrd --=
added-patches skas --config menuconfig --rootcmd fakeroot configure
> make-kpkg --append-to-version -pcn --subarch 686 --revision 1 --initrd --=
added-patches skas --config menuconfig --rootcmd fakeroot clean
> make-kpkg --append-to-version -pcn --subarch 686 --revision 1 --initrd --=
added-patches skas --config menuconfig --rootcmd fakeroot kernel-image
>=20
> When this kernel is installed and user-mode-linux started (I start it
> from rootstrap) it correctly notes that SKAS3 is active:
>=20
> 	:
> Checking for the skas3 patch in the host:
>   - /proc/mm...found
>   - PTRACE_FAULTINFO...found
>   - PTRACE_LDT...found
> UML running in SKAS3 mode
> 	:
>=20
> but then it hangs at end of startup:
>=20
> 	:
> Initializing software serial port version 1
>  ubda: unknown partition table
>  ubdb: unknown partition table
> VFS: Mounted root (hostfs filesystem) readonly.
>=20
> where it hangs forever, spending all the CPU power available on the
> host system.  At this point, when using the official debian kernel,
> with no SKAS3, it would continue with
>=20
> builder running...
>=20
at first sigh it seems a problem related to rootstrap, not with
linux-patch-skas. To affirm it I need to investigate a bit more.
Did you test the just-compiled kernel (with SKAS patch)
with an pre-build uml instance to check if it works?
If I remember well you can find here, in http://uml.nagafix.co.uk/, some
uml instances. Anyway what is your rootstrap.conf configuration?

Cheers

SteX

----- End forwarded message -----

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://www.openlabs.it/~stex    --     <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org  --  <ste@etinarcadiaego.dyndns.org>
Skype ID "stefanomelchior"

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iQCVAwUBRX5tcIlnkxrVLfgpAQKZsAQAlJY7/s323K87huwn5O/mA16CQwk3LEzJ
ipTuRSzoAQEpKUn0AP1H6YnxBtS6YJtsa6WhQ8daE41ZuJ77AhPkP/W9jnw+ON8l
ulpN25v/8Rwf39WwiDA50o1l0ZJTkSTSWDfTTTJmRVoTUpF6zdm3mNCXktZMX2VA
avHTC4Eqcos=
=FWSL
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


--===============1778845941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1778845941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1778845941==--

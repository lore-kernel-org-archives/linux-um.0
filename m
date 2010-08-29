Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <toralf.foerster@gmx.de>) id 1OplaA-00015m-Td
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2010 17:22:14 +0000
Received: from mailout-de.gmx.net ([213.165.64.22] helo=mail.gmx.net)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Opla9-00019o-Cl for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2010 17:22:14 +0000
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Date: Sun, 29 Aug 2010 19:22:04 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9cpeMdKbWivTC9R"
Message-Id: <201008291922.05069.toralf.foerster@gmx.de>
Subject: [uml-devel] v2.6.36-rc3: UML compile error in hostaudio_kern.c
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_9cpeMdKbWivTC9R
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I get with the attached config :

=2E..
  CC      arch/um/drivers/hostaudio_kern.o
  CC      arch/um/kernel/tlb.o
  CC      arch/um/os-Linux/start_up.o
arch/um/drivers/hostaudio_kern.c: In function =E2=80=98hostaudio_open=E2=80=
=99:
arch/um/drivers/hostaudio_kern.c:204: error: =E2=80=98__param_dsp=E2=80=99 =
undeclared (first=20
use in this function)
arch/um/drivers/hostaudio_kern.c:204: error: (Each undeclared identifier is=
=20
reported only once
arch/um/drivers/hostaudio_kern.c:204: error: for each function it appears i=
n.)
arch/um/drivers/hostaudio_kern.c: In function =E2=80=98hostmixer_open_mixde=
v=E2=80=99:
arch/um/drivers/hostaudio_kern.c:265: error: =E2=80=98__param_mixer=E2=80=
=99 undeclared (first=20
use in this function)
arch/um/drivers/hostaudio_kern.c:272: error: =E2=80=98__param_dsp=E2=80=99 =
undeclared (first=20
use in this function)
make[1]: *** [arch/um/drivers/hostaudio_kern.o] Error 1
make: *** [arch/um/drivers] Error 2
make: *** Waiting for unfinished jobs....

=2D-=20
MfG/Kind regards
Toralf F=C3=B6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


--Boundary-00=_9cpeMdKbWivTC9R
Content-Type: application/x-zerosize;
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"


--Boundary-00=_9cpeMdKbWivTC9R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
--Boundary-00=_9cpeMdKbWivTC9R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_9cpeMdKbWivTC9R--



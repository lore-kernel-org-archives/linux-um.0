Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <PeterHuewe@gmx.de>) id 1TAVwj-0003uT-VS
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Sep 2012 01:04:21 +0000
Received: from mailout-de.gmx.net ([213.165.64.23])
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1TAVwi-0001LA-Ko for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Sep 2012 01:04:21 +0000
From: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 03:08:08 +0200
References: <201209022245.20413.PeterHuewe@gmx.de> <5044A81B.4080209@nod.at>
In-Reply-To: <5044A81B.4080209@nod.at>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4v+SQIxlt6eADvi"
Message-Id: <201209090308.08766.PeterHuewe@gmx.de>
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
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_4v+SQIxlt6eADvi
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

Hi Richard,

sorry for the late reply.

> > I'm curious if there have ever been any attempts to emulate i2c devices
> > under uml in order to facilitate driver development by using stub
> > drivers.
> I know none.

> If there is a use case, why not. :-)
Thanks for your encouraging words ;)

I had a look around and found the nice CONFIG_I2C_STUB driver,
which is described in detail at 
http://www.kernel.org/doc/Documentation/i2c/i2c-stub

"""This module is a very simple fake I2C/SMBus driver.  It implements five
types of SMBus commands: write quick, (r/w) byte, (r/w) byte data, (r/w)
word data, and (r/w) I2C block data."""
which more or less exactly fits my need.

The only thing that was missing was general support for I2C which is dependent 
on CONFIG_HAS_IOMEM which unfortunately isn't available on UML,
but I simply added a || UML to the Kconfig and was now able to build the I2C 
Support, the i2c-dev module (for userspace access) and the i2c-stub driver.

If I  know load the i2c_stub module I have a emulated i2c device ;)

I adapted the stub driver to my needs and was now able to create my own 
emulated i2c device and start with driver and tools development for it ;)


I added the patch, in case you're interested.

Unfortunately some I2C drivers fail to build if CONFIG_HAS_IOMEM = n, but 
don't have that dependency in Kconfig - I simply added it to prevent them from 
inclusion.

Do you think I should try to push this mainline via the i2c subsystem?

Thanks,
Peter

--Boundary-00=_4v+SQIxlt6eADvi
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-i2c-Fix-Change-dependencies-to-make-I2C-available-on.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-i2c-Fix-Change-dependencies-to-make-I2C-available-on.patch"

=46rom 44d8ec6fa1466c226b605baae9483749ea9de200 Mon Sep 17 00:00:00 2001
=46rom: Peter Huewe <peterhuewe@gmx.de>
Date: Sun, 9 Sep 2012 03:03:29 +0200
Subject: [PATCH] i2c: Fix/Change dependencies to make I2C available on UML

This patch overwrites the HAS_IOMEM dependency for I2C on UML, as it is not
really necessary to have HAS_IOMEM in order build the generic I2C part.

In addition to that, every I2C modules available in UML which really
needs HAS_IOMEM was given this dependency to its KConfig.

The I2C subsystem can now be used, e.g. by the i2c-stub driver, for
development of I2C device drivers.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
=2D--
 drivers/i2c/Kconfig        |    2 +-
 drivers/i2c/busses/Kconfig |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 5a3bb3d..03ce0cb 100644
=2D-- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -4,7 +4,7 @@
=20
 menuconfig I2C
 	tristate "I2C support"
=2D	depends on HAS_IOMEM
+	depends on HAS_IOMEM || UML
 	select RT_MUTEXES
 	---help---
 	  I2C (pronounce: I-squared-C) is a slow serial bus protocol used in
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index b4aaa1b..1e61ad9 100644
=2D-- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -498,7 +498,7 @@ config I2C_NUC900
=20
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
=2D	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  OpenCores I2C controller. For details see
@@ -525,6 +525,7 @@ config I2C_PASEMI
=20
 config I2C_PCA_PLATFORM
 	tristate "PCA9564/PCA9665 as platform device"
+	depends on HAS_IOMEM
 	select I2C_ALGOPCA
 	default n
 	help
@@ -628,6 +629,7 @@ config I2C_SH_MOBILE
=20
 config I2C_SIMTEC
 	tristate "Simtec Generic I2C interface"
+	depends on HAS_IOMEM
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for
@@ -772,7 +774,7 @@ config I2C_PARPORT_LIGHT
=20
 config I2C_TAOS_EVM
 	tristate "TAOS evaluation module"
=2D	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && HAS_IOMEM
 	select SERIO
 	select SERIO_SERPORT
 	default n
=2D-=20
1.7.8.6


--Boundary-00=_4v+SQIxlt6eADvi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--Boundary-00=_4v+SQIxlt6eADvi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_4v+SQIxlt6eADvi--



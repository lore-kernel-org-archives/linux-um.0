Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QVuVz-0006M8-3s
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 23:56:23 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QVuVx-0005az-EZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 23:56:23 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 13 Jun 2011 00:56:12 +0200
References: <201106121314.41348.florian@openwrt.org>
	<201106121356.14546.richard@nod.at>
	<201106122352.35662.florian@openwrt.org>
In-Reply-To: <201106122352.35662.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MQU9N9lMmn0LSwM"
Message-Id: <201106130056.12956.richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH 2/2] um: disable compile-time buffer checks
To: Florian Fainelli <florian@openwrt.org>
Cc: nico@openwrt.org, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_MQU9N9lMmn0LSwM
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Sonntag 12 Juni 2011, 23:52:35 schrieb Florian Fainelli:
> Le dimanche 12 juin 2011 13:56:14, Richard Weinberger a =E9crit :
> > Am Sonntag 12 Juni 2011, 13:14:41 schrieb Florian Fainelli:
> > > From: Nicolas Thill <nico@openwrt.org>
> > >=20
> > > Ubuntu 8.10 and newer enable compile-time buffer checks by default,
> > >=20
> > > which can sometime cause build failures like this:
> > >   LD      vmlinux
> > >   SYSMAP  System.map
> > >   SYSMAP  .tmp_System.map
> > >   LINK linux
> > >   Building modules, stage 2.
> > >   MODPOST 51 modules
> > >=20
> > > ERROR: "__sprintf_chk" [arch/um/drivers/harddog.ko] undefined!
> >=20
> > Hmm, now I'm wondering why no other Ubuntu users have noticed this.
> > Are also current versions of Ubuntu affected?
>=20
> Without this patch, I get the exact same modpost error on Ubuntu 11.04:

Okay, found the real problem.
We have to export the *_chk functions.
Nobody noticed it because most UML kernels are CONFIG_MODULES=3Dn
and harddog.ko is not part of the defaultconfig.

Can you please test the attached patch?

Thanks,
//richard

--Boundary-00=_MQU9N9lMmn0LSwM
Content-Type: text/x-patch;
  charset="UTF-8";
  name="test.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test.diff"

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 05f5ea8..9e71e7e 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -18,6 +18,9 @@ extern void *memmove(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);
 
+extern int __sprintf_chk(char *str, int flag, size_t strlen, const char *format);
+EXPORT_SYMBOL(__sprintf_chk);
+
 /* If it's not defined, the export is included in lib/string.c.*/
 #ifdef __HAVE_ARCH_STRSTR
 EXPORT_SYMBOL(strstr);

--Boundary-00=_MQU9N9lMmn0LSwM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
--Boundary-00=_MQU9N9lMmn0LSwM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_MQU9N9lMmn0LSwM--



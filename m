Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxAcP-0007YH-IP for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 11:59:25 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AxARg-0003Wu-5K for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 11:48:20 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch] module symbol fix
References: <20040226212655.GA5191@bytesex.org>
	<20040227092656.GA12168@bytesex.org>
In-Reply-To: <20040227092656.GA12168@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402281732.13103.blaisorblade_spam@yahoo.it>
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
Date: Sat, 28 Feb 2004 17:32:12 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 10:26, venerd=EC 27 febbraio 2004, Gerd Knorr ha scritto:
> On Thu, Feb 26, 2004 at 10:26:55PM +0100, Gerd Knorr wrote:
> >   Hi,
> >
> > recent gcc versions need this one ...
>
> Another one of this kind (without this gcc may optimizes away the static
> declared but unreferenced stuff, resulting in initrd=3D and --help options
> not working any more for example ...).

Yes, but it needs to be made work with older gcc, even 2.95.3 but also 3.2 =
-=20
and this means using __attribute__(__unused__) if needed - i.e. using=20
__attribute__used as in the first patch (using more than one attribute work=
s,=20
as in include/linux/init.h).

The problem is that init.h is included even in userspace modules so it cann=
ot=20
include kernel headers - also, it seems that user_syms.c does not include=20
<linux/compiler.h> and so __attribute_used cannot be expanded simply. If it=
=20
works on you, check if the define comes from /usr/include/linux/compiler.h.

Duplicating the version check from include/linux/compiler* will be needed t=
o=20
avoid the problems you pointed out and possibly others, but not being able =
to=20
include linux/* in user-objs is increasingly sucking. Sadly there are reaso=
ns=20
for this and they are good (I discovered this while trying to remove this=20
limitation):

- user space headers include /usr/include/linux/*, so if you add -I<source =

tree root>/include, those headers will include _other_ linux headers and=20
things will not work - especially, they will include <source tree=20
root>/include/asm-um/* instead of /usr/include/asm/*.

- definitions depending on CONFIG_* would be messed up; in fact, uml-config=
.h=20
is a translation of config.h which defines UML_CONFIG_* instead of CONFIG_*=
,=20
because CONFIG_* macros are defined by /usr/include/linux/autoconf.h. So if=
=20
an "user-objs" file includes linux/mm.h, that header could even think that =

CONFIG_HIGHMEM is defined because the distro said so!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

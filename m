Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai3AX-0001fQ-3l for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 19:00:09 -0800
Received: from adsl-b4-98-227.telepac.pt ([81.193.98.227]
	helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ai3AW-0002Ht-Kd for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 19:00:08 -0800
Message-ID: <4009F773.3060008@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: cannot compile 2.6.1 uml-kernel, NPTL?
References: <bua04l$6uo$1@sea.gmane.org> <bucb6k$pck$1@sea.gmane.org>
In-Reply-To: <bucb6k$pck$1@sea.gmane.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
Date: Sun, 18 Jan 2004 03:03:15 +0000
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello!

Sven K=F6hler wrote:
>> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free=20
>> -Wl,--wrap,calloc \
>>         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
>=20
>=20
> Since the only file that's included is /usr/lib/libutils.so and this=20
> file is part of glibc, i believe that it's my NPTL-patched glibc.
>=20
> Can somebody with installed NPTL confirm the problem?
>=20
> BTW: i'm using glibc 2.3.2
>=20

I can't confirm your problem, but something close:
With latest glibc (2.3.3cvs) with NPTL as the only glibc in the system=20
(host kernel =3D=3D 2.6), linux-2.4.23-um1 compiled dinamically exits with =

segfault.

I didn't have time, this last week, to retest diferent cenarios but I'll=20
try in the next few days.

You're trying with 2.6-um and a release glibc, so this may be unrelated :-)

Regards,
Nuno Silva



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GabIl-0002mP-Vh for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Oct 2006 10:03:28 -0700
Received: from newcod.sandelman.ca ([192.139.46.42] helo=cod.sandelman.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GabIh-0002M5-Do
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Oct 2006 10:03:27 -0700
Received: from sandelman.ottawa.on.ca (desk.marajade.sandelman.ca
	[205.150.200.247])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "marajade.sandelman.ca.",
	Issuer "Michael Richardson" (verified OK))
	by cod.sandelman.ca (Postfix) with ESMTP id F33AD12B2B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Oct 2006 13:03:18 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Date: Thu, 19 Oct 2006 13:03:04 -0400
Message-ID: <v0r6x41bnb.fsf@marajade.sandelman.ca>
MIME-Version: 1.0
Subject: [uml-devel] Xen 3.0.2 and UML guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0010966246=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0010966246==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable


I had to replace my nightly test run box, and I thought it would be simplest
to just turn it into a XenU on a beefier server I have.

When I run my UMLs under Xen, they go into permanent R state. Since my
scripts eventually time out, and continue... I get loads of 60+, etc.

It appears that this happens as soon as the UML starts the scheduler.
I have uml_mconsole control, and can sysrq stuff, etc.=20

I notice a big delay when I start just after it decides that it's using SKA=
S0.

The Xen0 kernel:            2.6.17-1.2174_FC5xen0=20
The XenU kernel involved:   2.6.16-xen #3         (xen-3.0.2, locally compi=
led)
The UML kernel:             2.6.16.18 and 2.6.15

I will try going forward to newer UML kernels.

The fault may well be Xen's.  I'm looking for other experiences, yeah or na=
y.

=2D-=20
]            Bear: "Me, I'm just the shape of a bear."          |  firewall=
s  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net archit=
ect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device dri=
ver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"=
); [



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQEVAwUARTev1YCLcPvd0N1lAQLpqwf/UPiu8b/hxfGv8bZ8setxSq4ewqvBPdYd
XbKXf4IFCPiO++aFDVXgWE1Mm8VKhj7z+H+cryT7ujuyKXeNxnnczmlsPStQfmZl
d+GsyD7BlJHlooVqMg1wMdIuAx+s3id3hgcmaQ6yabR9n/gol4PE8q+eWJhH0RjH
As0gKUxfUkvERB8Zv7/CT0HGGzbBdg8UdQWtLiNgg2lBou/XZdYj67byVdV6IR5b
dBcu2/NK9BMtUxJwGzVMMusP30alYp1ySWgdsFwPg5lr5nemAYx7mZ6+vXns6Uwn
1AABdKZrZNIbave4l9GKPiYoV9LQ7u7l7rz5G8I899czZrQG1qLcRg==
=2H+m
-----END PGP SIGNATURE-----
--=-=-=--


--===============0010966246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0010966246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0010966246==--

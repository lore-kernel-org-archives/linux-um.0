Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB8Qt-0007mv-F1 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:10:35 -0700
Received: from wohnheim.fh-wedel.de ([213.39.233.138])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB8Qr-0004jk-2g
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:10:35 -0700
Date: Thu, 10 Aug 2006 13:10:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Message-ID: <20060810111003.GA11194@wohnheim.fh-wedel.de>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] UML - support checkstack
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Matt Mackall <mpm@selenic.com>

On Wed, 9 August 2006 14:15:24 -0400, Jeff Dike wrote:
>=20
> Make checkstack work for UML.  We need to pass the underlying architecture
> name, rather than "um" to checkstack.pl.
>=20
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Acked-by: Joern Engel <joern@wohnheim.fh-wedel.de>

J=F6rn

--=20
Geld macht nicht gl=FCcklich.
Gl=FCck macht nicht satt.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyqFh-0003Jz-Dj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Mar 2004 02:38:53 -0800
Received: from rimuhosting.com ([207.44.185.16])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Aypif-0004Tj-Oa
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Mar 2004 02:04:45 -0800
Received: from objexcel (port-203-99-26-186.jet.net.nz [203.99.26.186])
	(authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id i24AOnHh002569
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 4 Mar 2004 23:24:52 +1300
Message-ID: <045601c401d2$a7c6f390$0600a8c0@objexcel>
From: "Peter" <support@rimuhosting.com>
References: <20040303200937.GK14069@localhost.localdomain>
	<Pine.LNX.4.44.0403032227040.17693-100000@filer.marasystems.com>
	<20040304093605.GA24034@patrick.wattle.id.au>
Subject: Re: [uml-devel] Module exploits into the host?
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 4 Mar 2004 23:19:01 +1300
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

And disable hostfs on your UML kernel (even if you're not passing a hostfs =
to the UML instance on its command line).
----- Original Message -----=20
From: "Cameron Patrick" <cameron@patrick.wattle.id.au>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, March 04, 2004 10:36 PM
Subject: Re: [uml-devel] Module exploits into the host?


> Henrik Nordstrom wrote:
>=20
> | If you want to minimize this, run the UML chrooted (and absolutely not =
as=20
> | root). The use of process capabilities can also be used to limit the=20
> | possible damage, or any of the security extensions to Linux.
>=20
> Also, don't build module support into the kernel, and edit drivers/char/m=
em.c
> to disable writes to /dev/mem and /dev/kmem.
>=20
> Cameron.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArNid-0001JV-NO
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 12:45:55 -0800
Received: from rimuhosting.com ([207.44.185.16])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArNf2-000358-34
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 12:42:12 -0800
Received: from objexcel (port-203-99-26-174.jet.net.nz [203.99.26.174])
	(authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id i1CKiQHh021073
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 13 Feb 2004 09:44:31 +1300
Message-ID: <01ee01c3f1a9$06424800$0600a8c0@objexcel>
Reply-To: "Peter" <support@rimuhosting.com>
From: "Peter" <peter@rimuhosting.com>
References: <1076598155.20064.12.camel@wopr.tektonic.net>
Subject: Re: [uml-devel] /dev/anon without /dev/anon ?
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 09:43:09 +1300
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

This may just be noise, but I also had a host server with 2.4.24 + skas3 + =
/dev/anon that crashed yesterday after a day or so of running.  Not using u=
bd=3Dmmap.

Regards, Peter
----- Original Message -----=20
From: "Matt Ayres" <matta@tektonic.net>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, February 13, 2004 4:02 AM
Subject: [uml-devel] /dev/anon without /dev/anon ?


> Hi,
>=20
> I had tried out the /dev/anon patch on a host server, success wasn't too
> good.  It crashed after a few hours of running.  This was without
> ubd=3Dmmap passed to the UML's. Unfortunately I do not have any sort of
> OOPs.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

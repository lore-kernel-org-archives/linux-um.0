Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArOWp-0005P4-Qa
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:37:47 -0800
Received: from rimuhosting.com ([207.44.185.16])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArOTA-0004Rh-Ns
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:34:00 -0800
Message-ID: <024601c3f1b0$41648270$0600a8c0@objexcel>
Reply-To: "Peter" <support@rimuhosting.com>
From: "Peter" <peter@rimuhosting.com>
References: <1076598155.20064.12.camel@wopr.tektonic.net> <01ee01c3f1a9$06424800$0600a8c0@objexcel> <20040212215154.GC4168@ccure.user-mode-linux.org>
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
Date: Fri, 13 Feb 2004 10:28:14 +1300
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I don't go near tt UMLs.  This these are all using skas UMLs.  Is there any=
way I can disable /dev/anon without rebuilding the kernel. rm /dev/anon?

Regards, Peter
----- Original Message -----=20
From: "Jeff Dike" <jdike@addtoit.com>
To: "Peter" <support@rimuhosting.com>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, February 13, 2004 10:51 AM
Subject: Re: [uml-devel] /dev/anon without /dev/anon ?


> On Fri, Feb 13, 2004 at 09:43:09AM +1300, Peter wrote:
> > This may just be noise, but I also had a host server with 2.4.24 + skas=
3 + /dev/anon that crashed yesterday after a day or so of running.  Not usi=
ng ubd=3Dmmap.
>=20
> Yeah, the patch is not quite kosher.  I've had no problems whatsoever run=
ning
> skas UMLs, but tt UMLs won't boot with devanon.
>=20
> Jeff
>=20


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

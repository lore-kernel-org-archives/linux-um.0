Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCJoi-0007nI-Kz for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 07:50:44 -0700
Received: from mout1.freenet.de ([194.97.50.132])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BCJoi-0007m5-70
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 07:50:44 -0700
From: Michael Koehne <kraehe@copyleft.de>
Message-ID: <20040410145043.GA28734@bakunin.copyleft.de>
References: <20040410140840.GB5782@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20040410140840.GB5782@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: V=R
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
Date: Sat, 10 Apr 2004 16:50:43 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Moin Jeff Dike,

> On Sat, Apr 10, 2004 at 01:06:51PM +0200, Sven K=F6hler wrote:
> > is there any way for the UML-kernel to allocate a non-swappable=20
> > memore-region in the host's memory? this could be especially important =

> > for dedicated host-machines that are only to run UMLs.
>=20
> What I am going to do is make it possible to manage the host's memory
> so that it doesn't swap, and the UMLs in effect are mlocked.

  this reminds me on VM's V=3DR nucleus option. A V=3DR is a memory partiti=
on
  dedicated to 1 user, e.g. an MVS guest running under VM who is doing its
  own demand paging. To translate this to Linux could be the following :

  e.g. a system with 1GB real ram could boot `linux mem=3D256m` with
  only a quarter of ram for the hosting system. We now need two tricks:

  1: add 768m of ram as V=3DR memory (dont use it for Linux processes,
     buffers, ...) partition and offer it as /dev/v=3Dr. (this would
     be a host kernel patch)

  2: use this V=3DR region for UML `linux mem=3D256m@256m` (this would
     be a user kernel patch)

  I dont know how difficult implementation would be, but I think most
  of an UML V=3DR is already there. The real V=3DR is vice versa, so VM
  is running in upper core, to offer the lower core to the one and
  only guest a virtual=3Dreal environment.

Bye Michael
--=20
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+=
1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

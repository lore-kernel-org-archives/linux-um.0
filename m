Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xVse-0005nk-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 11:09:20 -0700
Received: from mout1.freenet.de ([194.97.50.132])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xVsd-00024R-F1
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 11:09:19 -0700
Received: from [194.97.50.136] (helo=mx3.freenet.de)
	by mout1.freenet.de with asmtp (Exim 4.22)
	id 19xVsa-0007IS-0C
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 20:09:16 +0200
Received: from b2aef.pppool.de ([213.7.42.239] helo=home.petschge.de)
	by mx3.freenet.de with esmtp (Exim 4.22 #1)
	id 19xVsY-0001fl-TP
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 20:09:15 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id AFE7B3BCE5
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 20:03:47 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id A96963BCE4
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 20:03:44 +0200 (CEST)
Content-Type: text/plain; charset="iso-8859-15"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <20030911180344.A96963BCE4@home.petschge.de>
Subject: [uml-devel] Re: 2.6.0 uptime bug
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 11 Sep 2003 19:44:30 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

>> I have a patch which gives the correct uptime. I don't know what the
>> patch  breaks so please post any problems you have.
> Have you been able to figure out whether this is also a problem for
> other ports?  Your patch suggests that it is, and if it is, then you=20
> should send it to LKML so it can be fixed in mainline.
Ok 2.6.0-test5 gives the correct uptime on i386 and the wrong huge uptime a=
s uml. My patch doesn't break anything on i386 but I'm going to fix this bu=
g in the uml part of the kernel.

mfg,
Patrick "Petschge" Kilian

--=20
Brauchtumspflege ist nicht anmeldepflichtig. Das gilt auch f=FCr=20
zwanzigst=FCndige Martinsumz=FCge im Wendland um einen Castor herum.
-- Mathias Schindler in d.o.c



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

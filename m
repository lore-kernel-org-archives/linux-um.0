Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArpN9-0000va-Ba
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 18:17:35 -0800
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1ArpHm-0007Cj-EV
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 18:12:02 -0800
Received: from 10.0.0.11 (ool-44c218a8.dyn.optonline.net [68.194.24.168])
 by mta10.srv.hcvlny.cv.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HT100HDRY9QMC@mta10.srv.hcvlny.cv.net> for
 user-mode-linux-devel@lists.sourceforge.net; Fri,
 13 Feb 2004 21:15:26 -0500 (EST)
From: Jeff Sipek <jeffpc@optonline.net>
In-reply-to: <20040212185344.GD2834@ccure.user-mode-linux.org>
Message-id: <200402132115.17512.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
References: <200402041926.39098.jeffpc@optonline.net>
 <20040212185344.GD2834@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [patch] 2.6 uml & CONFIG_SMP fix
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
Date: Fri, 13 Feb 2004 21:15:11 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 12 February 2004 13:53, Jeff Dike wrote:
> Applied, thanks.  The spinlock.h part wasn't exactly right - the thing to
> do was create one that just includes the arch spinlock.h.  Although, I'm
> not sure that symlinks are a bad idea in the case of those trivial headers.

That was a quick fix to make it compile. I have the next 9 days off, so I'll 
spend some quality time with the kernel :-)

Jeff.

- -- 
Please avoid sending me Word or PowerPoint attachments.
 See http://www.fsf.org/philosophy/no-word-attachments.html 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFALYSzwFP0+seVj/4RAnCEAJ48X2ZFFolqeCQTsV+iakquJMHBMwCdGpUB
r3rJMI3cJFXLEzy/3EFwWN8=
=LkAi
-----END PGP SIGNATURE-----



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

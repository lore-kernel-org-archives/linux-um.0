Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuVKJ-0002dP-Qn for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 03:29:43 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AuV4O-0005gy-3l for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 03:13:16 -0800
In-Reply-To: <a0602042ebc27404e43b0@[192.168.1.10]>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
From: mlmail@formann.de (Johannes Formann)
Message-ID: <1g9iaa6.1j68jrk15jxbhgM@johannes.formann.de>
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
Date: Sat, 21 Feb 2004 12:23:01 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Chua <jchua@fedex.com>

Johannes Formann <johannes@formann.de> wrote:

> Strange, after aplying the 23-1 patch to 2.4.24 and aplying Chuas 
> (the first and  longer one) patch by hand, everything seems to run no.

Everything has run fine, but I've testet 2.4.24-1um with 2.4.25 sources,
an the same Bug appered, the same Patch helped.

regards

Johannes Formann



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

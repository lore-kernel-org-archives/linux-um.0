Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuZD8-00052S-Lj for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 07:38:34 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AuYwy-0003oC-61 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 07:21:52 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
References: <1g9iaa6.1j68jrk15jxbhgM@johannes.formann.de>
In-Reply-To: <1g9iaa6.1j68jrk15jxbhgM@johannes.formann.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402211634.47549.blaisorblade_spam@yahoo.it>
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
Date: Sat, 21 Feb 2004 16:34:47 +0100
To: mlmail@formann.de, user-mode-linux-devel@lists.sourceforge.net
Cc: jchua@fedex.com

Alle 12:23, sabato 21 febbraio 2004, Johannes Formann ha scritto:
> Johannes Formann <johannes@formann.de> wrote:
> > Strange, after aplying the 23-1 patch to 2.4.24 and aplying Chuas
> > (the first and  longer one) patch by hand, everything seems to run no.
>
> Everything has run fine, but I've testet 2.4.24-1um with 2.4.25 sources,
> an the same Bug appered, the same Patch helped.
I agree with you: time ago UML crashed when you do "cat /dev/kmem"; after it 
was modified, and it crash on your setup; the (first and longer one) patch 
reverts to the first situation. So normally you run fine but if you do cat 
/dev/kmem your UML guest will probably crash.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

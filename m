Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTp7Q-0003IJ-GZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 14:42:24 -0700
Received: from smtpq2.home.nl ([213.51.128.197])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTp7Q-0000sB-2f for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 14:42:24 -0700
Received: from [213.51.128.135] (port=47103 helo=smtp4.home.nl)
	by smtpq2.home.nl with esmtp (Exim 4.30) id 1BTp7N-0002pV-6n
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 23:42:21 +0200
Received: from cc22149-a.groni1.gr.home.nl ([217.121.240.26]:34372
	helo=ws-02.local) by smtp4.home.nl with esmtp (Exim 4.30)
	id 1BTp7V-0000e8-Dl for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 23:42:29 +0200
From: Leendert Meyer <leen.meyer@home.nl>
Subject: Re: [uml-devel] No of ubd
References: <Pine.LNX.4.44.0405281842010.31393-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405281842010.31393-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405282347.43766.leen.meyer@home.nl>
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
Date: Fri, 28 May 2004 23:47:43 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Friday 28 May 2004 20:33, Henrik Nordstrom wrote:
> On Fri, 28 May 2004, Leendert Meyer wrote:
> > To create an ubd partition, one does on the host e.g.
> >
> >   dd if=/dev/zero of=rootfs count=1 bs=1G
> >   mkreiserfs -ff rootfs
> >
> > But how to make an ubd drive?
>
> Partition it using fdisk/sfdisk/whatever..

Ok, here's what I tried:

---8<---8<---8<---8<---8<---8<---
ws-02:/home/leen # dd if=/dev/zero of=rootfs count=1 bs=100M
1+0 records in
1+0 records out
ws-02:/home/leen # fdisk rootfs
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF 
disklabel
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.

You must set cylinders.
You can do this from the extra functions menu.
Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)

Command (m for help):
---8<---8<---8<---8<---8<---8<---

I know how to use fdisk. But I need a bit of guidance here. Given *any* 
partitionsize, what are the appropriate values? Is there a formula for that?

And *before* I can partition the disk, are there even more data to fill in?

TIA,

Cheers,

Leen


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUXGD-0001tI-KF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 13:50:25 -0700
Received: from smtpq3.home.nl ([213.51.128.198])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUXGD-0006R9-94 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 13:50:25 -0700
Received: from [213.51.128.132] (port=59826 helo=smtp1.home.nl)
	by smtpq3.home.nl with esmtp (Exim 4.30) id 1BUXGC-0006Tl-2E
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 22:50:24 +0200
Received: from cc22149-a.groni1.gr.home.nl ([217.121.240.26]:33996
	helo=ws-02.local) by smtp1.home.nl with esmtp (Exim 4.30)
	id 1BUXGA-0004FF-E4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 22:50:22 +0200
From: Leendert Meyer <leen.meyer@home.nl>
Subject: Re: [uml-devel] No of ubd
References: <Pine.LNX.4.44.0405302040040.27975-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405302040040.27975-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405302256.25065.leen.meyer@home.nl>
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
Date: Sun, 30 May 2004 22:56:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Sunday 30 May 2004 20:43, Henrik Nordstrom wrote:

> As I said the Linux kernel does nor care about the geometry.

Ok, I'll accept that as a fact, but I got confused because fdisk & co do care:

> Geometry is only used by fdisk and friends and there you can specify the
> geometry interactively. 

And that was exactly where I had to use it! :) My fdisk & co won't work 
without knowing the number of cylinders. Fortunately Debian's cfdisk is able 
to calculate the number of cylinders, and that brought me on the road again.

> The only reason why there exists a geometry 
> concept in Linux is because of DOS/BIOS compatibility reasons and certain
> I/O subsystems who can not address secotors (old IDE is an example and is
> why you have all the horror of hard drive size limitations in old IDE
> systems..)

Do you mean CHS vs. LBA?

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

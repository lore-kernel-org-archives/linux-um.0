Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTjMH-00008s-6j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 08:33:21 -0700
Received: from smtpq3.home.nl ([213.51.128.198])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTjME-0005G2-Sz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 08:33:19 -0700
Received: from [213.51.128.136] (port=45149 helo=smtp5.home.nl)
	by smtpq3.home.nl with esmtp (Exim 4.30) id 1BTjME-0002YK-0x
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 17:33:18 +0200
Received: from cc22149-a.groni1.gr.home.nl ([217.121.240.26]:33797
	helo=ws-02.local) by smtp5.home.nl with esmtp (Exim 4.30)
	id 1BTjMC-0002UW-2j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 17:33:16 +0200
From: Leendert Meyer <leen.meyer@home.nl>
Subject: Re: [uml-devel] No of ubd
References: <Pine.LNX.4.44.0405280922080.27901-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405280922080.27901-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405281737.19674.leen.meyer@home.nl>
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
Date: Fri, 28 May 2004 17:37:19 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Friday 28 May 2004 10:13, Henrik Nordstrom wrote:
> On Fri, 28 May 2004, Raymond Wong wrote:
> > How many ubd drives are available to use?  8? Or 256?
>
> 8, each with 16 partitions.

To create an ubd partition, one does on the host e.g.

  dd if=/dev/zero of=rootfs count=1 bs=1G
  mkreiserfs -ff rootfs

But how to make an ubd drive?

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

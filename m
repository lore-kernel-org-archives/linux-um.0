Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQb2W-0005kg-5K for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 17:04:00 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQb2V-00019B-Ks
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 17:03:59 -0700
Message-Id: <200405200050.i4K0o2Dt002135@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Implementing 802.11... 
In-Reply-To: Your message of "Fri, 14 May 2004 20:24:47 +0200."
	<20040514182447.56774.qmail@web25106.mail.ukl.yahoo.com> 
References: <20040514182447.56774.qmail@web25106.mail.ukl.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 19 May 2004 20:50:02 -0400
To: =?iso-8859-1?q?maria=20maria?= <for_spam2004@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

for_spam2004@yahoo.it said:
> Warning: kfree_skb passed an skb still on a list (from a0126b3b)
> Kernel panic: kernel BUG at skbuff.c:316!
>
> Does someone have some idea about the cause of this problem? 

If you aren't familiar with skbuff management, you should probably find
some driver that's similar to yours, and just copy how it does things.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

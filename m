Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKoqd-0006wZ-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 18:35:51 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BKopx-0007RC-3U
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 18:35:09 -0700
Message-Id: <200405040218.i442I4ml026599@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] devanon for kernel 2.6 
In-Reply-To: Your message of "Mon, 03 May 2004 17:49:42 +0300."
	<40965C06.6050504@almahdi.cc> 
References: <40965C06.6050504@almahdi.cc> 
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
Date: Mon, 03 May 2004 22:18:04 -0400
To: Ali Almahdi <ali@almahdi.cc>
Cc: user-mode-linux-devel@lists.sourceforge.net

ali@almahdi.cc said:
> just a fast question, can devanon be ported to kernel 2.6??, since it
> really reduces host memory usage. 

It has been, and I have it.  There just didn't seem to be much demand for it,
so I didn't really make it public.

Also, there is a bug or two in it, plus it only works with ubd-mmap, which is
going away, so I'm not really encouraging its use right now.  That'll change
when I get humfs-mmap working, and devanon fixed.

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

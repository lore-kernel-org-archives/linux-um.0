Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyEX7-0004Tj-Jf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 10:22:21 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AyE2U-0004f3-Hv
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 09:50:42 -0800
Message-Id: <200403021840.i22IeBWo002559@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Removing user_syms.c altogether 
In-Reply-To: Your message of "Sun, 29 Feb 2004 13:19:53 +0100."
	<200402291319.53584.blaisorblade_spam@yahoo.it> 
References: <200402282010.41036.blaisorblade_spam@yahoo.it>
	<20040228223333.GB7716@ccure.user-mode-linux.org>
	<200402291319.53584.blaisorblade_spam@yahoo.it> 
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
Date: Tue, 02 Mar 2004 13:40:11 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Eeehm - yes! Note however the comment about genksyms: what I say is my
> idea,  but possibly a wrong one. 

Yeah, this isn't right.  The userspace symbols are from libc, and have no
place under kernel/.  They should be exported from os/ somehow, and a different
OS might export totally different symbols.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zmYF-0001tO-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 17:21:39 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zmYD-0005wo-Qz
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 17:21:38 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8I0Cwj05396
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 20:12:59 -0400
Message-Id: <200309180022.h8I0MVNu021681@ccure.karaya.com>
Subject: Re: [uml-devel] Little heap overflow in mconsole_kern.c 
In-Reply-To: Your message of "Tue, 16 Sep 2003 15:59:18 +0200."
             <200309161559.18993.blaisorblade_spam@yahoo.it> 
References: <200309161559.18993.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 17 Sep 2003 20:22:31 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> While new points to a mconsole_entry, the code allocates
> sizeof(mc_request),  not sizeof(mconsole_entry)

Gawd, someone really needs to shoot me before I destroy something...

Needless to say, that is fixed.  Nice spotting.

BTW, It would be a good exercise for someone to go through the code and 
replace instances of
	foo = kmalloc(sizeof(type-name), ...)
with
	foo = kmalloc(sizeof(*foo), ...)

That would have prevented this bug.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

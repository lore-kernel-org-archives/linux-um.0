Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ujpF-0004OZ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 19:26:21 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ujpE-00038y-Go
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 19:26:20 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h842J2j17185
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 3 Sep 2003 22:19:02 -0400
Message-Id: <200309040229.h842TbFs009472@ccure.karaya.com>
Subject: Re: [uml-devel] [PATCH] Make UML slightly quieter 
In-Reply-To: Your message of "Wed, 03 Sep 2003 01:09:37 EDT."
             <20030903050937.GG25655@alcor.net> 
References: <20030901204045.GA17884@alcor.net> <200309021849.h82InoHx001633@ccure.karaya.com>  <20030903050937.GG25655@alcor.net> 
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
Date: Wed, 03 Sep 2003 22:29:37 -0400
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

mdz@debian.org said:
> Easy enough.  Is there an existing module which has stuff like this,
> where such a function would fit? 

Not really.  Maybe um_arch.c, since that's already sort of a dumping ground
for random crap.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

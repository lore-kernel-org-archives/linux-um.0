Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6cjm-00066y-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:17:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6cjk-0003O4-HS
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:17:48 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96L7Rj06543
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:07:32 -0400
Message-Id: <200310062119.h96LIsGj020742@ccure.karaya.com>
Subject: Re: [uml-devel] unkillable UML threads 
In-Reply-To: Your message of "Wed, 24 Sep 2003 08:40:42 EDT."
             <25476.1064407242@marajade.sandelman.ottawa.on.ca> 
References: <25476.1064407242@marajade.sandelman.ottawa.on.ca> 
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
Date: Mon, 06 Oct 2003 17:18:54 -0400
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net, hugh@mimosa.com, Matt Zimmerman <mdz@debian.org>

mcr@sandelman.ottawa.on.ca said:
> FYI: This is without the skas patch, with a stock RH9 kernel on the
> host.
>
> Any thoughts or coroboration would be appreciated. Clearly this is a
> bug in the RH9 kernel.  

It could easily be a UML bug.  I do have code which continues threads
so that they die properly, but it seems not to be happening here.  Can
you tell me how to reproduce it?

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

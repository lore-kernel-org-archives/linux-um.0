Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5C3L-0008Ak-SL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 16:40:39 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5C3K-0006tE-HU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 16:40:39 -0700
Message-Id: <200409090043.i890hpBP016311@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Compiling UML 2.6.8.1 with Static Linking results in
	segfault 
In-Reply-To: Your message of "Wed, 08 Sep 2004 10:04:40 +1000."
	<200409080004.i8804KC20166@lakshmi.solana.com> 
References: <200409080004.i8804KC20166@lakshmi.solana.com> 
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
Date: Wed, 08 Sep 2004 20:43:51 -0400
To: ralston@stral.net
Cc: user-mode-linux-devel@lists.sourceforge.net

ralston@stral.net said:
> Hey, the core is 20k gzipped :) 

And the core is useless without the binary that produced it.  In any case,
it's probably a lot easier for you to type 'bt' at gdb and send that rather
than compressing a core file and binary and sending them.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

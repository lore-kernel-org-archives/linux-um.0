Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5WDB-0003PC-R0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 12:39:53 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B5WDA-0003pK-9k
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 12:39:52 -0800
Message-Id: <200403222114.i2MLETVB021458@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Problems with Bind9 on UML 2.6.4 
In-Reply-To: Your message of "Sun, 21 Mar 2004 17:12:36 +1100."
	<000001c40f0b$9039a3d0$6401a8c0@vmwinxp> 
References: <000001c40f0b$9039a3d0$6401a8c0@vmwinxp> 
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
Date: Mon, 22 Mar 2004 16:14:29 -0500
To: ralston@stral.net
Cc: user-mode-linux-devel@lists.sourceforge.net

ralston@stral.net said:
> Would I be better of compiling libc6 from source with NPTL/TLS
> disabled? Would it resolve this problem? Or is it a matter of this
> syscall not being implemented in UML? 

Kill is definitely implemented in UML.  This looks like a pthreads thing,
but I don't know what, given you've moved /lib/tls.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

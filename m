Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C51P1-0006fw-1U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 05:18:19 -0700
Received: from webhosting.rdsbv.ro ([213.157.185.164] helo=hosting.rdsbv.ro)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C51Oz-0007Og-8W
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 05:18:18 -0700
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Subject: Re: [uml-devel] Host: 2.6.7, guest: 2.6.8.1, without SKAS
In-Reply-To: <200409071754.25380.ralph@debianbase.de>
Message-ID: <Pine.LNX.4.61.0409081516240.2035@hosting.rdsbv.ro>
References: <Pine.LNX.4.61.0409071058020.25003@hosting.rdsbv.ro>
	<12503.1094564116@camelot-054> <200409071754.25380.ralph@debianbase.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Wed, 8 Sep 2004 15:18:06 +0300 (EEST)
To: Ralph =?iso-8859-1?q?Pa=DFgang?= <ralph@debianbase.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

> I made some experience with 2.6 kernel and I think this are the two most
> common problems for a not correct starting uml:
>
> 1) in the fs of the uml you have to move /lib/tls to /lib/tls.disable (to
> disable ntpl)
>
> 2) if you don't use the skas mode, you HAVE to mount /tmp as tmpfs,  otherwise
> the uml will not start (kernel panics at diffrent locations while booting,
> smetimes it even works without tmpfs)
>
> Point 2 seems to be a bug, but I don't analysed it enough to say why this
> happens...

The kernel is not reaching the point to mount root filesystem.
I just ran ./linux without parameters and I get that.

>
> --Ralph
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

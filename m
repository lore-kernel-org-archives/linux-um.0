Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0uRO-0002PI-Kq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 20:36:02 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D0uRN-0005Zl-4V for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 20:36:02 -0800
Message-ID: <17d401c51318$3da4f1d0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <200502110411.35438.blaisorblade@yahoo.it>
	<169101c512ef$6c905850$0201a8c0@hawk>
	<170001c512f4$2c279940$0201a8c0@hawk>
	<200502150622.j1F6Mo5D005785@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] SKAS-v8: RC2 released against 2.6.7 - 2.6.11-rc3-bk6
	kernels 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Mon, 14 Feb 2005 22:31:32 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

> > [root@host27 root]# /vbin/kernel/2.6.11-rc3-mm2-aio
> > Checking for /proc/mm...found
> > Checking for the skas3 patch in the host...found
> > Checking PROT_EXEC mmap in /tmp...OK
>
> Does this have my exception-table patch in it?
>
> Jeff

Yes.  This is the same UML kernel I had trouble with on my 2.6.7 host, with an older
SKAS version.

-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BSQ75-0004Or-9v for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 May 2004 17:48:15 -0700
Received: from mx15.sac.fedex.com ([199.81.195.17])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BSQ74-0004WK-W9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 May 2004 17:48:15 -0700
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx15.sac.fedex.com (8.12.9p2/8.12.9) with ESMTP id i4P0m41u085593
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 24 May 2004 19:48:04 -0500 (CDT) (envelope-from jchua@fedex.com)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] uml-patch-2.6.6-1
In-Reply-To: <200405241733.i4OHXiWC030995@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0405250845270.3841@boston.corp.fedex.com>
References: <200405241733.i4OHXiWC030995@ccure.user-mode-linux.org>
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
Date: Tue, 25 May 2004 08:47:56 +0800 (SGT)
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Is it possible for you to release one for 2.6.7-rc1?

I haven't tried this latest patch, but my own patches do not work for 
2.6.7-rc1. arch_free_page seems to have a problem in the following 
section...

--- a/mm/page_alloc.c   2004-03-10 08:20:20.000000000 -0500
+++ b/mm/page_alloc.c   2004-03-10 08:34:21.000000000 -0500
@@ -268,6 +268,8 @@
         LIST_HEAD(list);
         int i;

+       arch_free_page(page, order);
+
         mod_page_state(pgfree, 1 << order);
         for (i = 0 ; i < (1 << order) ; ++i)
                 free_pages_check(__FUNCTION__, page + i);
@@ -457,6 +459,8 @@
         struct per_cpu_pages *pcp;
         unsigned long flags;

+       arch_free_page(page, 0);
+
         kernel_map_pages(page, 1, 0);



Thanks,
Jeff
[ jchua@fedex.com ]

On Mon, 24 May 2004, Jeff Dike wrote:

> This patch updates UML to 2.6.6.  Aside from the update, there were a few
> small bug fixes.
>
> The 2.6.6-1 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.6-1.bz2
>
> BK users can pull my 2.5 repository from
> 	http://www.user-mode-linux.org:5000/uml-2.5
>
> For the other UML mirrors and other downloads, see
>        http://user-mode-linux.sourceforge.net/dl-sf.html
>
> Other links of interest:
>
>        The UML project home page : http://user-mode-linux.sourceforge.net
>        The UML Community site : http://usermodelinux.org
>
> 				Jeff
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

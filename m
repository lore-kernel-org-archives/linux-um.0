Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZZna-0000wR-GI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 11:05:58 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZZnZ-0004Vh-Kz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 11:05:58 -0800
Message-ID: <41AE160D.3030807@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.6.9-bb3 on 2.6.9 host problem - triggering a host
	bug?
References: <200411292315.25368.blaisorblade_spam@yahoo.it>
	<200411301950.13529.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411301950.13529.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 01 Dec 2004 20:05:49 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Monday 29 November 2004 23:15, Blaisorblade wrote:
> 
> I pressed Enter before filling in details - this is what I get on some UML 
> versions at startup. Specifically, I get it on -bb3, and on versions based on 
> it, on startup. I've tried removing the patches I've added to -bb3 and it 
> still does not work, which is not nice.
> 
Have started to analyze the crash. If I did it right, the crash occurs at the
beginning of kmem_cache_alloc(). It seems to be called with argument NULL as the
pointer to the cache --> segfault.

Hope, this helps.

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5oUO-000820-MW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Feb 2005 09:15:24 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D5oUN-0000Hj-1q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Feb 2005 09:15:24 -0800
Message-Id: <200502281944.j1SJiHMY003270@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML 2.4 shmem.c changes? panic w/ backtrace 
In-Reply-To: Your message of "Thu, 24 Feb 2005 18:13:30 EST."
	<421E5F9A.6030109@enterasys.com> 
References: <41A35EF5.4080302@enterasys.com>
	<200411240242.iAO2gI7p006614@ccure.user-mode-linux.org>
	<421E5F9A.6030109@enterasys.com> 
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
Date: Mon, 28 Feb 2005 14:44:17 -0500
To: "D. Bahi" <dbahi@enterasys.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

dbahi@enterasys.com said:
> This happens everytime i try to load an application of ours that uses
> shmem for syslog... 

I persist in seeing no particular UML involvement with this crash :-)

Can you boil your app down to a test case which reproduces this?

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

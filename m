Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9wCf-00009u-Ds for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 18:18:09 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9wCb-0001EO-Ue for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 18:18:08 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.11.2) with ESMTP id j2C1Uc415228
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 11 Mar 2005 20:30:39 -0500
Message-Id: <200503120346.j2C3j9Jp006543@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Sat, 12 Mar 2005 00:37:22 +0100."
	<20050311233722.GS3723@stusta.de> 
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
	<20050310225340.GD3205@stusta.de>
	<200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
	<20050311165526.GA3723@stusta.de>
	<200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>
	<20050311233722.GS3723@stusta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on gcc
	version
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
Date: Fri, 11 Mar 2005 22:45:09 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

bunk@stusta.de said:
> No, my claim is that no sane gcc 3.3 defines __gcov_init. 

Ah, OK.  Thanks for the clarification.

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

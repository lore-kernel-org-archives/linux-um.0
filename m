Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1VfQDF-0004r2-7G
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Nov 2013 08:17:41 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VfQDD-0005Il-I3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Nov 2013 08:17:41 +0000
Received: from mail.polarparty.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id A1DB01D1ADD
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Nov 2013 09:14:58 +0100 (CET)
MIME-Version: 1.0
Date: Sun, 10 Nov 2013 09:14:58 +0100
From: stian@nixia.no
In-Reply-To: <527E8E19.9030802@nod.at>
References: "\"<526696BF.6050909@gmx.de>	<CAFLxGvy3NeRKu+KQCCm0j4LS60PYhH0bC8WWjfiPvpstPBjAkA@mail.gmail.com>	<5266A698.10400@gmx.de>"
	<5266B60A.1000005@nod.at>" <52715AD1.7000703@gmx.de>
	<CALYGNiPvJF1u8gXNcX1AZR5-VkGqJnaose84KBbdaoBAq8aoGQ@mail.gmail.com>
	<527AB23D.2060305@gmx.de> <527AB51B.1020005@nod.at>
	<527E87EA.8080700@gmx.de> <527E8E19.9030802@nod.at>
Message-ID: <56aa66a93cc354b5787492526a9bcd49@nixia.no>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] fuzz tested 32 bit user mode linux image hangs in
 radix_tree_next_chunk()
To: user-mode-linux-devel@lists.sourceforge.net


> You cannot build Linux with -O1/O0.
> Try printing the value using printk...

Or even printf(), since this an UML kernel.

Stian

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


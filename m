Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <davem@davemloft.net>) id 1RyUzo-0005Fd-HP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2012 21:05:36 +0000
Received: from shards.monkeyblade.net ([198.137.202.13])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RyUzk-0004Qi-Gc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2012 21:05:36 +0000
Date: Fri, 17 Feb 2012 16:05:12 -0500 (EST)
Message-Id: <20120217.160512.672160259202281785.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1329493411-25750-11-git-send-email-danny.kukawka@bisect.de>
References: <1329493411-25750-1-git-send-email-danny.kukawka@bisect.de>
	<1329493411-25750-11-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] [PATCH 10/10] UML net: set addr_assign_type if
 random_ether_addr() used
To: danny.kukawka@bisect.de
Cc: user-mode-linux-devel@lists.sourceforge.net, jpirko@redhat.com, richard@nod.at, jdike@addtoit.com, dkukawka@suse.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Fri, 17 Feb 2012 16:43:31 +0100

> Set addr_assign_type correctly to NET_ADDR_RANDOM in case
> a random MAC address was generated and assigned to the netdevice.
> 
> Return state from setup_etheraddr() about returning a random
> MAC address or not and check this state in eth_configure().
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Applied.

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


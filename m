Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <davem@davemloft.net>) id 1P18sL-0008AQ-Q8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2010 02:28:01 +0000
Received: from 74-93-104-97-washington.hfc.comcastbusiness.net ([74.93.104.97]
	helo=sunset.davemloft.net)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P18sK-0001m1-Px for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2010 02:28:01 +0000
Date: Wed, 29 Sep 2010 19:28:16 -0700 (PDT)
Message-Id: <20100929.192816.116374275.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTikX1xWiZ+XROF=CEvkE+BVpv6vk5vzW2BGt-bxq@mail.gmail.com>
References: <AANLkTi=E7+CpJZE3XC7O1LvJu6LWfmvSxonskH4CYg25@mail.gmail.com>
	<4CA2FA13.8050405@panasas.com>
	<AANLkTikX1xWiZ+XROF=CEvkE+BVpv6vk5vzW2BGt-bxq@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] um: Proper Fix for f25c80a4: remove
 duplicate structure field initialization
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
To: torvalds@linux-foundation.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, julia@diku.dk, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, shemminger@vyatta.com

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Sep 2010 08:05:04 -0700

> On Wed, Sep 29, 2010 at 1:34 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>>
>> On the other hand patch [f25c80a4] was trying to use eth_mac_addr()
>> in eth_configure(), *which was the real fallout*. Because of state
>> checks done inside eth_mac_addr() the address was never set. I have
>> not reintroduced the memcpy wrapper, but I've put a comment for future
>> cats.
> 
> Ahh. Ok, this looks fine. David, please use this instead of my broken
> one that didn't do the whole thing.

Oops, I just noticed this, ok will do.

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


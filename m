Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bunqz-0001DG-Ba for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Aug 2004 00:48:57 -0700
Received: from sccrmhc12.comcast.net ([204.127.202.56])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bunqz-000413-2O for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Aug 2004 00:48:57 -0700
Message-ID: <4119C25D.9000604@hevanet.com>
From: Matt Clay <mattclay@hevanet.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Testing needed for terminal handling patches
References: <200408100515.i7A5FUQW027590@ccure.user-mode-linux.org>
In-Reply-To: <200408100515.i7A5FUQW027590@ccure.user-mode-linux.org>
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
Date: Tue, 10 Aug 2004 23:53:17 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> 
> I'd like people to try them out and report bad experiences, especially if you
> saw the 'netdevice 0' hang or stairstepping output during boot.  They are the
> catch-eintr, bb-raw, and clean-raw patches.

Looks good, no more stairstepping during boot. :)

  - Matt


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

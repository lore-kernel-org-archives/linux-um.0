Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvgOz-0006Dw-WD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2004 11:03:41 -0700
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BvgOy-00036W-Nh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2004 11:03:41 -0700
Message-ID: <411D01F6.9030209@nortelnetworks.com>
From: "Joe Marzot" <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] handle_trap - failed to wait at end of syscall [was
	Re: [uml-devel] debugging UML cores]
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<411B8E89.5040407@nortelnetworks.com>
	<411CE23C.4070903@nortelnetworks.com>
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
Date: Fri, 13 Aug 2004 14:01:26 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Marzot, Joe [BL60:NP72:EXCH] wrote:
> (gdb) p status
> $7 = 383
> 
> WSTOPSIG(err) = SIGHUP
> 

that should be

WSTOPSIG(status) = SIGHUP

of course. -g



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

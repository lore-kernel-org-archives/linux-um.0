Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvHOd-0000z5-5C for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 08:21:39 -0700
Received: from zsc3s004.nortelnetworks.com ([47.81.138.65])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BvHOc-0007vk-T6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 08:21:39 -0700
Message-ID: <411B8AF2.2080007@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] debugging UML cores
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
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
Date: Thu, 12 Aug 2004 11:21:22 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> gmarzot@nortelnetworks.com said:
>  > I am getting a variety of cores from UML - fairly intermittent. The
>  > bad  part is that examining these cores with GDB is utterly fruitless
>  > (for  me). Are there some tricks beyond the normal stuff below I
>  > should be  doing to get a better sense of what is going wrong? I see
>  > no back trace  and no thread info.
> 
> That is utterly confused.  I would make sure that you are absolutely 
> positive
> that you are giving gdb the exact binary that created the core.
> 
>                                 Jeff
> 
> 

hi,

I am 99% sure. Is there a way from the core to see if it agrees with 
binary...to see if some key info matches.

I can try to make both available to you some place if that helps. 
regards, Giovanni



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

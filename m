Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvIFo-0008An-Ct for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 09:16:36 -0700
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BvIFn-0007tl-UA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 09:16:36 -0700
Message-ID: <411B97D4.8050404@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] debugging UML cores
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<411B8AF2.2080007@nortelnetworks.com>
	<200408121656.i7CGu9JA002736@ccure.user-mode-linux.org>
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
Date: Thu, 12 Aug 2004 12:16:20 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> gmarzot@nortelnetworks.com said:
> 
>>I am 99% sure. Is there a way from the core to see if it agrees with
>>binary...to see if some key info matches. 
> 
> 
> I would be most concerned about whether the binary had been rebuilt since the
> core happend.  gdb will tell you the path of the thing that dumped core -
> presumably that matched.  The other thing would be to check the dates, to
> see that the binary is older than the core.

all checks out.

> 
> If that's all OK, you could try a different version of gdb.  We've had problems
> with some versions not producing good stacks.

that's what I thought so I got a new gdb 6.2 and no help.

do you recommend a combination gcc/gdb libc libpthread that all play 
nice together?

regards, G

> 
> 				Jeff
> 
> 





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

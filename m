Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvHuw-0001wa-RI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 08:55:02 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BvHuw-0003GV-CJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Aug 2004 08:55:02 -0700
Message-Id: <200408121656.i7CGu9JA002736@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] debugging UML cores 
In-Reply-To: Your message of "Thu, 12 Aug 2004 11:21:22 EDT."
	<411B8AF2.2080007@nortelnetworks.com> 
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<411B8AF2.2080007@nortelnetworks.com> 
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
Date: Thu, 12 Aug 2004 12:56:09 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

gmarzot@nortelnetworks.com said:
> I am 99% sure. Is there a way from the core to see if it agrees with
> binary...to see if some key info matches. 

I would be most concerned about whether the binary had been rebuilt since the
core happend.  gdb will tell you the path of the thing that dumped core -
presumably that matched.  The other thing would be to check the dates, to
see that the binary is older than the core.

If that's all OK, you could try a different version of gdb.  We've had problems
with some versions not producing good stacks.

				Jeff



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bv7OD-0005OW-Px for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Aug 2004 21:40:33 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bv7OD-0007Y9-BE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Aug 2004 21:40:33 -0700
Message-Id: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] debugging UML cores 
In-Reply-To: Your message of "Wed, 11 Aug 2004 11:32:06 EDT."
	<411A3BF6.8020003@nortelnetworks.com> 
References: <411A3BF6.8020003@nortelnetworks.com> 
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
Date: Thu, 12 Aug 2004 01:41:36 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

gmarzot@nortelnetworks.com said:
> I am getting a variety of cores from UML - fairly intermittent. The
> bad  part is that examining these cores with GDB is utterly fruitless
> (for  me). Are there some tricks beyond the normal stuff below I
> should be  doing to get a better sense of what is going wrong? I see
> no back trace  and no thread info.

That is utterly confused.  I would make sure that you are absolutely positive
that you are giving gdb the exact binary that created the core.

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

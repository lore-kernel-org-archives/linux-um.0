Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bxf3m-0007tA-LB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 22:01:58 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bxf3k-0001Kw-K8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 22:01:58 -0700
Message-Id: <200408190603.i7J63Zek004748@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] mem= and large file support 
In-Reply-To: Your message of "Wed, 18 Aug 2004 22:51:28 EDT."
	<412415B0.5060102@enterasys.com> 
References: <412415B0.5060102@enterasys.com> 
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
Date: Thu, 19 Aug 2004 02:03:35 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

dbahi@enterasys.com said:
> btw: with the 26-3um and 2.6.8.1 announce Jeff mentions the new SKAS,
> ! TT, STATIC allows mem= ~2.75G upper limit but do we need O_LARGEFILE
> somewhere? or to compile with -D_FILE_OFFSET_64_BITS 

Probably.  Can you strace that and see where E2BIG is coming from?

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

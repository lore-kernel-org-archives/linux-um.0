Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BuHFA-0000oY-Uy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Aug 2004 13:59:44 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BuHFA-00054h-Gv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Aug 2004 13:59:44 -0700
Message-Id: <200408092158.i79LwaQW026235@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] corrections to 2.4 series incrementals: fix-smp 
In-Reply-To: Your message of "Fri, 06 Aug 2004 14:51:04 EDT."
	<4113D318.2030407@enterasys.com> 
References: <4113D318.2030407@enterasys.com> 
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
Date: Mon, 09 Aug 2004 17:58:36 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

dbahi@enterasys.com said:
> The line in the available patch incorrectly adds this line:
>   define_bool CONFIG_SMP $CONFIG_UML_SMP
> And thus it fails to apply. 

That was a quilt botch.  It's fixed now.

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

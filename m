Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200408092128.i79LSqQW025765@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] PATCH -- Was: link error MODE_SKAS and ! MODE_TT in
	2.4.26-2 + uml.sf.net patches 
In-Reply-To: Your message of "Fri, 06 Aug 2004 16:29:12 EDT."
	<4113EA18.3040506@enterasys.com> 
References: <410E5994.4060606@enterasys.com> <410E5CFA.5000504@enterasys.com>
	<4113EA18.3040506@enterasys.com> 
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
Date: Mon, 09 Aug 2004 17:28:52 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

dbahi@enterasys.com said:
> this patch fixes the unresolved link time error with a conditional
> around the definition of CAN_KMALLOC 

I don't see that here.  If you look at the definition of CHOOSE_MODE, you'll
see that it's conditional on CONFIG_MODE_TT and CONFIG_MODE_SKAS in such a
way that if a mode is configured out, any code associated with it disappears.

I think you didn't do that build from a clean pool.

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

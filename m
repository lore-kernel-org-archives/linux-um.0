Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bveg1-0004mq-Rv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2004 09:13:09 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bveg1-0003A0-7n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2004 09:13:09 -0700
From: Allen Chan <alydar@users.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131213.16558.alydar@users.sourceforge.net>
Subject: [uml-devel] Latest 2.6.7 incremental patches
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
Date: Fri, 13 Aug 2004 12:13:16 -0400
To: user-mode-linux-devel@lists.sourceforge.net

There is a slight problem with the patch named 
dont-need-no-steenking-linker-script.  The original 
arch/um/kernel/vmlinux.lds.S file is only 11 lines long with all the 
substance coming from an include statement.  The patch is assuming a 
much larger file without the include statement.

If I zero out the arch/um/kernel/vmlinux.lds.S file manually, the 
compile goes fine and the resulting kernel appears to be working fine 
(so far).


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

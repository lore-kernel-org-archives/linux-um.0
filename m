Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxsTX-0004P0-Vg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Aug 2004 12:21:27 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BxsTW-0008Uo-FR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Aug 2004 12:21:27 -0700
Received: from zsc3c028.us.nortel.com (zsc3c028.us.nortel.com [47.81.138.28])
	by zrc2s0jx.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id i7JJLHY13038
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Aug 2004 14:21:18 -0500 (CDT)
Message-ID: <4124FDAC.7020302@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel panic: restore_registers - saving registers failed,
	errno = 3 - skas 2.4.24 + 2.4.24_1um
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
Date: Thu, 19 Aug 2004 15:21:16 -0400
To: user-mode-linux-devel@lists.sourceforge.net



Another bug we tracking...this one would occur *very* infrequently until 
I just tried something a little different. instead of con0=xterm I 
started doing con0=null,fd:1 or con0=pts,fd:1 or whatever and now I get 
the panic 50% of the time right as the boot sequence ends the login 
prompt is presented...

Am I doing something obviously daft?

anything to check?

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

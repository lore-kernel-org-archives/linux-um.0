Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ab0Ts-0007tB-Ml
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Dec 2003 08:43:00 -0800
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ab0Ts-00023b-BG
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Dec 2003 08:43:00 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx13.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id hBTGgqw1063631
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Dec 2003 10:42:52 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet04.prod.fedex.com (8.12.10/8.12.10) with ESMTP id hBTGgpCq023101
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Dec 2003 10:42:51 -0600 (CST)
Received: from silk.corp.fedex.com (silk.corp.fedex.com [155.161.201.173])
	by silk.corp.fedex.com (8.11.4/8.11.4) with ESMTP id hBTGfG025538
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Dec 2003 00:41:16 +0800
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.58.0312300035190.24938@silk.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] can't set console on 2.6.0
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 30 Dec 2003 00:41:16 +0800 (SGT)
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


On 2.6.0 uml, is there's a way to use the same screen to boot up uml
without opening new xterm windows?  On 2.4.x, I can make it work with the
following line ...

	linux ro con0=null,fd:2 con1=fd:0,fd:1 ubda=/tmp/disk1

Starting the above on an xterm will boot up uml linux on the same screen,
and display the login prompt on the same window.



Thanks,
Jeff
[ jchua@fedex.com ]


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

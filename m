Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GL3jt-0006YI-Eg for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 13:11:13 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GL3jp-0000r8-KF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 13:11:10 -0700
Received: from [192.168.0.6] (82-45-188-221.cable.ubr02.camd.blueyonder.co.uk
	[82.45.188.221])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 52EC0439A8
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  6 Sep 2006 21:11:00 +0100 (BST)
Message-ID: <44FF2B54.5020201@nagafix.co.uk>
Date: Wed, 06 Sep 2006 21:11:00 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <mailman.1307.1157397566.8760.user-mode-linux-user@lists.sourceforge.net>
In-Reply-To: <mailman.1307.1157397566.8760.user-mode-linux-user@lists.sourceforge.net>
Subject: [uml-devel] virtual framebuffer device visible on host
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Just a thought, but how hard would it be to have a virtual device in the 
guests that mimics a framebuffer device and is in fact an X window on 
the host? I think this could almost be a killer-app.
Or is there already a way to do this using VFB?
Surely an X window is rich enough to provide all the primitives that a 
framebuffer device provides?

Antoine

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

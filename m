Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XW6ro-00089d-Ce
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:53:36 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XW6rn-0001i3-2C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:53:36 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab3.miniserver.com with esmtps
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XW6qj-0001BO-7M
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 16:52:29 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80]
	helo=MonstrousNightmare.cisco.com)
	by falkor.sigsegv.cx with esmtp (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XW6rf-0002Zt-98
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 17:53:27 +0100
From: anton.ivanov@kot-begemot.co.uk
Date: Mon, 22 Sep 2014 17:53:13 +0100
Message-Id: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Updated Performance Improvements patchset
To: user-mode-linux-devel@lists.sourceforge.net

This is an update of the performance improvement patchset, it 
addresses a number of issues resulting from porting what was
originally written for 3.3.8 to the current linux kernel. 

Changes (where applicable) are annotated in actual patchsets.

A.

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


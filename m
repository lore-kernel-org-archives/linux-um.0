Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1coqCp-0007IR-8I
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 11:38:03 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1coqCo-0002o3-7n
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 11:38:03 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
	helo=smaug.kot-begemot.co.uk) by www.kot-begemot.co.uk with esmtps
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1coqCh-0007lO-Qe
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 11:37:55 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1coqCh-0002jE-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 11:37:55 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <f3d26496-060e-e7b2-0a77-178040385e8a@kot-begemot.co.uk>
Date: Fri, 17 Mar 2017 11:37:55 +0000
MIME-Version: 1.0
Subject: [uml-devel] Interrupt controller
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi Richard, hi list,

I finally figured out what was going wrong with my Epoll IRQ controller POC.

I have a working one now. I will submit it after I have done some more 
extensive tests on it.

So far it is showing 10-20% improvements in IO in default config (one 
Ethernet, one UBD). This should be significantly better with a lot of 
devices as it scales much better than the poll based one.

A.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


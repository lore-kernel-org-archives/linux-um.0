Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pki@ex.com.pl>) id 1NC9Ck-00044n-Q5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2009 09:58:02 +0000
Received: from mx-out.strefa.interia.pl ([217.74.66.65])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NC9Ci-0006DQ-Ee for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2009 09:58:02 +0000
Received: from zgred (202-goc-3.acn.waw.pl [62.121.86.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.strefa.pl (Postfix) with ESMTPSA id 2AE3E180001E4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Nov 2009 10:41:00 +0100 (CET)
Received: from pki by zgred with local (Exim 4.69)
	(envelope-from <pki@ex.com.pl>) id 1NC8wH-0000vR-7C
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2009 10:41:01 +0100
Date: Sun, 22 Nov 2009 10:41:01 +0100
From: Piotr Isajew <pki@ex.com.pl>
Message-ID: <20091122094101.GA3531@zgred.home.aster.pl>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] vm crashes on x86_64 (multiple vms)
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

Hello,

I'm using UML to emulate up to four virtual networks of four nodes each
(using tap, uml_switch and ppp between virtual nodes). UML
is built using custom kernel configuration and runs on 64 bit
AMD. Everything works well if if run up to 3 virtual networks (12
nodes), but when i start fourth virtual network it's third virtual
machine always dies with something, that is reported on host logs as:

[71175.799976] linux[621] general protection ip:7f72d6110a1c sp:6027b760 error:0 in libc-2.9.so[7f72d60dc000+167000]


I tried with 2.6.31.2 and 2.6.32-rc8 kernels for guest machines. Host
runs 2.6.31.2 kernel. Will be glad to provide you with more info and
help with tracking that problem down.

Regards,

Piotr

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


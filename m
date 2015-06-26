Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z8P7d-0003rB-Tm
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2015 08:36:29 +0000
Received: from mail-wg0-f44.google.com ([74.125.82.44])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z8P7d-0006p4-7k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2015 08:36:29 +0000
Received: by wgck11 with SMTP id k11so82451436wgc.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Jun 2015 01:36:23 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Fri, 26 Jun 2015 10:36:13 +0200
Message-Id: <1435307774-3897-1-git-send-email-hwhilse@gmail.com>
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
Subject: [uml-devel] [PATCH] missed musl compatibility patch
To: user-mode-linux-devel@lists.sourceforge.net

I'm sorry but one patch that is necessary for compilation against
musl libc was still missing in the series I sent earlier.
(Thank you very much for applying!)

This is a bit awkward: It looked so nice and clean to just call
"modify_ldt()" before. The external declaration is a hint that not
all was well. Looking at modify_ldt(2), making the syscall via
syscall() ourselves is actually the recommended way, so I hope
it isn't too troublesome a patch.

Hans-Werner Hilse (1):
  um: Do not rely on libc to provide modify_ldt()

 arch/x86/um/ldt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.4.3


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


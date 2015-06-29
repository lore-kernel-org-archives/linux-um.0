Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z9Vi0-0003mb-Fc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 09:50:36 +0000
Received: from mail-wg0-f45.google.com ([74.125.82.45])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z9Vhy-0004mf-MG
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 09:50:36 +0000
Received: by wguu7 with SMTP id u7so136456353wgu.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 Jun 2015 02:50:28 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Mon, 29 Jun 2015 11:50:31 +0200
Message-Id: <1435571432-21125-1-git-send-email-hwhilse@gmail.com>
In-Reply-To: <3faa85268de72e64ff74175f2cf74021@hilses.de>
References: <3faa85268de72e64ff74175f2cf74021@hilses.de>
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
Subject: [uml-devel] [PATCH v2] missed musl compatibility patch
To: user-mode-linux-devel@lists.sourceforge.net

Updated patch to provide our own mofify_ldt() wrapper.
The earlier version did not take into account that outside
the "os-Linux" directories the host API is not accessible.

However, an according syscall() definition is in os.h, which
is already included. The syscall number can be taken from
the kernel space definition as __NR_modify_ldt.

Hans-Werner Hilse (1):
  um: Do not rely on libc to provide modify_ldt()

 arch/x86/um/ldt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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


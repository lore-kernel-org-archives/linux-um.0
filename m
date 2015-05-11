Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YrwCD-0007Yj-5g
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:09 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YrwCB-00058f-Ut for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 22:29:09 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 May 2015 00:28:50 +0200
Message-Id: <1431383335-15315-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] Rework UML's uaccess code
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

By reusing asm-generic/uaccess.h we can drop a lot of UML's
ad-hoc uaccess code and make it much more straightforward.
It uncovered also some header issues which got resolved.

[PATCH 1/5] um: Cleanup mem_32/64.c headers
[PATCH 2/5] um: Add asm/elf.h to vma.c
[PATCH 3/5] um: Add uaccess.h to syscalls_64.c
[PATCH 4/5] um: Add uaccess.h to ldt.c
[PATCH 5/5] um: Rework uaccess code

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


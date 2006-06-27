Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvJyi-0000ka-Lw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 13:16:08 -0700
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]
	helo=sous-sol.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FvJyi-0004xG-9e
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 13:16:08 -0700
Message-Id: <20060627201423.217921000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
Date: Tue, 27 Jun 2006 00:00:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
Content-Disposition: inline; filename=uml-fix-uptime.patch
Subject: [uml-devel] [PATCH 15/25] UML: fix uptime
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org, Chris Wedgwood <reviews@ml.cw.f00f.org>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jeff Dike <jdike@addtoit.com>

The use of signed instead of unsigned here broke the calculations on
negative numbers that are involved in calculating wall_to_monotonic.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/um/kernel/time_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.1.orig/arch/um/kernel/time_kern.c
+++ linux-2.6.17.1/arch/um/kernel/time_kern.c
@@ -87,7 +87,7 @@ void timer_irq(union uml_pt_regs *regs)
 
 void time_init_kern(void)
 {
-	unsigned long long nsecs;
+	long long nsecs;
 
 	nsecs = os_nsecs();
 	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,

--

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

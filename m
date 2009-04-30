Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tabbott@MIT.EDU>) id 1LzgBV-0002ZL-QD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 May 2009 00:00:57 +0000
Received: from biscayne-one-station.mit.edu ([18.7.7.80])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LzgBT-0003ey-Iz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 May 2009 00:00:57 +0000
From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 19:59:45 -0400
Message-Id: <1241135986-10051-1-git-send-email-tabbott@mit.edu>
Subject: [uml-devel] [PATCH] section name cleanup for um
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Dike <jdike@addtoit.com>, Jeff Arnold <jbarnold@MIT.EDU>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Tim Abbott <tabbott@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>

This patch series cleans up the section names on the um
architecture.  It requires the architecture-independent macro
definitions from this patch series:

<http://www.spinics.net/lists/mips/msg33499.html>

The long-term goal here is to add support for building the kernel with
-ffunction-sections -fdata-sections.  This requires renaming all the
magic section names in the kernel of the form .text.foo, .data.foo,
.bss.foo, and .rodata.foo to not have collisions with sections
generated for code like:

static int nosave = 0; /* -fdata-sections places in .data.nosave */
static void head(); /* -ffunction-sections places in .text.head */

Note that these patches have not been boot-tested (aside from testing
the analogous changes on x86), since I don't have access to the
appropriate hardware.

	-Tim Abbott


Tim Abbott (1):
  um: use new macros for .data.init_task.

 arch/um/kernel/dyn.lds.S   |    3 +--
 arch/um/kernel/init_task.c |    3 +--
 arch/um/kernel/uml.lds.S   |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hvxtd-0006RW-TK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 08:58:05 -0700
Received: from gw-e.panasas.com ([65.194.124.178] helo=cassoulet.panasas.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hvxtd-0005KP-CL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 08:58:05 -0700
Received: from riverside.int.panasas.com (localhost.localdomain [127.0.0.1])
	by cassoulet.panasas.com (8.13.1/8.13.1) with ESMTP id l56Fw2oE025696
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 6 Jun 2007 11:58:02 -0400
Message-ID: <4666D988.9070409@panasas.com>
Date: Wed, 06 Jun 2007 18:58:00 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: [uml-devel] KERNEL_STACK_ORDER = 0 in 2.6.22-rc4 make defconfig
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

if I do "make ARCH=um KBUILD_OUTPUT=.build_um defconfig" in 2.6.22-rc4
I see that KERNEL_STACK_ORDER == 0. The resulting kernel will not boot my
FedoraCore5-AMD64-root_fs. Manually editing to 1 will fix that.
(By the way: can I change it inside make xconfig?)

In previous kernels 2.6.19-2.6.21 I used to get == 2. What is the recommended value
for this CONFIG option?

My compiling/host is a RHEL 4 x86_64 (with various kernels).

Boaz Harrosh

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

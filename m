Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <openosd@gmail.com>) id 1LfCTF-0005SN-Vv
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 12:14:37 +0000
Received: from mail-qy0-f107.google.com ([209.85.221.107])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LfCTE-0006QB-Ic for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 12:14:37 +0000
Received: by qyk5 with SMTP id 5so63416qyk.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 05 Mar 2009 04:14:34 -0800 (PST)
Message-ID: <49AFC206.9080004@panasas.com>
Date: Thu, 05 Mar 2009 14:13:58 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: [uml-devel] um: WARNING: vmlinux: 'memcpy' exported twice. Previous
 export was in vmlinux
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>

On today's linus v2.6.29-rc7-3-g559595a

Doing make ARCH=um defconfig & make ARCH=um
give's me:

LD vmlinux.o
MODPOST vmlinux.o
WARNING: vmlinux: 'memcpy' exported twice. Previous export was in vmlinux


Sorry if this is a duplicate report

Boaz


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


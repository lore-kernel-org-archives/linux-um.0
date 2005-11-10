Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ea6Cg-0000ny-CX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 22:46:34 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ea6Ce-0004hY-GH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 22:46:34 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ea6BI-0005uQ-QP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Nov 2005 07:45:12 +0100
Received: from dslb-082-083-000-204.pools.arcor-ip.net ([82.83.0.204])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 10 Nov 2005 07:45:08 +0100
Received: from skoehler by dslb-082-083-000-204.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 10 Nov 2005 07:45:08 +0100
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <dkuq7o$u24$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] errors in uml-guest log
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 10 Nov 2005 07:43:17 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

an UML-guest-kernel 2.6.14 (without any additional patches) is running
on a host with kernel 2.6.12.3-skas3-v8.2 host.
Can anybody explain this error-message to me, which occur periodically
in the guests log:

Badness in handle_page_fault at arch/um/kernel/trap_kern.c:98
0f3d3b30:  [<08062f04>] handle_page_fault+0x1c4/0x260
0f3d3b70:  [<08063047>] segv+0xa7/0x2e0
0f3d3b90:  [<080ba701>] sys_read+0x51/0x80
0f3d3bd0:  [<08053680>] init_udf_fs+0x30/0x50
0f3d3c00:  [<08053680>] init_udf_fs+0x30/0x50
0f3d3c20:  [<08053680>] init_udf_fs+0x30/0x50
0f3d3c40:  [<08065291>] get_skas_faultinfo+0x51/0xc0
0f3d3c60:  [<08065358>] handle_segv+0x58/0x60
0f3d3c80:  [<08065a1d>] userspace+0x1ed/0x220
0f3d3cd0:  [<08066d94>] force_flush_all_skas+0x44/0x50
0f3d3cf0:  [<08066621>] fork_handler+0xc1/0xe0


And might anybody have a sollution for me? Is it just, that i need to
upgrade the host?


Let me know, if you need additional infos.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

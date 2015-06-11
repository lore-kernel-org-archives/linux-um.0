Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2yoG-0003O7-Eq
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:04 +0000
Received: from mail-wi0-f174.google.com ([209.85.212.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2yoF-000391-Kt
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:04 +0000
Received: by wifx6 with SMTP id x6so4436356wif.0
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2015 02:29:57 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Thu, 11 Jun 2015 11:29:17 +0200
Message-Id: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
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
Subject: [uml-devel] [PATCH v2 0/3] musl compatibility patches
To: User-mode-linux-devel@lists.sourceforge.net

This set of patches facilitate compilation with the musl libc,
either linked to shared libraries or static.

Hans-Werner Hilse (3):
  um: Do not use __ptr_t type for stack_t's .ss pointer
  um: Do not use stdin and stdout identifiers for struct members
  um: Include sys/types.h for makedev(), major(), minor()

 arch/um/drivers/harddog_user.c         | 18 +++++++++---------
 arch/um/drivers/net_user.c             |  6 +++---
 arch/um/drivers/slip_user.c            | 14 +++++++-------
 arch/um/drivers/slirp_user.c           | 16 ++++++++--------
 arch/um/os-Linux/drivers/tuntap_user.c |  6 +++---
 arch/um/os-Linux/file.c                |  1 +
 arch/um/os-Linux/signal.c              |  8 +++++---
 7 files changed, 36 insertions(+), 33 deletions(-)

-- 
2.4.2


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


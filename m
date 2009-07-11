Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <weiyi.huang@gmail.com>) id 1MPRXp-0003Hg-OO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Jul 2009 01:38:29 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPRXj-0007vT-06 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Jul 2009 01:38:29 +0000
Received: by pzk8 with SMTP id 8so935019pzk.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 10 Jul 2009 18:38:21 -0700 (PDT)
From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Sat, 11 Jul 2009 09:32:36 +0800
Message-Id: <1247275956-1248-1-git-send-email-weiyi.huang@gmail.com>
Subject: [uml-devel] [PATCH 06/15] uml: remove duplicated #include
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
To: jdike@linux.intel.com
Cc: Huang Weiyi <weiyi.huang@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

Remove duplicated #include('s) in
  arch/um/os-Linux/helper.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/um/os-Linux/helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 30860b8..b6b1096 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -15,7 +15,6 @@
 #include "os.h"
 #include "um_malloc.h"
 #include "user.h"
-#include <linux/limits.h>
 
 struct helper_data {
 	void (*pre_exec)(void*);
-- 
1.6.1.2


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


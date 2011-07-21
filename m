Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QjpPC-0006uu-DU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:54 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QjpP8-0004Wy-AE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:54 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Jul 2011 11:18:27 +0200
Message-Id: <1311239914-8301-3-git-send-email-richard@nod.at>
In-Reply-To: <1311239914-8301-1-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 03/10] uml: drivers/slip_user.c memory leak fix
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Vitaliy Ivanov <vitalivanov@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Vitaliy Ivanov <vitalivanov@gmail.com>

Do not free memory when you failed to allocate it.

Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/slip_user.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index a1c2d2c..cbacfc4 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -102,7 +102,7 @@ static int slip_tramp(char **argv, int fd)
 		       "buffer\n");
 		os_kill_process(pid, 1);
 		err = -ENOMEM;
-		goto out_free;
+		goto out_close;
 	}
 
 	close(fds[1]);
@@ -112,7 +112,6 @@ static int slip_tramp(char **argv, int fd)
 	err = helper_wait(pid);
 	close(fds[0]);
 
-out_free:
 	kfree(output);
 	return err;
 
-- 
1.7.6


------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


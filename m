Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7kS-0001EM-Tt	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:08 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI7kS-0003xg-HT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:09 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921163855.30500.65000.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 04/10] uml: fix modify_ldt - missing break in
	switch
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
Date: Wed, 21 Sep 2005 18:38:57 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I am a lamer :-(. Luckily, Luo Xin performed LTP testing and found this failure.
Btw, the fact that the patch in which I introduced this was merged shows that:

a) I'm really trusted by people
b) sometimes they're wrong about point a).
c) lack of time for reviewers.

CC: Luo Xin <luothing@sina.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-i386/ldt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -83,6 +83,7 @@ int sys_modify_ldt(int func, void __user
 			goto out;
 		}
 		p = buf;
+		break;
 	default:
 		res = -ENOSYS;
 		goto out;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

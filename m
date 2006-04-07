Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0p-0003HF-Gn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:35 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0j-0003Zr-17
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:32 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143110.19201.91963.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 09/17] uml: fix critical typo for TT mode
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
Date: Fri, 07 Apr 2006 16:31:10 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Noticed this for a compilation-time warning, so I'm fixing it even for TT mode -
this is not put_user, but copy_to_user, so we need a pointer to sp, not sp
itself (we're trying to write the word pointed to by the "sp" var.).

Jeff, have I misunderstood anything?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-i386/signal.c   |    2 +-
 arch/um/sys-x86_64/signal.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/sys-i386/signal.c b/arch/um/sys-i386/signal.c
index f5d0e1c..618fd85 100644
--- a/arch/um/sys-i386/signal.c
+++ b/arch/um/sys-i386/signal.c
@@ -147,7 +147,7 @@ int copy_sc_to_user_tt(struct sigcontext
 	 * delivery.  The sp passed in is the original, and this needs
 	 * to be restored, so we stick it in separately.
 	 */
-	err |= copy_to_user(&SC_SP(to), sp, sizeof(sp));
+	err |= copy_to_user(&SC_SP(to), &sp, sizeof(sp));
 
 	if(from_fp != NULL){
 		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index e75c4e1..a4c46a8 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -137,7 +137,7 @@ int copy_sc_to_user_tt(struct sigcontext
 	 * delivery.  The sp passed in is the original, and this needs
 	 * to be restored, so we stick it in separately.
 	 */
-	err |= copy_to_user(&SC_SP(to), sp, sizeof(sp));
+	err |= copy_to_user(&SC_SP(to), &sp, sizeof(sp));
 
 	if(from_fp != NULL){
 		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

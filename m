Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEsJf-0000h1-Cg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 09:37:31 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEsJQ-0002CX-Gm for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 09:37:31 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041005162736.6F03DB007@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml:makefile whitespace fix
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
Date: Tue, 05 Oct 2004 18:27:36 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Change the spacing for this command to fix alignment on output.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/Makefile~uml-kbuild-whitespace-fix arch/um/kernel/Makefile
--- linux-2.6.9-current/arch/um/kernel/Makefile~uml-kbuild-whitespace-fix	2004-10-05 18:25:45.225466464 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/Makefile	2004-10-05 18:25:45.227466160 +0200
@@ -35,7 +35,7 @@ $(USER_OBJS) : %.o: %.c
 
 QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
 
-quiet_cmd_quote = QUOTE $@
+quiet_cmd_quote = QUOTE   $@
 cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
 
 targets += config.c
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

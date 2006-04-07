Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0n-0003HI-MD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:33 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0j-0003Zq-17
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:33 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143054.19201.89200.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 03/17] uml: fix 2 harmless cast warnings for 64-bit
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
Date: Fri, 07 Apr 2006 16:30:54 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix two harmless warnings in 64-bit compilation (the 2nd doesn't trigger for now
because of a missing __attribute((format)) for cow_printf, but next patches fix
that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow_user.c      |    3 ++-
 arch/um/drivers/mconsole_kern.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index a9afccf..0ec4052 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -210,8 +210,9 @@ int write_cow_header(char *cow_file, int
 
 	err = -EINVAL;
 	if(strlen(backing_file) > sizeof(header->backing_file) - 1){
+		/* Below, %zd is for a size_t value */
 		cow_printf("Backing file name \"%s\" is too long - names are "
-			   "limited to %d characters\n", backing_file,
+			   "limited to %zd characters\n", backing_file,
 			   sizeof(header->backing_file) - 1);
 		goto out_free;
 	}
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 28e3760..f8c6269 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -616,7 +616,7 @@ static void console_write(struct console
 		return;
 
 	while(1){
-		n = min((size_t)len, ARRAY_SIZE(console_buf) - console_index);
+		n = min((size_t) len, ARRAY_SIZE(console_buf) - console_index);
 		strncpy(&console_buf[console_index], string, n);
 		console_index += n;
 		string += n;


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

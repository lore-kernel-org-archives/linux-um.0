Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Es0pm-0000TJ-Vc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:40:58 -0800
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Es0pj-0001PM-GE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Dec 2005 08:40:58 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051229163959.4985.38748.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 4/5] Hostfs: update for new glibc - add missing
	symbol exports
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
Date: Thu, 29 Dec 2005 17:39:59 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Today, when compiling UML, I got warnings for two used unexported symbols:
readdir64 and truncate64. Indeed, my glibc headers are aliasing readdir to
readdir64 and truncate to truncate64 (and so on).

I'm then adding additional exports. Since I've no idea if the symbols where
always provided in the supported glibc's, I've added weak definitions too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/user_syms.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 56d3f87..8da6ab3 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -34,6 +34,11 @@ EXPORT_SYMBOL(strstr);
        int sym(void);                  \
        EXPORT_SYMBOL(sym);
 
+extern void readdir64(void) __attribute__((weak));
+EXPORT_SYMBOL(readdir64);
+extern void truncate64(void) __attribute__((weak));
+EXPORT_SYMBOL(truncate64);
+
 #ifdef SUBARCH_i386
 EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

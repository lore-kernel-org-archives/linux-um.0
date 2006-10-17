Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZwT3-0001z5-FM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:21 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZwT2-0002Gr-Td
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:21 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 23:27:15 +0200
Message-Id: <20061017212715.26445.87166.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 06/10] uml: reenable compilation of enable_timer, 
	disabled by mistake
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

CONFIG_MODE_TT does not work there, the UML_ prefixed version must be used -
this causes a link-time failure when CONFIG_MODE_TT is enabled (i.e. always
here, never by Jeff).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/time.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 38be096..2115b8b 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -16,6 +16,7 @@ #include "user.h"
 #include "process.h"
 #include "kern_constants.h"
 #include "os.h"
+#include "uml-config.h"
 
 int set_interval(int is_virtual)
 {
@@ -30,7 +31,7 @@ int set_interval(int is_virtual)
 	return 0;
 }
 
-#ifdef CONFIG_MODE_TT
+#ifdef UML_CONFIG_MODE_TT
 void enable_timer(void)
 {
 	set_interval(1);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

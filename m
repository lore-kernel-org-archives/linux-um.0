Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZwTD-0001zX-70 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:31 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZwTA-0002IF-Lk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:31 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 23:27:23 +0200
Message-Id: <20061017212723.26445.57342.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 10/10] uml: mmapper - remove just added but
	wrong "const" attribute
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

When enabling the mmapper driver I got warnings because this "const" miscdevice
structure is passed to function as non-const pointer; unlike struct
tty_operations, however, I verified that misc_{de,}register _do_ modify their
parameter, so this const attribute must be removed.

Since the purpose of the change was to guarantee that no lock was needed, add a
comment to prove this differently.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/mmapper_kern.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
index 9a3b5da..df3516e 100644
--- a/arch/um/drivers/mmapper_kern.c
+++ b/arch/um/drivers/mmapper_kern.c
@@ -95,7 +95,8 @@ static const struct file_operations mmap
 	.release	= mmapper_release,
 };
 
-static const struct miscdevice mmapper_dev = {
+/* No locking needed - only used (and modified) by below initcall and exitcall. */
+static struct miscdevice mmapper_dev = {
 	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "mmapper",
 	.fops		= &mmapper_fops
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

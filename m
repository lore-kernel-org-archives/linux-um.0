Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GoRAP-00055p-4W for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:04:01 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user54890)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GoRAO-0001Y9-De
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:04:01 -0800
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id
	kAQL3wL7002109 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Nov 2006 21:03:58 GMT
From: Nix <nix@esperi.org.uk>
Date: Sun, 26 Nov 2006 21:03:58 +0000
Message-ID: <87slg59ayp.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] PATCH [03/03]: MMAP_OFFSET needs "asm/page.h" for
	PAGE_SHIFT.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Another bug revealed by `make headers_install'ed header files.

Signed-off-by: Nick Alcock <nix@esperi.org.uk>

 arch/um/include/sysdep-i386/stub.h   |    1 +
 arch/um/include/sysdep-x86_64/stub.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/sysdep-i386/stub.h b/arch/um/include/sysdep-i386/stub.h
index b492b12..4fffae7 100644
--- a/arch/um/include/sysdep-i386/stub.h
+++ b/arch/um/include/sysdep-i386/stub.h
@@ -9,6 +9,7 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
+#include <asm/page.h>
 #include "stub-data.h"
 #include "kern_constants.h"
 #include "uml-config.h"
diff --git a/arch/um/include/sysdep-x86_64/stub.h b/arch/um/include/sysdep-x86_64/stub.h
index 92e989f..464a6c3 100644
--- a/arch/um/include/sysdep-x86_64/stub.h
+++ b/arch/um/include/sysdep-x86_64/stub.h
@@ -8,6 +8,7 @@
 
 #include <sys/mman.h>
 #include <asm/unistd.h>
+#include <asm/page.h>
 #include <sysdep/ptrace_user.h>
 #include "stub-data.h"
 #include "kern_constants.h"

-- 
`The main high-level difference between Emacs and (say) UNIX, Windows,
 or BeOS... is that Emacs boots quicker.' --- PdS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

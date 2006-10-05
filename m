Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVayh-0006Vz-Ps for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:03 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVaye-0000H5-7L
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:03 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 05 Oct 2006 23:38:55 +0200
Message-Id: <20061005213855.17268.40985.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 07/14] uml: fix processor selection to exclude
	unsupported processors and features
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

Makes UML compile on any possible processor choice. The two problems were:

*) x86 code, when 386 is selected, checks at runtime boot_cpuflags, which we do
   not have.
*) 3Dnow support for memcpy() et al. does not compile currently and fixing this
   is not trivial, so simply disable it; with this change, if one selects MK7
   UML compiles (while it did not).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/i386/Kconfig.cpu |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/i386/Kconfig.cpu b/arch/i386/Kconfig.cpu
index 21c9a4e..fc4f2ab 100644
--- a/arch/i386/Kconfig.cpu
+++ b/arch/i386/Kconfig.cpu
@@ -7,6 +7,7 @@ choice
 
 config M386
 	bool "386"
+	depends on !UML
 	---help---
 	  This is the processor type of your CPU. This information is used for
 	  optimizing purposes. In order to compile a kernel that can run on
@@ -301,7 +302,7 @@ config X86_USE_PPRO_CHECKSUM
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7 || MGEODE_LX
+	depends on (MCYRIXIII || MK7 || MGEODE_LX) && !UML
 	default y
 
 config X86_OOSTORE
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iv7lx-0001Cv-Sn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 00:50:58 -0800
Received: from ug-out-1314.google.com ([66.249.92.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iv7lv-0001dC-NF
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 00:50:57 -0800
Received: by ug-out-1314.google.com with SMTP id m2so288725uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Nov 2007 00:50:53 -0800 (PST)
Message-ID: <474542EA.9080608@gmail.com>
Date: Thu, 22 Nov 2007 09:50:50 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] UML : adding X86_32 config to UML's Kconfig
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, jdike@karaya.com
Cc: user-mode-linux-user@lists.sourceforge.net

Hi,

I noticed UM config is not working properly for CPU selection. 
I bisected following commit as a source:

commit 1032c0ba9da5c5b53173ad2dcf8b2a2da78f8b17
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Tue Nov 6 21:35:08 2007 +0100

    x86: arch/x86/Kconfig.cpu unification
    
    Move all CPU definitions to Kconfig.cpu
    Always define X86_MINIMUM_CPU_FAMILY and do the
    obvious code cleanup in boot/cpucheck.c
    
    Comments from: Adrian Bunk <bunk@kernel.org> incorporated.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    Cc: Adrian Bunk <bunk@kernel.org>
    Cc: Brian Gerst <bgerst@didntduck.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: "H. Peter Anvin" <hpa@zytor.com>


snip


diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 0e2adad..c301622 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -3,11 +3,12 @@ if !X86_ELAN
 
 choice
        prompt "Processor family"
-       default M686
+       default M686 if X86_32
+       default GENERIC_CPU if X86_64


snip


I'm not sure if this is the right way but following patch is working for me.

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
---
 arch/um/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index dd1689b..3dcc17c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -68,6 +68,10 @@ config IRQ_RELEASE_METHOD
 	bool
 	default y
 
+config X86_32
+	bool
+	def_bool !64BIT
+
 menu "UML-specific options"
 
 config STATIC_LINK

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

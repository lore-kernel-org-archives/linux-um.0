Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Aug 2011 19:59:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1Qu7oF-0007P3-3s@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Subject: [PATCH 02/91] um: fix build breakage in mm/slub.c
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


we have no equivalent of cpufeature machinery, so...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/Kconfig.cpu |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index e3ca7e0..94fed18 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -313,7 +313,7 @@ config CMPXCHG_LOCAL
 	def_bool X86_64 || (X86_32 && !M386)
 
 config CMPXCHG_DOUBLE
-	def_bool y
+	def_bool !UML
 
 config X86_L1_CACHE_SHIFT
 	int
-- 
1.7.2.5



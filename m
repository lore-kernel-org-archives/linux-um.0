Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sasha.levin@oracle.com>
Date: Thu, 20 Dec 2012 14:11:35 -0500
Message-Id: <1356030701-16284-27-git-send-email-sasha.levin@oracle.com>
In-Reply-To: <1356030701-16284-1-git-send-email-sasha.levin@oracle.com>
References: <1356030701-16284-1-git-send-email-sasha.levin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: don't compare a pointer to 0
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Sasha Levin <sasha.levin@oracle.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/x86/um/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/fault.c b/arch/x86/um/fault.c
index 8784ab3..84ac7f7 100644
--- a/arch/x86/um/fault.c
+++ b/arch/x86/um/fault.c
@@ -20,7 +20,7 @@ int arch_fixup(unsigned long address, struct uml_pt_regs *regs)
 	const struct exception_table_entry *fixup;
 
 	fixup = search_exception_tables(address);
-	if (fixup != 0) {
+	if (fixup) {
 		UPT_IP(regs) = fixup->fixup;
 		return 1;
 	}
-- 
1.8.0


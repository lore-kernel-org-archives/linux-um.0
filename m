Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Aug 2011 20:11:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1Qu7zh-00080N-Tb@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Subject: [PATCH 73/91] um: asm/apic.h is there only to shadow the x86 one...
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


... so take it to arch/um/x86/asm.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/{um/include => x86/um}/asm/apic.h |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/{um/include => x86/um}/asm/apic.h (100%)

diff --git a/arch/um/include/asm/apic.h b/arch/x86/um/asm/apic.h
similarity index 100%
rename from arch/um/include/asm/apic.h
rename to arch/x86/um/asm/apic.h
-- 
1.7.2.5



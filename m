Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mathias Krause <minipli@googlemail.com>
Date: Fri, 10 Jun 2011 15:10:57 +0200
Message-Id: <1307711457-17613-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTiknCeAxe30MJdVTxDom+ko8+EDQ4A@mail.gmail.com> <1307642718-22257-1-git-send-email-minipli@googlemail.com> <20110609155630.0f734351.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um, exec: remove redundant set_fs(USER_DS)
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The address limit is already set in flush_old_exec() so this
set_fs(USER_DS) is redundant.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/exec.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 09bd7b5..939a4a6 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -38,7 +38,6 @@ void flush_thread(void)
 
 void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
 {
-	set_fs(USER_DS);
 	PT_REGS_IP(regs) = eip;
 	PT_REGS_SP(regs) = esp;
 }
-- 
1.5.6.5


Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 1/5] uml: Remove unused variable from line driver
Date: Mon, 19 Apr 2010 23:53:04 +0200
Message-Id: <f430193946dbd11791e8fb5bef2e4a8e68393828.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
---
 arch/um/drivers/line.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 7a656bd..7f7338c 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -19,7 +19,6 @@ static irqreturn_t line_interrupt(int irq, void *data)
 {
 	struct chan *chan = data;
 	struct line *line = chan->line;
-	struct tty_struct *tty;
 
 	if (line)
 		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
-- 
1.6.0.2


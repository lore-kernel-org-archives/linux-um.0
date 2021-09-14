Return-Path: <linux-serial-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/16] tty: arch/, stop using tty_flip_buffer_push
Date: Tue, 14 Sep 2021 11:14:11 +0200
Message-Id: <20210914091415.17918-5-jslaby@suse.cz>
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the former, so call the latter directly in arch/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-parisc@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
---
 arch/parisc/kernel/pdc_cons.c       | 2 +-
 arch/um/drivers/chan_kern.c         | 2 +-
 arch/xtensa/platforms/iss/console.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
index 2661cdd256ae..221af0ab3382 100644
--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -128,7 +128,7 @@ static void pdc_console_poll(struct timer_list *unused)
 	}
 
 	if (count)
-		tty_flip_buffer_push(&tty_port);
+		tty_schedule_flip(&tty_port);
 
 	if (pdc_cons.flags & CON_ENABLED)
 		mod_timer(&pdc_console_timer, jiffies + PDC_CONS_POLL_DELAY);
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 62997055c454..62164db99f99 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -566,5 +566,5 @@ void chan_interrupt(struct line *line, int irq)
 			return;
 	}
  out:
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 81d7c7e8f7e9..8d8580d1ef56 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -84,7 +84,7 @@ static void rs_poll(struct timer_list *unused)
 	}
 
 	if (i)
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 	if (rd)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
 	spin_unlock(&timer_lock);
-- 
2.33.0



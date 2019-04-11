Return-Path: <brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
Date: Thu, 11 Apr 2019 11:49:44 +0200
Message-Id: <20190411094944.12245-5-brgl@bgdev.pl>
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-ID: <linux-um.lists.infradead.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Setting a chip for an interrupt marks it as allocated. Since UM doesn't
support dynamic interrupt numbers (yet), it means we cannot simply
increase NR_IRQS and then use the free irqs between LAST_IRQ and NR_IRQS
with gpio-mockup or iio testing drivers as irq_alloc_descs() will fail
after not being able to neither find an unallocated range of interrupts
nor expand the range.

Only call irq_set_chip_and_handler() for irqs until LAST_IRQ.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index f4874b7ec503..598d7b3d9355 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -479,7 +479,7 @@ void __init init_IRQ(void)
 	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
 
 
-	for (i = 1; i < NR_IRQS; i++)
+	for (i = 1; i < LAST_IRQ; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
 	/* Initialize EPOLL Loop */
 	os_setup_epoll();
-- 
2.21.0



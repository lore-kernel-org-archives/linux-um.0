Return-Path: <brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 1/4] um: remove unused variable
Date: Thu, 11 Apr 2019 11:49:41 +0200
Message-Id: <20190411094944.12245-2-brgl@bgdev.pl>
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-ID: <linux-um.lists.infradead.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The buf variable is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/skas/uaccess.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 7f06fdbc7ee1..bd3cb694322c 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -59,7 +59,6 @@ static pte_t *maybe_map(unsigned long virt, int is_write)
 static int do_op_one_page(unsigned long addr, int len, int is_write,
 		 int (*op)(unsigned long addr, int len, void *arg), void *arg)
 {
-	jmp_buf buf;
 	struct page *page;
 	pte_t *pte;
 	int n;
-- 
2.21.0



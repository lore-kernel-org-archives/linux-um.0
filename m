Return-Path: <brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 0/4] um: build and irq fixes
Date: Wed,  3 Apr 2019 10:38:58 +0200
Message-Id: <20190403083902.3975-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-ID: <linux-um.lists.infradead.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I've previously sent these patches separately. I still don't see them
in next and I don't know what the policy is for picking up uml patches
but I thought I'd resend them rebased together on top of v5.1-rc3.

Bartosz Golaszewski (4):
  um: remove unused variable
  um: remove uses of variable length arrays
  um: define set_pte_at() as a static inline function, not a macro
  um: irq: don't set the chip for all irqs

 arch/um/include/asm/pgtable.h |  7 ++++++-
 arch/um/kernel/irq.c          |  2 +-
 arch/um/kernel/skas/uaccess.c |  1 -
 arch/um/os-Linux/umid.c       | 36 ++++++++++++++++++++++++++---------
 4 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.21.0



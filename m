Return-Path: <linux-kernel-owner@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] UM: Fine-tuning for some function implementations
Message-ID: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:55:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jeff Dike <jdike@addtoit.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:48:02 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  port: Move an assignment for the variable "fd" in port_wait()
  port: Delete three error messages for a failed memory allocation
  port: Improve size determinations in port_data()
  ubd: Move two assignments for the variable "err" in ubd_remove()
  ubd: Improve size determinations in do_ubd_request()

 arch/um/drivers/port_kern.c | 23 ++++++++---------------
 arch/um/drivers/ubd_kern.c  | 18 +++++++++---------
 2 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.11.0



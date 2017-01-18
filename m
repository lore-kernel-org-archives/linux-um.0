Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 3/5] um: port: Improve size determinations in port_data()
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <ad89ddc2-217f-b58b-0fdc-3a592c0970fa@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:58:30 +0100
MIME-Version: 1.0
In-Reply-To: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jeff Dike <jdike@addtoit.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:20:14 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/port_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index c96741e920f5..60c1b43a8381 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -166,7 +166,7 @@ void *port_data(int port_num)
 		if (port->port == port_num)
 			goto found;
 	}
-	port = kmalloc(sizeof(struct port_list), GFP_KERNEL);
+	port = kmalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
 		goto out;
 
@@ -196,7 +196,7 @@ void *port_data(int port_num)
 	list_add(&port->list, &ports);
 
  found:
-	dev = kmalloc(sizeof(struct port_dev), GFP_KERNEL);
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		goto out;
 
-- 
2.11.0



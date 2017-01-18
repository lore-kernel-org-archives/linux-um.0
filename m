Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/5] um: port: Delete three error messages for a failed memory
 allocation
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <651ecf90-9c68-aec1-58d7-d11e7671ed4c@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:57:30 +0100
MIME-Version: 1.0
In-Reply-To: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jeff Dike <jdike@addtoit.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:00:14 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: Possible unnecessary 'out of memory' message

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/port_kern.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index b2bbda21c5f3..c96741e920f5 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -87,11 +87,8 @@ static int port_accept(struct port_list *port)
 	}
 
 	conn = kmalloc(sizeof(*conn), GFP_ATOMIC);
-	if (conn == NULL) {
-		printk(KERN_ERR "port_accept : failed to allocate "
-		       "connection\n");
+	if (!conn)
 		goto out_close;
-	}
 	*conn = ((struct connection)
 		{ .list 	= LIST_HEAD_INIT(conn->list),
 		  .fd 		= fd,
@@ -170,10 +167,8 @@ void *port_data(int port_num)
 			goto found;
 	}
 	port = kmalloc(sizeof(struct port_list), GFP_KERNEL);
-	if (port == NULL) {
-		printk(KERN_ERR "Allocation of port list failed\n");
+	if (!port)
 		goto out;
-	}
 
 	fd = port_listen_fd(port_num);
 	if (fd < 0) {
@@ -202,10 +197,8 @@ void *port_data(int port_num)
 
  found:
 	dev = kmalloc(sizeof(struct port_dev), GFP_KERNEL);
-	if (dev == NULL) {
-		printk(KERN_ERR "Allocation of port device entry failed\n");
+	if (!dev)
 		goto out;
-	}
 
 	*dev = ((struct port_dev) { .port  		= port,
 				    .helper_pid  	= -1,
-- 
2.11.0



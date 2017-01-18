Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/5] um: port: Move an assignment for the variable "fd" in
 port_wait()
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <4940ae24-c7ae-66ce-4c2a-5283607a5549@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:56:17 +0100
MIME-Version: 1.0
In-Reply-To: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jeff Dike <jdike@addtoit.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 21:40:29 +0100

A local variable was set to an error code in one case before a concrete
error situation was detected. Thus move the corresponding assignment into
an if branch to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/port_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index 40ca5cc275e9..b2bbda21c5f3 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -230,10 +230,10 @@ int port_wait(void *data)
 
 	atomic_inc(&port->wait_count);
 	while (1) {
-		fd = -ERESTARTSYS;
-		if (wait_for_completion_interruptible(&port->done))
+		if (wait_for_completion_interruptible(&port->done)) {
+			fd = -ERESTARTSYS;
 			goto out;
-
+		}
 		spin_lock(&port->lock);
 
 		conn = list_entry(port->connections.next, struct connection,
-- 
2.11.0



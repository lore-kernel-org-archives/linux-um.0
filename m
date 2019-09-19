Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAtRm-00067K-N2
 for linux-um@lists.infradead.org; Thu, 19 Sep 2019 10:14:00 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: virtio: keep reading on -EAGAIN
Date: Thu, 19 Sep 2019 12:13:48 +0200
Message-Id: <1568888028-I2734f0a83b4b28ea237050d5def17b4529b8b446@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

When we get an interrupt from the socket getting readable,
and start reading, there's a possibility for a race. This
depends on the implementation of the device, but e.g. with
qemu's libvhost-user, we can see:

 device                 virtio_uml
---------------------------------------
  write header
                         get interrupt
                         read header
                         read body -> returns -EAGAIN
  write body

The -EAGAIN return is because the socket is non-blocking,
and then this leads us to abandon this message.

In fact, we've already read the header, so when the get
another signal/interrupt for the body, we again read it
as though it's a new message header, and also abandon it
for the same reason (wrong size etc.)

This essentially breaks things, and if that message was
one that required a response, it leads to a deadlock as
the device is waiting for the response but we'll never
reply.

Fix this by spinning on -EAGAIN as well.

Note that this situation is highly unlikely to occur in
normal usage, since there will be very few messages and
only in the startup phase. With the inband call feature
this does tend to happen (eventually) though.

Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 12f3b0bf14b7..66b5a936f289 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -112,7 +112,7 @@ static int full_read(int fd, void *buf, int len)
 			buf += rc;
 			len -= rc;
 		}
-	} while (len && (rc > 0 || rc == -EINTR));
+	} while (len && (rc > 0 || rc == -EINTR || rc == -EAGAIN));
 
 	if (rc < 0)
 		return rc;
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


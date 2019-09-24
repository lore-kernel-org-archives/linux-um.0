Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCf8g-00012S-2f
 for linux-um@lists.infradead.org; Tue, 24 Sep 2019 07:21:36 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] um: virtio: keep reading on -EAGAIN
Date: Tue, 24 Sep 2019 09:21:17 +0200
Message-Id: <1569309677-I2734f0a83b4b28ea237050d5def17b4529b8b446@changeid>
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

Fix this by spinning on -EAGAIN as well when we read the
message body. We need to handle -EAGAIN as "no message"
while reading the header, since we share an interrupt.

Note that this situation is highly unlikely to occur in
normal usage, since there will be very few messages and
only in the startup phase. With the inband call feature
this does tend to happen (eventually) though.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 * spin on -EAGAIN only on the body, not the header,
   otherwise we deadlock with shared interrupts
---
 arch/um/drivers/virtio_uml.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index a2d9b3347945..31ffb27be172 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -87,7 +87,7 @@ static int full_sendmsg_fds(int fd, const void *buf, unsigned int len,
 	return 0;
 }
 
-static int full_read(int fd, void *buf, int len)
+static int full_read(int fd, void *buf, int len, bool abortable)
 {
 	int rc;
 
@@ -97,7 +97,7 @@ static int full_read(int fd, void *buf, int len)
 			buf += rc;
 			len -= rc;
 		}
-	} while (len && (rc > 0 || rc == -EINTR));
+	} while (len && (rc > 0 || rc == -EINTR || (!abortable && rc == -EAGAIN)));
 
 	if (rc < 0)
 		return rc;
@@ -108,7 +108,7 @@ static int full_read(int fd, void *buf, int len)
 
 static int vhost_user_recv_header(int fd, struct vhost_user_msg *msg)
 {
-	return full_read(fd, msg, sizeof(msg->header));
+	return full_read(fd, msg, sizeof(msg->header), true);
 }
 
 static int vhost_user_recv(int fd, struct vhost_user_msg *msg,
@@ -122,7 +122,7 @@ static int vhost_user_recv(int fd, struct vhost_user_msg *msg,
 	size = msg->header.size;
 	if (size > max_payload_size)
 		return -EPROTO;
-	return full_read(fd, &msg->payload, size);
+	return full_read(fd, &msg->payload, size, false);
 }
 
 static int vhost_user_recv_resp(struct virtio_uml_device *vu_dev,
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


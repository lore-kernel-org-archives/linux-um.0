Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp70T-0005VU-Od
 for linux-um@lists.infradead.org; Tue, 15 Dec 2020 09:52:34 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 2/5] um: virtio: fix handling of messages without payload
Date: Tue, 15 Dec 2020 10:52:22 +0100
Message-Id: <20201215105225.8815d03733c5.I4a7f2dd58cc3e4f134cd8494539cde940c18c75c@changeid>
In-Reply-To: <20201215105225.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
References: <20201215105225.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
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

If we have a message without payload, we call full_read() with
len set to 0, which causes it to return -ECONNRESET. Catch this
case and explicitly return 0 for it so we can actually use the
zero-size config-changed message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ead9a1aea192..030bef37d6d4 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -97,6 +97,9 @@ static int full_read(int fd, void *buf, int len, bool abortable)
 {
 	int rc;
 
+	if (!len)
+		return 0;
+
 	do {
 		rc = os_read_file(fd, buf, len);
 		if (rc > 0) {
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


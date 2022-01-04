Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4hK2-00BBjJ-1K
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 10:45:43 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Document dtb command line option
Date: Tue,  4 Jan 2022 10:44:57 +0000
Message-Id: <20220104104457.282828-1-anton.ivanov@cambridgegreys.com>
In-Reply-To: <1118129237.194759.1640202076897.JavaMail.zimbra@nod.at>
References: <1118129237.194759.1640202076897.JavaMail.zimbra@nod.at>
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
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@axis.com, robh+dt@kernel.org, jdike@addtoit.com, johannes@sipsolutions.net, vincent.whitchurch@axis.com, richard@nod.at, linux-doc@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Add documentation for the dtb command line option and the
ability to load/parse device trees.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 .../virt/uml/user_mode_linux_howto_v2.rst     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 2cafd3c3c6cb..81986fe014d4 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -1189,6 +1189,26 @@ E.g. ``os_close_file()`` is just a wrapper around ``close()``
 which ensures that the userspace function close does not clash
 with similarly named function(s) in the kernel part.
 
+Using UML as a Test Platform
+============================
+
+UML is an excellent test platform for device driver development. As
+with most things UML, "some user assembly may be required". It is
+up to the user to build their emulation environment. UML at present
+provides only the kernel infrastructure.
+
+Part of this infrastructure is the ability to load and parse fdt
+device tree blobs as used in Arm or Open Firmware platforms. These
+are supplied as an optional extra argument to the kernel command
+line::
+
+    dtb=filename
+
+The device tree is loaded and parsed at boottime and is accessible by
+drivers which query it. At this moment in time this facility is
+intended solely for development purposes. UML's own devices do not
+query the device tree.
+
 Security Considerations
 -----------------------
 
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


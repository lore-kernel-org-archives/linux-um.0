Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j3Rad-00066k-Dt
 for linux-um@lists.infradead.org; Sun, 16 Feb 2020 21:36:36 +0000
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH] um: vector: Avoid NULL ptr deference if transport is unset
Date: Sun, 16 Feb 2020 22:36:24 +0100
Message-Id: <20200216213624.800463-1-sjoerd.simons@collabora.co.uk>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

When the transport option of a vec isn't set strncmp ends up being
called on a NULL pointer. Better not do that.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/um/drivers/vector_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 0ff86391f77d..ca90666c0b61 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -198,6 +198,9 @@ static int get_transport_options(struct arglist *def)
 	long parsed;
 	int result = 0;
 
+	if (transport == NULL)
+		return -EINVAL;
+
 	if (vector != NULL) {
 		if (kstrtoul(vector, 10, &parsed) == 0) {
 			if (parsed == 0) {
-- 
2.25.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


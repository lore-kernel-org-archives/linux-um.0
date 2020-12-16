Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpVHk-0006iF-P7
 for linux-um@lists.infradead.org; Wed, 16 Dec 2020 11:48:01 +0000
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] um: fix spelling mistake in Kconfig "privleges" ->
 "privileges"
Date: Wed, 16 Dec 2020 11:47:55 +0000
Message-Id: <20201216114755.12461-1-colin.king@canonical.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brendan Higgins <brendanhiggins@google.com>, linux-um@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/um/drivers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2e7b8e0e7194..58e3ffc17b7d 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -323,7 +323,7 @@ config UML_NET_SLIRP
 	  frames.  In general, slirp allows the UML the same IP connectivity
 	  to the outside world that the host user is permitted, and unlike
 	  other transports, SLiRP works without the need of root level
-	  privleges, setuid binaries, or SLIP devices on the host.  This
+	  privileges, setuid binaries, or SLIP devices on the host.  This
 	  also means not every type of connection is possible, but most
 	  situations can be accommodated with carefully crafted slirp
 	  commands that can be passed along as part of the network device's
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


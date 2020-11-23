Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khHkx-00063M-AU
 for linux-um@lists.infradead.org; Mon, 23 Nov 2020 19:44:12 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: sigio: return error from add_sigio_fd()
Date: Mon, 23 Nov 2020 20:44:02 +0100
Message-Id: <20201123204402.cd59c660941a.I05dae9d28604fcfeb7cbddd602b33b418b624fe5@changeid>
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

If we run out of space, return an error instead of 0.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/sigio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 75558080d0bf..f91fd16e9911 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -167,15 +167,17 @@ static void update_thread(void)
 int add_sigio_fd(int fd)
 {
 	struct pollfd *p;
-	int err = 0, i, n;
+	int err, i, n;
 
 	sigio_lock();
 	for (i = 0; i < all_sigio_fds.used; i++) {
 		if (all_sigio_fds.poll[i].fd == fd)
 			break;
 	}
-	if (i == all_sigio_fds.used)
+	if (i == all_sigio_fds.used) {
+		err = -ENOSPC;
 		goto out;
+	}
 
 	p = &all_sigio_fds.poll[i];
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


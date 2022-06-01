Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from edge05.meizu.com ([157.122.146.251] helo=mail.meizu.com)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwJ3o-00ESdP-Cu
	for linux-um@lists.infradead.org; Wed, 01 Jun 2022 07:46:34 +0000
From: Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] um: remove unused variable
Date: Wed, 1 Jun 2022 15:46:05 +0800
Message-ID: <1654069565-6968-1-git-send-email-baihaowen@meizu.com>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: Haowen Bai <baihaowen@meizu.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

The variable dead is initialized but never used otherwise.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/um/os-Linux/umid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index a3dd61521d24..7a1abb829930 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -136,7 +136,7 @@ static int remove_files_and_dir(char *dir)
 static inline int is_umdir_used(char *dir)
 {
 	char pid[sizeof("nnnnnnnnn")], *end, *file;
-	int dead, fd, p, n, err;
+	int fd, p, n, err;
 	size_t filelen = strlen(dir) + sizeof("/pid") + 1;
 
 	file = malloc(filelen);
@@ -145,7 +145,6 @@ static inline int is_umdir_used(char *dir)
 
 	snprintf(file, filelen, "%s/pid", dir);
 
-	dead = 0;
 	fd = open(file, O_RDONLY);
 	if (fd < 0) {
 		fd = -errno;
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


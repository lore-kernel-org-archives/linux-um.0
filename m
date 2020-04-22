Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRHnF-0005zM-W8
 for linux-um@lists.infradead.org; Wed, 22 Apr 2020 16:00:11 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: use fdatasync() when mapping the UBD FSYNC command
Date: Wed, 22 Apr 2020 17:00:01 +0100
Message-Id: <20200422160001.13200-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

We do not need to update the metadata (atime, mtime, etc)
on the UBD file and/or the COW file until UML exits.

UBD image mtime is checked in UML only when opening
the files. After that they are locked and used
exclusively by a single UML instance, so there is
no point wasting resources on updating metadata on
every sync. We can sync data only. The host will
always update mtime if a file has been modified upon
closing it.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/os-Linux/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index fbda10535dab..538c7765323b 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -286,7 +286,7 @@ int os_write_file(int fd, const void *buf, int len)
 
 int os_sync_file(int fd)
 {
-	int n = fsync(fd);
+	int n = fdatasync(fd);
 
 	if (n < 0)
 		return -errno;
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOgUV-0004c2-I4
 for linux-um@lists.infradead.org; Wed, 15 Apr 2020 11:46:05 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 67/84] um: falloc.h needs to be directly included
 for older libc
Date: Wed, 15 Apr 2020 07:44:24 -0400
Message-Id: <20200415114442.14166-67-sashal@kernel.org>
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org, Brendan Higgins <brendanhiggins@google.com>, Richard Weinberger <richard@nod.at>, Alan Maguire <alan.maguire@oracle.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 35f3401317a3b26aa01fde8facfd320f2628fdcc ]

When building UML with glibc 2.17 installed, compilation
of arch/um/os-Linux/file.c fails due to failure to find
FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE definitions.

It appears that /usr/include/bits/fcntl-linux.h (indirectly
included by /usr/include/fcntl.h) does not include falloc.h
with an older glibc, whereas a more up-to-date version
does.

Adding the direct include to file.c resolves the issue
and does not cause problems for more recent glibc.

Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 5133e3afb96f7..3996937e2c0dd 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
+#include <linux/falloc.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/socket.h>
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


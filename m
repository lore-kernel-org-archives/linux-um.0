Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lilium.sigma-star.at ([109.75.188.150])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gIKVF-00037h-0l
 for linux-um@lists.infradead.org; Thu, 01 Nov 2018 21:27:47 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Update maintainers file entry
Date: Thu,  1 Nov 2018 22:27:01 +0100
Message-Id: <20181101212701.31828-1-richard@nod.at>
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
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org

- Remove stale fs/hppfs/ reference
- Point to our patchwork queue

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b91bbec94f98..3779bbab1715 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15672,13 +15672,13 @@ M:	Jeff Dike <jdike@addtoit.com>
 M:	Richard Weinberger <richard@nod.at>
 L:	linux-um@lists.infradead.org
 W:	http://user-mode-linux.sourceforge.net
+Q:	https://patchwork.ozlabs.org/project/linux-um/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 S:	Maintained
 F:	Documentation/virtual/uml/
 F:	arch/um/
 F:	arch/x86/um/
 F:	fs/hostfs/
-F:	fs/hppfs/
 
 USERSPACE COPYIN/COPYOUT (UIOVEC)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
-- 
2.19.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPh9j-000gmH-10
 for linux-um@lists.infradead.org; Mon, 13 Sep 2021 08:17:36 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: gitignore: add kernel/capflags.c
Date: Mon, 13 Sep 2021 10:17:29 +0200
Message-Id: <20210913101728.73cbc025c093.Ic498b3ba9b0af569c18f88e5c1084ab182c722e0@changeid>
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
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This file is generated, we should ignore it.

Fixes: d8fb32f4790f ("um: Add support for host CPU flags and alignment")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/.gitignore b/arch/um/.gitignore
index 6323e5571887..d69ea5b562ce 100644
--- a/arch/um/.gitignore
+++ b/arch/um/.gitignore
@@ -2,3 +2,4 @@
 kernel/config.c
 kernel/config.tmp
 kernel/vmlinux.lds
+kernel/capflags.c
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


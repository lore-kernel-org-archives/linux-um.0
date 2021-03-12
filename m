Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKeW5-00B5Tn-RN
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 09:55:44 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/6] .gitignore: also ignore gcda files
Date: Fri, 12 Mar 2021 10:55:23 +0100
Message-Id: <20210312104627.77a4bc149381.I4f7b3002fa9ef4a168fca1f7952a277b52cae695@changeid>
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
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
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

We already ignore gcno files that are created by the compiler
at build time for -ftest-coverage. However, with ARCH=um it's
possible to select CONFIG_GCOV which actually has the kernel
binary write out gcda files (rather than have them in debugfs
like CONFIG_GCOV_KERNEL does), so an in-tree build can create
them. Ignore them so the tree doesn't look dirty for that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3af66272d6f1..91e46190d418 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@
 *.dwo
 *.elf
 *.gcno
+*.gcda
 *.gz
 *.i
 *.ko
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


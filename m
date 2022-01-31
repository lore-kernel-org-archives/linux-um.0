Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEXmI-009bpQ-0n
 for linux-um@lists.infradead.org; Mon, 31 Jan 2022 14:35:35 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] uml: net: vector: fix const issue
Date: Mon, 31 Jan 2022 15:35:27 +0100
Message-Id: <20220131153527.3a3b22daa521.I68e88e5d49d37c0005e4fd5ef6a3c43be5876b91@changeid>
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

Since the constification of MAC addresses, the argument
to uml_vector_default_bpf() must be const.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/vector_user.c | 2 +-
 arch/um/drivers/vector_user.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index e4ffeb9a1fa4..c650e428432b 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -771,7 +771,7 @@ int uml_vector_detach_bpf(int fd, void *bpf)
 		printk(KERN_ERR BPF_DETACH_FAIL, prog->len, prog->filter, fd, -errno);
 	return err;
 }
-void *uml_vector_default_bpf(void *mac)
+void *uml_vector_default_bpf(const void *mac)
 {
 	struct sock_filter *bpf;
 	uint32_t *mac1 = (uint32_t *)(mac + 2);
diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index d29d5fdd98fa..3a73d17a0161 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -97,7 +97,7 @@ extern int uml_vector_recvmmsg(
 	unsigned int vlen,
 	unsigned int flags
 );
-extern void *uml_vector_default_bpf(void *mac);
+extern void *uml_vector_default_bpf(const void *mac);
 extern void *uml_vector_user_bpf(char *filename);
 extern int uml_vector_attach_bpf(int fd, void *bpf);
 extern int uml_vector_detach_bpf(int fd, void *bpf);
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


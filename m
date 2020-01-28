Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwSmH-0000bk-4v
 for linux-um@lists.infradead.org; Tue, 28 Jan 2020 15:27:46 +0000
Date: Tue, 28 Jan 2020 18:27:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3] um: Fix some error handling in uml_vector_user_bpf()
Message-ID: <20200128151000.kx2bwayuuxpuqn6t@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Jeff Dike <jdike@addtoit.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, kernel-janitors@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Alex Dewar <alex.dewar@gmx.co.uk>, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>

1) The uml_vector_user_bpf() returns pointers so it should return NULL
   instead of false.
2) If the "bpf_prog" allocation failed, it would have eventually lead to
   a crash.  We can't succeed after the error happens so it should just
   return.

Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v3: Fix screwed up subject.  Sorry.  Not my most shining hour.
v2: The first version broke the build.  Shame upon me.

 arch/um/drivers/vector_user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index ddcd917be0af..1403cbadf92b 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -732,13 +732,14 @@ void *uml_vector_user_bpf(char *filename)
 
 	if (stat(filename, &statbuf) < 0) {
 		printk(KERN_ERR "Error %d reading bpf file", -errno);
-		return false;
+		return NULL;
 	}
 	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
-	if (bpf_prog != NULL) {
-		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
-		bpf_prog->filter = NULL;
-	}
+	if (bpf_prog == NULL)
+		return NULL;
+	bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
+	bpf_prog->filter = NULL;
+
 	ffd = os_open_file(filename, of_read(OPENFLAGS()), 0);
 	if (ffd < 0) {
 		printk(KERN_ERR "Error %d opening bpf file", -errno);
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jireE-0006HR-C7
 for linux-um@lists.infradead.org; Wed, 10 Jun 2020 03:43:31 +0000
Received: by mail-qv1-xf42.google.com with SMTP id p15so426331qvr.9
 for <linux-um@lists.infradead.org>; Tue, 09 Jun 2020 20:43:26 -0700 (PDT)
From: Gaurav Singh <gaurav1086@gmail.com>
Subject: [PATCH] Fix null pointer dereference in vector_user_bpf
Date: Tue,  9 Jun 2020 23:43:00 -0400
Message-Id: <20200610034314.9290-1-gaurav1086@gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: gaurav1086@gmail.com, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Alex Dewar <alex.dewar@gmx.co.uk>, "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "open list:BPF Safe dynamic programs and tools" <netdev@vger.kernel.org>, "open list:BPF Safe dynamic programs and tools" <bpf@vger.kernel.org>

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>

The bpf_prog is being checked for !NULL after uml_kmalloc but
later its used directly for example: 
bpf_prog->filter = bpf and is also later returned upon success.
Fix this, do a NULL check and return right away.

---
 arch/um/drivers/vector_user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index aa28e9eecb7b..71d043ae306f 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -730,10 +730,12 @@ void *uml_vector_user_bpf(char *filename)
 		return false;
 	}
 	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
-	if (bpf_prog != NULL) {
-		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
-		bpf_prog->filter = NULL;
+	if (bpf_prog == NULL) {
+		printk(KERN_ERR "Failed to allocate bpf prog buffer");
+		return NULL;
 	}
+	bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
+	bpf_prog->filter = NULL;
 	ffd = os_open_file(filename, of_read(OPENFLAGS()), 0);
 	if (ffd < 0) {
 		printk(KERN_ERR "Error %d opening bpf file", -errno);
-- 
2.17.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


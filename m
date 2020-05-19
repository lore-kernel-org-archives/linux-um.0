Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/20] maccess: remove probe_read_common and probe_write_common
Date: Tue, 19 May 2020 15:44:38 +0200
Message-Id: <20200519134449.1466624-10-hch@lst.de>
In-Reply-To: <20200519134449.1466624-1-hch@lst.de>
References: <20200519134449.1466624-1-hch@lst.de>
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
To: x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, netdev@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org

Each of the helpers has just two callers, which also different in
dealing with kernel or userspace pointers.  Just open code the logic
in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/maccess.c | 63 ++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index e783ebfccd542..31cf6604e7fff 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -6,30 +6,6 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 
-static __always_inline long
-probe_read_common(void *dst, const void __user *src, size_t size)
-{
-	long ret;
-
-	pagefault_disable();
-	ret = __copy_from_user_inatomic(dst, src, size);
-	pagefault_enable();
-
-	return ret ? -EFAULT : 0;
-}
-
-static __always_inline long
-probe_write_common(void __user *dst, const void *src, size_t size)
-{
-	long ret;
-
-	pagefault_disable();
-	ret = __copy_to_user_inatomic(dst, src, size);
-	pagefault_enable();
-
-	return ret ? -EFAULT : 0;
-}
-
 /**
  * probe_kernel_read(): safely attempt to read from any location
  * @dst: pointer to the buffer that shall take the data
@@ -69,10 +45,15 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(KERNEL_DS);
-	ret = probe_read_common(dst, (__force const void __user *)src, size);
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, (__force const void __user *)src,
+			size);
+	pagefault_enable();
 	set_fs(old_fs);
 
-	return ret;
+	if (ret)
+		return -EFAULT;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(probe_kernel_read);
 
@@ -91,11 +72,16 @@ long probe_user_read(void *dst, const void __user *src, size_t size)
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(USER_DS);
-	if (access_ok(src, size))
-		ret = probe_read_common(dst, src, size);
+	if (access_ok(src, size)) {
+		pagefault_disable();
+		ret = __copy_from_user_inatomic(dst, src, size);
+		pagefault_enable();
+	}
 	set_fs(old_fs);
 
-	return ret;
+	if (ret)
+		return -EFAULT;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(probe_user_read);
 
@@ -114,10 +100,14 @@ long probe_kernel_write(void *dst, const void *src, size_t size)
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(KERNEL_DS);
-	ret = probe_write_common((__force void __user *)dst, src, size);
+	pagefault_disable();
+	ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);
+	pagefault_enable();
 	set_fs(old_fs);
 
-	return ret;
+	if (ret)
+		return -EFAULT;
+	return 0;
 }
 
 /**
@@ -135,11 +125,16 @@ long probe_user_write(void __user *dst, const void *src, size_t size)
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(USER_DS);
-	if (access_ok(dst, size))
-		ret = probe_write_common(dst, src, size);
+	if (access_ok(dst, size)) {
+		pagefault_disable();
+		ret = __copy_to_user_inatomic(dst, src, size);
+		pagefault_enable();
+	}
 	set_fs(old_fs);
 
-	return ret;
+	if (ret)
+		return -EFAULT;
+	return 0;
 }
 
 /**
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


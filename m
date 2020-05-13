Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/18] maccess: move user access routines together
Date: Wed, 13 May 2020 18:00:33 +0200
Message-Id: <20200513160038.2482415-14-hch@lst.de>
In-Reply-To: <20200513160038.2482415-1-hch@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
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

Move kernel access vs user access routines together to ease upcoming
ifdefs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/maccess.c | 110 +++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 05c44d490b4e3..9773e2253b495 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -47,34 +47,6 @@ long probe_kernel_read(void *dst, const void *src, size_t size)
 }
 EXPORT_SYMBOL_GPL(probe_kernel_read);
 
-/**
- * probe_user_read(): safely attempt to read from a user-space location
- * @dst: pointer to the buffer that shall take the data
- * @src: address to read from. This must be a user address.
- * @size: size of the data chunk
- *
- * Safely read from user address @src to the buffer at @dst. If a kernel fault
- * happens, handle that and return -EFAULT.
- */
-long probe_user_read(void *dst, const void __user *src, size_t size)
-{
-	long ret = -EFAULT;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(USER_DS);
-	if (access_ok(src, size)) {
-		pagefault_disable();
-		ret = __copy_from_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
-	set_fs(old_fs);
-
-	if (ret)
-		return -EFAULT;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(probe_user_read);
-
 /**
  * probe_kernel_write(): safely attempt to write to a location
  * @dst: address to write to
@@ -100,33 +72,6 @@ long probe_kernel_write(void *dst, const void *src, size_t size)
 	return 0;
 }
 
-/**
- * probe_user_write(): safely attempt to write to a user-space location
- * @dst: address to write to
- * @src: pointer to the data that shall be written
- * @size: size of the data chunk
- *
- * Safely write to address @dst from the buffer at @src.  If a kernel fault
- * happens, handle that and return -EFAULT.
- */
-long probe_user_write(void __user *dst, const void *src, size_t size)
-{
-	long ret = -EFAULT;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(USER_DS);
-	if (access_ok(dst, size)) {
-		pagefault_disable();
-		ret = __copy_to_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
-	set_fs(old_fs);
-
-	if (ret)
-		return -EFAULT;
-	return 0;
-}
-
 /**
  * strncpy_from_kernel_nofault: - Copy a NUL terminated string from unsafe
  *				 address.
@@ -170,6 +115,61 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 	return ret ? -EFAULT : src - unsafe_addr;
 }
 
+/**
+ * probe_user_read(): safely attempt to read from a user-space location
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from. This must be a user address.
+ * @size: size of the data chunk
+ *
+ * Safely read from user address @src to the buffer at @dst. If a kernel fault
+ * happens, handle that and return -EFAULT.
+ */
+long probe_user_read(void *dst, const void __user *src, size_t size)
+{
+	long ret = -EFAULT;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(USER_DS);
+	if (access_ok(src, size)) {
+		pagefault_disable();
+		ret = __copy_from_user_inatomic(dst, src, size);
+		pagefault_enable();
+	}
+	set_fs(old_fs);
+
+	if (ret)
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(probe_user_read);
+
+/**
+ * probe_user_write(): safely attempt to write to a user-space location
+ * @dst: address to write to
+ * @src: pointer to the data that shall be written
+ * @size: size of the data chunk
+ *
+ * Safely write to address @dst from the buffer at @src.  If a kernel fault
+ * happens, handle that and return -EFAULT.
+ */
+long probe_user_write(void __user *dst, const void *src, size_t size)
+{
+	long ret = -EFAULT;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(USER_DS);
+	if (access_ok(dst, size)) {
+		pagefault_disable();
+		ret = __copy_to_user_inatomic(dst, src, size);
+		pagefault_enable();
+	}
+	set_fs(old_fs);
+
+	if (ret)
+		return -EFAULT;
+	return 0;
+}
+
 /**
  * strncpy_from_user_nofault: - Copy a NUL terminated string from unsafe user
  *				address.
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/20] maccess: remove strncpy_from_unsafe
Date: Tue, 19 May 2020 15:44:41 +0200
Message-Id: <20200519134449.1466624-13-hch@lst.de>
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

All three callers really should try the explicit kernel or user copies.
Switch them to try a user copy if the address is smaller than TASK_SIZE
and the architecture has non-overlapping address ranges, or a kernel copy
otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uaccess.h     |  1 -
 kernel/trace/bpf_trace.c    | 23 +++++++++++++++-------
 kernel/trace/trace_kprobe.c |  8 +++++++-
 mm/maccess.c                | 39 +------------------------------------
 4 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 7cfc10eb09c60..28944a14e0534 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -311,7 +311,6 @@ extern long probe_user_read(void *dst, const void __user *src, size_t size);
 extern long notrace probe_kernel_write(void *dst, const void *src, size_t size);
 extern long notrace probe_user_write(void __user *dst, const void *src, size_t size);
 
-extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr,
 		long count);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9d4080590f711..bab9b8a175cb0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -226,12 +226,14 @@ static __always_inline int
 bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr,
 				 const bool compat)
 {
+	const void __user *user_ptr = (__force const void __user *)unsafe_ptr;
 	int ret = security_locked_down(LOCKDOWN_BPF_READ);
 
 	if (unlikely(ret < 0))
-		goto out;
+		goto fail;
+
 	/*
-	 * The strncpy_from_unsafe_*() call will likely not fill the entire
+	 * The strncpy_from_*_nofault() calls will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
 	 * arbitrary memory anyway similar to bpf_probe_read_*() and might
 	 * as well probe the stack. Thus, memory is explicitly cleared
@@ -239,11 +241,17 @@ bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr,
 	 * code altogether don't copy garbage; otherwise length of string
 	 * is returned that can be used for bpf_perf_event_output() et al.
 	 */
-	ret = compat ? strncpy_from_unsafe(dst, unsafe_ptr, size) :
-	      strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
+	if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
+	    compat && (unsigned long)unsafe_ptr < TASK_SIZE)
+		ret = strncpy_from_user_nofault(dst, user_ptr, size);
+	else
+		ret = strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
-out:
-		memset(dst, 0, size);
+		goto fail;
+
+	return 0;
+fail:
+	memset(dst, 0, size);
 	return ret;
 }
 
@@ -331,7 +339,8 @@ static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 	switch (fmt_ptype) {
 	case 's':
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-		strncpy_from_unsafe(buf, unsafe_ptr, bufsz);
+		if (strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz) == 0)
+			strncpy_from_user_nofault(buf, user_ptr, bufsz);
 		break;
 #endif
 	case 'k':
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4325f9e7fadaa..2f6737cc53e6c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1244,7 +1244,13 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * Try to get string again, since the string can be changed while
 	 * probing.
 	 */
-	ret = strncpy_from_unsafe(__dest, (void *)addr, maxlen);
+	if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
+	    addr < TASK_SIZE) {
+		ret = strncpy_from_user_nofault(__dest, (void __user *)addr,
+				maxlen);
+	} else {
+		ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
+	}
 	if (ret >= 0)
 		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
diff --git a/mm/maccess.c b/mm/maccess.c
index 483a933b7d241..3d85e48013e6b 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -8,8 +8,6 @@
 
 static long __probe_kernel_read(void *dst, const void *src, size_t size,
 		bool strict);
-static long __strncpy_from_unsafe(char *dst, const void *unsafe_addr,
-		long count, bool strict);
 
 bool __weak probe_kernel_read_allowed(void *dst, const void *unsafe_src,
 		size_t size, bool strict)
@@ -156,35 +154,6 @@ long probe_user_write(void __user *dst, const void *src, size_t size)
 	return 0;
 }
 
-/**
- * strncpy_from_unsafe: - Copy a NUL terminated string from unsafe address.
- * @dst:   Destination address, in kernel space.  This buffer must be at
- *         least @count bytes long.
- * @unsafe_addr: Unsafe address.
- * @count: Maximum number of bytes to copy, including the trailing NUL.
- *
- * Copies a NUL-terminated string from unsafe address to kernel buffer.
- *
- * On success, returns the length of the string INCLUDING the trailing NUL.
- *
- * If access fails, returns -EFAULT (some data may have been copied
- * and the trailing NUL added).
- *
- * If @count is smaller than the length of the string, copies @count-1 bytes,
- * sets the last byte of @dst buffer to NUL and returns @count.
- *
- * Same as strncpy_from_kernel_nofault() except that for architectures with
- * not fully separated user and kernel address spaces this function also works
- * for user address tanges.
- *
- * DO NOT USE THIS FUNCTION - it is broken on architectures with entirely
- * separate kernel and user address spaces, and also a bad idea otherwise.
- */
-long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
-{
-	return __strncpy_from_unsafe(dst, unsafe_addr, count, false);
-}
-
 /**
  * strncpy_from_kernel_nofault: - Copy a NUL terminated string from unsafe
  *				 address.
@@ -204,12 +173,6 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
  * sets the last byte of @dst buffer to NUL and returns @count.
  */
 long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
-{
-	return __strncpy_from_unsafe(dst, unsafe_addr, count, true);
-}
-
-static long __strncpy_from_unsafe(char *dst, const void *unsafe_addr,
-		long count, bool strict)
 {
 	mm_segment_t old_fs = get_fs();
 	const void *src = unsafe_addr;
@@ -217,7 +180,7 @@ static long __strncpy_from_unsafe(char *dst, const void *unsafe_addr,
 
 	if (unlikely(count <= 0))
 		return 0;
-	if (!probe_kernel_read_allowed(dst, unsafe_addr, count, strict))
+	if (!probe_kernel_read_allowed(dst, unsafe_addr, count, true))
 		return -EFAULT;
 
 	set_fs(KERNEL_DS);
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


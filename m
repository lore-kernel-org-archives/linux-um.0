Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/20] maccess: always use strict semantics for
 probe_kernel_read
Date: Tue, 19 May 2020 15:44:42 +0200
Message-Id: <20200519134449.1466624-14-hch@lst.de>
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

Except for historical confusion in the kprobes/uprobes and bpf tracers,
there is no good reason to ever allow user memory accesses from
probe_kernel_read.  Switch probe_kernel_read to only read from kernel
memory itself, and try to read user memory in the tracers only if
the address is smaller than TASK_SIZE, and the architecture has
non-overlapping address ranges.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/lib/memcpy.c    |  3 +--
 arch/um/kernel/maccess.c    |  3 +--
 arch/x86/mm/maccess.c       |  5 +----
 include/linux/uaccess.h     |  4 +---
 kernel/trace/bpf_trace.c    | 18 ++++++++++++-----
 kernel/trace/trace_kprobe.c | 14 ++++++++++++-
 mm/maccess.c                | 39 ++++++-------------------------------
 7 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 5ef648bd33119..9fe662b3b5604 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -57,8 +57,7 @@ void * memcpy(void * dst,const void *src, size_t count)
 EXPORT_SYMBOL(raw_copy_in_user);
 EXPORT_SYMBOL(memcpy);
 
-bool probe_kernel_read_allowed(void *dst, const void *unsafe_src, size_t size,
-		bool strict)
+bool probe_kernel_read_allowed(void *dst, const void *unsafe_src, size_t size)
 {
 	if ((unsigned long)unsafe_src < PAGE_SIZE)
 		return false;
diff --git a/arch/um/kernel/maccess.c b/arch/um/kernel/maccess.c
index 90a1bec923158..734f3d7e57c0f 100644
--- a/arch/um/kernel/maccess.c
+++ b/arch/um/kernel/maccess.c
@@ -7,8 +7,7 @@
 #include <linux/kernel.h>
 #include <os.h>
 
-bool probe_kernel_read_allowed(void *dst, const void *src, size_t size,
-		bool strict)
+bool probe_kernel_read_allowed(void *dst, const void *src, size_t size)
 {
 	void *psrc = (void *)rounddown((unsigned long)src, PAGE_SIZE);
 
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 5c323ab187b27..a1bd81677aa72 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -26,10 +26,7 @@ static __always_inline bool invalid_probe_range(u64 vaddr)
 }
 #endif
 
-bool probe_kernel_read_allowed(void *dst, const void *unsafe_src, size_t size,
-		bool strict)
+bool probe_kernel_read_allowed(void *dst, const void *unsafe_src, size_t size)
 {
-	if (!strict)
-		return true;
 	return !invalid_probe_range((unsigned long)unsafe_src);
 }
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 28944a14e0534..78e0ff8641559 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -301,11 +301,9 @@ copy_struct_from_user(void *dst, size_t ksize, const void __user *src,
 	return 0;
 }
 
-bool probe_kernel_read_allowed(void *dst, const void *unsafe_src,
-		size_t size, bool strict);
+bool probe_kernel_read_allowed(void *dst, const void *unsafe_src, size_t size);
 
 extern long probe_kernel_read(void *dst, const void *src, size_t size);
-extern long probe_kernel_read_strict(void *dst, const void *src, size_t size);
 extern long probe_user_read(void *dst, const void __user *src, size_t size);
 
 extern long notrace probe_kernel_write(void *dst, const void *src, size_t size);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bab9b8a175cb0..c6007d9a987d5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -180,15 +180,23 @@ static __always_inline int
 bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr,
 			     const bool compat)
 {
+	const void __user *user_ptr = (__force const void __user *)unsafe_ptr;
 	int ret = security_locked_down(LOCKDOWN_BPF_READ);
 
 	if (unlikely(ret < 0))
-		goto out;
-	ret = compat ? probe_kernel_read(dst, unsafe_ptr, size) :
-	      probe_kernel_read_strict(dst, unsafe_ptr, size);
+		goto fail;
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
+	    compat && (unsigned long)unsafe_ptr < TASK_SIZE)
+		ret = probe_user_read(dst, user_ptr, size);
+	else
+		ret = probe_kernel_read(dst, unsafe_ptr, size);
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
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 2f6737cc53e6c..82da20e712507 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1208,7 +1208,13 @@ fetch_store_strlen(unsigned long addr)
 	u8 c;
 
 	do {
-		ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
+		if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
+		    (unsigned long)addr < TASK_SIZE) {
+			ret = probe_user_read(&c,
+				(__force u8 __user *)addr + len, 1);
+		} else {
+			ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
+		}
 		len++;
 	} while (c && ret == 0 && len < MAX_STRING_SIZE);
 
@@ -1284,6 +1290,12 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 static nokprobe_inline int
 probe_mem_read(void *dest, void *src, size_t size)
 {
+	if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
+	    (unsigned long)src < TASK_SIZE) {
+		return probe_user_read(dest, (__force const void __user *)src,
+				size);
+	}
+
 	return probe_kernel_read(dest, src, size);
 }
 
diff --git a/mm/maccess.c b/mm/maccess.c
index 3d85e48013e6b..05c44d490b4e3 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -6,36 +6,14 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 
-static long __probe_kernel_read(void *dst, const void *src, size_t size,
-		bool strict);
-
 bool __weak probe_kernel_read_allowed(void *dst, const void *unsafe_src,
-		size_t size, bool strict)
+		size_t size)
 {
 	return true;
 }
 
 /**
- * probe_kernel_read(): safely attempt to read from any location
- * @dst: pointer to the buffer that shall take the data
- * @src: address to read from
- * @size: size of the data chunk
- *
- * Same as probe_kernel_read_strict() except that for architectures with
- * not fully separated user and kernel address spaces this function also works
- * for user address tanges.
- *
- * DO NOT USE THIS FUNCTION - it is broken on architectures with entirely
- * separate kernel and user address spaces, and also a bad idea otherwise.
- */
-long probe_kernel_read(void *dst, const void *src, size_t size)
-{
-	return __probe_kernel_read(dst, src, size, false);
-}
-EXPORT_SYMBOL_GPL(probe_kernel_read);
-
-/**
- * probe_kernel_read_strict(): safely attempt to read from kernel-space
+ * probe_kernel_read(): safely attempt to read from kernel-space
  * @dst: pointer to the buffer that shall take the data
  * @src: address to read from
  * @size: size of the data chunk
@@ -48,18 +26,12 @@ EXPORT_SYMBOL_GPL(probe_kernel_read);
  * probe_kernel_read() suitable for use within regions where the caller
  * already holds mmap_sem, or other locks which nest inside mmap_sem.
  */
-long probe_kernel_read_strict(void *dst, const void *src, size_t size)
-{
-	return __probe_kernel_read(dst, src, size, true);
-}
-
-static long __probe_kernel_read(void *dst, const void *src, size_t size,
-		bool strict)
+long probe_kernel_read(void *dst, const void *src, size_t size)
 {
 	long ret;
 	mm_segment_t old_fs = get_fs();
 
-	if (!probe_kernel_read_allowed(dst, src, size, strict))
+	if (!probe_kernel_read_allowed(dst, src, size))
 		return -EFAULT;
 
 	set_fs(KERNEL_DS);
@@ -73,6 +45,7 @@ static long __probe_kernel_read(void *dst, const void *src, size_t size,
 		return -EFAULT;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(probe_kernel_read);
 
 /**
  * probe_user_read(): safely attempt to read from a user-space location
@@ -180,7 +153,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 
 	if (unlikely(count <= 0))
 		return 0;
-	if (!probe_kernel_read_allowed(dst, unsafe_addr, count, true))
+	if (!probe_kernel_read_allowed(dst, unsafe_addr, count))
 		return -EFAULT;
 
 	set_fs(KERNEL_DS);
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/23] maccess: rename strnlen_unsafe_user to
 strnlen_user_nofault
Date: Thu, 21 May 2020 17:22:46 +0200
Message-Id: <20200521152301.2587579-9-hch@lst.de>
In-Reply-To: <20200521152301.2587579-1-hch@lst.de>
References: <20200521152301.2587579-1-hch@lst.de>
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

This matches the naming of strnlen_user, and also makes it more clear
what the function is supposed to do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uaccess.h     | 2 +-
 kernel/trace/trace_kprobe.c | 2 +-
 mm/maccess.c                | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 134ff9c1c151b..d8366f8468664 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -315,7 +315,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr,
 extern long __strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 		long count);
-extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
+long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 
 /**
  * probe_kernel_address(): safely attempt to read from a location
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d600f41fda1ca..4325f9e7fadaa 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1221,7 +1221,7 @@ fetch_store_strlen_user(unsigned long addr)
 {
 	const void __user *uaddr =  (__force const void __user *)addr;
 
-	return strnlen_unsafe_user(uaddr, MAX_STRING_SIZE);
+	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
 }
 
 /*
diff --git a/mm/maccess.c b/mm/maccess.c
index c8748c2809096..e783ebfccd542 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -258,7 +258,7 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 }
 
 /**
- * strnlen_unsafe_user: - Get the size of a user string INCLUDING final NUL.
+ * strnlen_user_nofault: - Get the size of a user string INCLUDING final NUL.
  * @unsafe_addr: The string to measure.
  * @count: Maximum count (including NUL)
  *
@@ -273,7 +273,7 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
  * Unlike strnlen_user, this can be used from IRQ handler etc. because
  * it disables pagefaults.
  */
-long strnlen_unsafe_user(const void __user *unsafe_addr, long count)
+long strnlen_user_nofault(const void __user *unsafe_addr, long count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


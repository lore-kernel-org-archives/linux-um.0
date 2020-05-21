Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/23] maccess: remove various unused weak aliases
Date: Thu, 21 May 2020 17:22:40 +0200
Message-Id: <20200521152301.2587579-3-hch@lst.de>
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

maccess tends to define lots of underscore prefixed symbols that then
have other weak aliases.  But except for two cases they are never
actually used, so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uaccess.h |  3 ---
 mm/maccess.c            | 19 +++----------------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad5..a2c606a403745 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -324,7 +324,6 @@ extern long __probe_kernel_read(void *dst, const void *src, size_t size);
  * happens, handle that and return -EFAULT.
  */
 extern long probe_user_read(void *dst, const void __user *src, size_t size);
-extern long __probe_user_read(void *dst, const void __user *src, size_t size);
 
 /*
  * probe_kernel_write(): safely attempt to write to a location
@@ -336,7 +335,6 @@ extern long __probe_user_read(void *dst, const void __user *src, size_t size);
  * happens, handle that and return -EFAULT.
  */
 extern long notrace probe_kernel_write(void *dst, const void *src, size_t size);
-extern long notrace __probe_kernel_write(void *dst, const void *src, size_t size);
 
 /*
  * probe_user_write(): safely attempt to write to a location in user space
@@ -348,7 +346,6 @@ extern long notrace __probe_kernel_write(void *dst, const void *src, size_t size
  * happens, handle that and return -EFAULT.
  */
 extern long notrace probe_user_write(void __user *dst, const void *src, size_t size);
-extern long notrace __probe_user_write(void __user *dst, const void *src, size_t size);
 
 extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 extern long strncpy_from_unsafe_strict(char *dst, const void *unsafe_addr,
diff --git a/mm/maccess.c b/mm/maccess.c
index cf21e604f78cb..4e7f3b6eb05ae 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -79,11 +79,7 @@ EXPORT_SYMBOL_GPL(probe_kernel_read);
  * Safely read from user address @src to the buffer at @dst. If a kernel fault
  * happens, handle that and return -EFAULT.
  */
-
-long __weak probe_user_read(void *dst, const void __user *src, size_t size)
-    __attribute__((alias("__probe_user_read")));
-
-long __probe_user_read(void *dst, const void __user *src, size_t size)
+long probe_user_read(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
 	mm_segment_t old_fs = get_fs();
@@ -106,11 +102,7 @@ EXPORT_SYMBOL_GPL(probe_user_read);
  * Safely write to address @dst from the buffer at @src.  If a kernel fault
  * happens, handle that and return -EFAULT.
  */
-
-long __weak probe_kernel_write(void *dst, const void *src, size_t size)
-    __attribute__((alias("__probe_kernel_write")));
-
-long __probe_kernel_write(void *dst, const void *src, size_t size)
+long probe_kernel_write(void *dst, const void *src, size_t size)
 {
 	long ret;
 	mm_segment_t old_fs = get_fs();
@@ -131,11 +123,7 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
  * Safely write to address @dst from the buffer at @src.  If a kernel fault
  * happens, handle that and return -EFAULT.
  */
-
-long __weak probe_user_write(void __user *dst, const void *src, size_t size)
-    __attribute__((alias("__probe_user_write")));
-
-long __probe_user_write(void __user *dst, const void *src, size_t size)
+long probe_user_write(void __user *dst, const void *src, size_t size)
 {
 	long ret = -EFAULT;
 	mm_segment_t old_fs = get_fs();
@@ -171,7 +159,6 @@ long __probe_user_write(void __user *dst, const void *src, size_t size)
  * probing memory on a user address range where strncpy_from_unsafe_user() is
  * supposed to be used instead.
  */
-
 long __weak strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
     __attribute__((alias("__strncpy_from_unsafe")));
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


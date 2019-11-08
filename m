Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTBuy-0000yY-6M
 for linux-um@lists.infradead.org; Fri, 08 Nov 2019 21:35:46 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/16] um: ubd: use 64-bit time_t where possible
Date: Fri,  8 Nov 2019 22:32:44 +0100
Message-Id: <20191108213257.3097633-7-arnd@arndb.de>
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
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
To: y2038@lists.linaro.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Johannes Berg <johannes.berg@intel.com>, Erel Geron <erelx.geron@intel.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Walter <dwalter@google.com>, Alex Dewar <alex.dewar@gmx.co.uk>

The ubd code suffers from a possible y2038 overflow on 32-bit
architectures, both for the cow header and the os_file_modtime()
function.

Replace time_t with time64_t to extend the ubd_kern side as much
as possible.

Whether this makes a difference for the user side depends on
the host libc implementation that may use either 32-bit or 64-bit
time_t.

For the cow file format, the header contains an unsigned 32-bit
timestamp, which is good until y2106, passing this through a
'long long' gives us a consistent interpretation between 32-bit
and 64-bit um kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/cow.h       |  2 +-
 arch/um/drivers/cow_user.c  |  7 ++++---
 arch/um/drivers/ubd_kern.c  | 10 +++++-----
 arch/um/include/shared/os.h |  2 +-
 arch/um/os-Linux/file.c     |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
index 760c507dd5b6..103adac691ed 100644
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -11,7 +11,7 @@ extern int init_cow_file(int fd, char *cow_file, char *backing_file,
 extern int file_reader(__u64 offset, char *buf, int len, void *arg);
 extern int read_cow_header(int (*reader)(__u64, char *, int, void *),
 			   void *arg, __u32 *version_out,
-			   char **backing_file_out, time_t *mtime_out,
+			   char **backing_file_out, long long *mtime_out,
 			   unsigned long long *size_out, int *sectorsize_out,
 			   __u32 *align_out, int *bitmap_offset_out);
 
diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 74b0c2686c95..29b46581ddd1 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -17,6 +17,7 @@
 
 #define PATH_LEN_V1 256
 
+/* unsigned time_t works until year 2106 */
 typedef __u32 time32_t;
 
 struct cow_header_v1 {
@@ -197,7 +198,7 @@ int write_cow_header(char *cow_file, int fd, char *backing_file,
 		     int sectorsize, int alignment, unsigned long long *size)
 {
 	struct cow_header_v3 *header;
-	unsigned long modtime;
+	long long modtime;
 	int err;
 
 	err = cow_seek_file(fd, 0);
@@ -276,7 +277,7 @@ int file_reader(__u64 offset, char *buf, int len, void *arg)
 
 int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		    __u32 *version_out, char **backing_file_out,
-		    time_t *mtime_out, unsigned long long *size_out,
+		    long long *mtime_out, unsigned long long *size_out,
 		    int *sectorsize_out, __u32 *align_out,
 		    int *bitmap_offset_out)
 {
@@ -363,7 +364,7 @@ int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 
 		/*
 		 * this was used until Dec2005 - 64bits are needed to represent
-		 * 2038+. I.e. we can safely do this truncating cast.
+		 * 2106+. I.e. we can safely do this truncating cast.
 		 *
 		 * Additionally, we must use be32toh() instead of be64toh(), since
 		 * the program used to use the former (tested - I got mtime
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6627d7c30f37..dcabb463e011 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -561,7 +561,7 @@ static inline int ubd_file_size(struct ubd *ubd_dev, __u64 *size_out)
 	__u32 version;
 	__u32 align;
 	char *backing_file;
-	time_t mtime;
+	time64_t mtime;
 	unsigned long long size;
 	int sector_size;
 	int bitmap_offset;
@@ -600,9 +600,9 @@ static int read_cow_bitmap(int fd, void *buf, int offset, int len)
 	return 0;
 }
 
-static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
+static int backing_file_mismatch(char *file, __u64 size, time64_t mtime)
 {
-	unsigned long modtime;
+	time64_t modtime;
 	unsigned long long actual;
 	int err;
 
@@ -628,7 +628,7 @@ static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
 		return -EINVAL;
 	}
 	if (modtime != mtime) {
-		printk(KERN_ERR "mtime mismatch (%ld vs %ld) of COW header vs "
+		printk(KERN_ERR "mtime mismatch (%lld vs %lld) of COW header vs "
 		       "backing file\n", mtime, modtime);
 		return -EINVAL;
 	}
@@ -671,7 +671,7 @@ static int open_ubd_file(char *file, struct openflags *openflags, int shared,
 		  unsigned long *bitmap_len_out, int *data_offset_out,
 		  int *create_cow_out)
 {
-	time_t mtime;
+	time64_t mtime;
 	unsigned long long size;
 	__u32 version, align;
 	char *backing_file;
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 506bcd1bca68..0f30204b6afa 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -150,7 +150,7 @@ extern int os_sync_file(int fd);
 extern int os_file_size(const char *file, unsigned long long *size_out);
 extern int os_pread_file(int fd, void *buf, int len, unsigned long long offset);
 extern int os_pwrite_file(int fd, const void *buf, int count, unsigned long long offset);
-extern int os_file_modtime(const char *file, unsigned long *modtime);
+extern int os_file_modtime(const char *file, long long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
 extern int os_set_fd_async(int fd);
 extern int os_clear_fd_async(int fd);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 5133e3afb96f..fbda10535dab 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -341,7 +341,7 @@ int os_file_size(const char *file, unsigned long long *size_out)
 	return 0;
 }
 
-int os_file_modtime(const char *file, unsigned long *modtime)
+int os_file_modtime(const char *file, long long *modtime)
 {
 	struct uml_stat buf;
 	int err;
-- 
2.20.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


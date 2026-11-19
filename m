Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6AD606A32C
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Et0cEtuO;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=S0DDD7EI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J+fuPAaCPIz2jCJJfpHkkIxr6Py7BB/AeNt8uoidLiU=; b=Et0cEtuO2/oWKz
	/9TIBaClBz+YaZnjA+9CvVWaJ82JI1/nGt9VrI0XuhgU7IwNUNQzgsNKqjdVzbT36bXzB+evW8iyH
	hjv/piDNVKF2LFGgxxjMuAmGOl/oO18ltb2MZdUBoJYzc1m8dythBnYAnCjUnTb7cIiyx7X9uEuLq
	R7C2Gh1b5sZqnPMeEiIk8Qhm1fnGPy3f0xOyu8Tn5ZPEFkmhv0q4wZjVqyeBkChrJWVbpVEcoHfYa
	aD7WIw7JdcMUfNB2e8uR64wkTgx8mTZCf14gIzI1pz1AtjS24YKfjJxByFNwPUg3oDd9TQJoFwvxx
	TIKGNoL3HCTOXjW7h2uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29X-0000000C1ne-3I02;
	Thu, 19 Nov 2026 13:26:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29N-0000000C1dS-0T3r
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J+fuPAaCPIz2jCJJfpHkkIxr6Py7BB/AeNt8uoidLiU=;
	t=1795094764; x=1796304364; b=S0DDD7EIKxP1tAitoVi+ilLWO5s2uqhv1tWQME8KS/swiYN
	7TTpwL6MkPIJ6jpudwGGsgkYD9VA3aRNqRBecbh0oXd2Nrm0RcGVBdZKkbtnJWMcQUQ/aZg+pnQzJ
	bUk6Bs5nNdnsWVq541ZdA68xBA4JDRENUEQQbzXpLSS+RUXC3T2vHuZD0EZId63wPuLMGoz94gGLO
	dzOILPJgWJuLE83zyzbMJbPPprL+NeCnuYQvMft7uQaduQB50Olo4Pa4ooTbaq4dnxfLZgq1HhfN3
	sQbN76XXE06R1y9ouk83Jol7NkPxlorXcxAD0BVijNNT1U3WmSaXAUhWJYPtzH0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU29J-00000004LQj-18P5;
	Thu, 19 Nov 2026 14:26:01 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 3/5] hostfs: catch EINTR and partial read/write
Date: Thu, 19 Nov 2026 14:24:40 +0100
Message-ID: <20261119142555.4a0aefc61198.I62ffb2d55b483e9160222455583959aa144ddfa3@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132555.228479-7-johannes@sipsolutions.net>
References: <20261119132555.228479-7-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052606_019945_947F740C 
X-CRM114-Status: GOOD (  20.95  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Benjamin Berg <benjamin.berg@intel.com>

The UM kernel uses signals for various purposes (SIGALRM for scheduling
for example). These signals are interrupts for the UM kernel, which
should not affect file system operations from userspace processes.

Said differently, in hostfs all operations are directly forwarded to the
host and will block the entire UM kernel. As such, hostfs does not
permit other tasks to be scheduled while operations are ongoing and
these operations are fundamentally synchronous and not interruptible.

With all this, the only reasonable thing to do is to catch all EINTR
situations and retry them. This includes retrying short read/write
operations in order to ensure they finish.

If, at any point, hostfs becomes able able to push operations into the
background in order to schedule another task, then an abortion mechanism
may be needed.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/os.h |   7 ++-
 fs/hostfs/hostfs_user.c     | 113 +++++++++++++++++++++++-------------
 2 files changed, 79 insertions(+), 41 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 0067c5208c4c..4ec4ab8e2cea 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -19,7 +19,12 @@
 #include <sys/types.h>
 #endif
 
-#define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
+#define CATCH_EINTR(expr) ({						\
+		int __result;						\
+		while ((errno = 0, ((__result = (expr)) < 0)) &&	\
+		       (errno == EINTR));				\
+		__result;						\
+	})
 
 #define OS_TYPE_FILE 1
 #define OS_TYPE_DIR 2
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 3bcd9f35e70b..11f2844b7fce 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -17,6 +17,7 @@
 #include <sys/syscall.h>
 #include "hostfs.h"
 #include <utime.h>
+#include <os.h>
 
 static void statx_to_hostfs(const struct statx *buf, struct hostfs_stat *p)
 {
@@ -73,7 +74,7 @@ int access_file(char *path, int r, int w, int x)
 		mode |= W_OK;
 	if (x)
 		mode |= X_OK;
-	if (access(path, mode) != 0)
+	if (CATCH_EINTR(access(path, mode)) != 0)
 		return -errno;
 	else return 0;
 }
@@ -92,7 +93,7 @@ int open_file(char *path, int r, int w, int append)
 
 	if (append)
 		mode |= O_APPEND;
-	fd = open64(path, mode);
+	fd = CATCH_EINTR(open64(path, mode));
 	if (fd < 0)
 		return -errno;
 	else return fd;
@@ -102,7 +103,11 @@ void *open_dir(char *path, int *err_out)
 {
 	DIR *dir;
 
-	dir = opendir(path);
+	do {
+		errno = 0;
+		dir = opendir(path);
+	} while (dir == NULL && errno == EINTR);
+
 	*err_out = errno;
 
 	return dir;
@@ -122,9 +127,14 @@ char *read_dir(void *stream, unsigned long long *pos_out,
 	DIR *dir = stream;
 	struct dirent *ent;
 
-	ent = readdir(dir);
-	if (ent == NULL)
+	do {
+		errno = 0;
+		ent = readdir(dir);
+	} while (!ent && errno == EINTR);
+
+	if (!ent)
 		return NULL;
+
 	*len_out = strlen(ent->d_name);
 	*ino_out = ent->d_ino;
 	*type_out = ent->d_type;
@@ -135,30 +145,52 @@ char *read_dir(void *stream, unsigned long long *pos_out,
 int read_file(int fd, unsigned long long *offset, char *buf, int len)
 {
 	int n;
+	int read = 0;
 
-	n = pread64(fd, buf, len, *offset);
-	if (n < 0)
-		return -errno;
-	*offset += n;
-	return n;
+	do {
+		errno = 0;
+		n = pread64(fd, buf, len, *offset);
+		if (n > 0) {
+			read += n;
+			*offset += n;
+			len -= n;
+			continue;
+		}
+	} while (n < 0 && errno == EINTR);
+
+	if (read > 0)
+		return read;
+
+	return -errno;
 }
 
 int write_file(int fd, unsigned long long *offset, const char *buf, int len)
 {
 	int n;
+	int written = 0;
 
-	n = pwrite64(fd, buf, len, *offset);
-	if (n < 0)
-		return -errno;
-	*offset += n;
-	return n;
+	do {
+		errno = 0;
+		n = pwrite64(fd, buf, len, *offset);
+		if (n > 0) {
+			written += n;
+			*offset += n;
+			len -= n;
+			continue;
+		}
+	} while (n < 0 && errno == EINTR);
+
+	if (written > 0)
+		return written;
+
+	return -errno;
 }
 
 int lseek_file(int fd, long long offset, int whence)
 {
 	int ret;
 
-	ret = lseek64(fd, offset, whence);
+	ret = CATCH_EINTR(lseek64(fd, offset, whence));
 	if (ret < 0)
 		return -errno;
 	return 0;
@@ -168,9 +200,9 @@ int fsync_file(int fd, int datasync)
 {
 	int ret;
 	if (datasync)
-		ret = fdatasync(fd);
+		ret = CATCH_EINTR(fdatasync(fd));
 	else
-		ret = fsync(fd);
+		ret = CATCH_EINTR(fsync(fd));
 
 	if (ret < 0)
 		return -errno;
@@ -179,24 +211,24 @@ int fsync_file(int fd, int datasync)
 
 int replace_file(int oldfd, int fd)
 {
-	return dup2(oldfd, fd);
+	return CATCH_EINTR(dup2(oldfd, fd));
 }
 
 void close_file(void *stream)
 {
-	close(*((int *) stream));
+	CATCH_EINTR(close(*((int *) stream)));
 }
 
 void close_dir(void *stream)
 {
-	closedir(stream);
+	CATCH_EINTR(closedir(stream));
 }
 
 int file_create(char *name, int mode)
 {
 	int fd;
 
-	fd = open64(name, O_CREAT | O_RDWR, mode);
+	fd = CATCH_EINTR(open64(name, O_CREAT | O_RDWR, mode));
 	if (fd < 0)
 		return -errno;
 	return fd;
@@ -210,33 +242,33 @@ int set_attr(const char *file, struct hostfs_iattr *attrs, int fd)
 
 	if (attrs->ia_valid & HOSTFS_ATTR_MODE) {
 		if (fd >= 0) {
-			if (fchmod(fd, attrs->ia_mode) != 0)
+			if (CATCH_EINTR(fchmod(fd, attrs->ia_mode)) != 0)
 				return -errno;
-		} else if (chmod(file, attrs->ia_mode) != 0) {
+		} else if (CATCH_EINTR(chmod(file, attrs->ia_mode)) != 0) {
 			return -errno;
 		}
 	}
 	if (attrs->ia_valid & HOSTFS_ATTR_UID) {
 		if (fd >= 0) {
-			if (fchown(fd, attrs->ia_uid, -1))
+			if (CATCH_EINTR(fchown(fd, attrs->ia_uid, -1)))
 				return -errno;
-		} else if (chown(file, attrs->ia_uid, -1)) {
+		} else if (CATCH_EINTR(chown(file, attrs->ia_uid, -1))) {
 			return -errno;
 		}
 	}
 	if (attrs->ia_valid & HOSTFS_ATTR_GID) {
 		if (fd >= 0) {
-			if (fchown(fd, -1, attrs->ia_gid))
+			if (CATCH_EINTR(fchown(fd, -1, attrs->ia_gid)))
 				return -errno;
-		} else if (chown(file, -1, attrs->ia_gid)) {
+		} else if (CATCH_EINTR(chown(file, -1, attrs->ia_gid))) {
 			return -errno;
 		}
 	}
 	if (attrs->ia_valid & HOSTFS_ATTR_SIZE) {
 		if (fd >= 0) {
-			if (ftruncate(fd, attrs->ia_size))
+			if (CATCH_EINTR(ftruncate(fd, attrs->ia_size)))
 				return -errno;
-		} else if (truncate(file, attrs->ia_size)) {
+		} else if (CATCH_EINTR(truncate(file, attrs->ia_size))) {
 			return -errno;
 		}
 	}
@@ -289,7 +321,7 @@ int make_symlink(const char *from, const char *to)
 {
 	int err;
 
-	err = symlink(to, from);
+	err = CATCH_EINTR(symlink(to, from));
 	if (err)
 		return -errno;
 	return 0;
@@ -299,7 +331,7 @@ int unlink_file(const char *file)
 {
 	int err;
 
-	err = unlink(file);
+	err = CATCH_EINTR(unlink(file));
 	if (err)
 		return -errno;
 	return 0;
@@ -309,7 +341,7 @@ int do_mkdir(const char *file, int mode)
 {
 	int err;
 
-	err = mkdir(file, mode);
+	err = CATCH_EINTR(mkdir(file, mode));
 	if (err)
 		return -errno;
 	return 0;
@@ -319,7 +351,7 @@ int hostfs_do_rmdir(const char *file)
 {
 	int err;
 
-	err = rmdir(file);
+	err = CATCH_EINTR(rmdir(file));
 	if (err)
 		return -errno;
 	return 0;
@@ -329,7 +361,7 @@ int do_mknod(const char *file, int mode, unsigned int major, unsigned int minor)
 {
 	int err;
 
-	err = mknod(file, mode, os_makedev(major, minor));
+	err = CATCH_EINTR(mknod(file, mode, os_makedev(major, minor)));
 	if (err)
 		return -errno;
 	return 0;
@@ -339,7 +371,7 @@ int link_file(const char *to, const char *from)
 {
 	int err;
 
-	err = link(to, from);
+	err = CATCH_EINTR(link(to, from));
 	if (err)
 		return -errno;
 	return 0;
@@ -349,7 +381,7 @@ int hostfs_do_readlink(char *file, char *buf, int size)
 {
 	int n;
 
-	n = readlink(file, buf, size);
+	n = CATCH_EINTR(readlink(file, buf, size));
 	if (n < 0)
 		return -errno;
 	if (n < size)
@@ -361,7 +393,7 @@ int rename_file(char *from, char *to)
 {
 	int err;
 
-	err = rename(from, to);
+	err = CATCH_EINTR(rename(from, to));
 	if (err < 0)
 		return -errno;
 	return 0;
@@ -381,7 +413,8 @@ int rename2_file(char *from, char *to, unsigned int flags)
 #endif
 
 #ifdef SYS_renameat2
-	err = syscall(SYS_renameat2, AT_FDCWD, from, AT_FDCWD, to, flags);
+	err = CATCH_EINTR(syscall(SYS_renameat2, AT_FDCWD, from,
+				  AT_FDCWD, to, flags));
 	if (err < 0) {
 		if (errno != ENOSYS)
 			return -errno;
@@ -402,7 +435,7 @@ int do_statfs(char *root, long *bsize_out, long long *blocks_out,
 	struct statfs64 buf;
 	int err;
 
-	err = statfs64(root, &buf);
+	err = CATCH_EINTR(statfs64(root, &buf));
 	if (err < 0)
 		return -errno;
 
-- 
2.56.1



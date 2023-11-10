Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D696C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4hmdMKCjTAZ8PxaNjKpv7uFID5QVGK6kk/77ReB/Y38=; b=hQBB+ANQasI6R6
	VzEGZoq2K6e55rgM2IVcCDwCcZ2fnPvGiOh2ETPXJk8ubP9Lb8hm9Nk5aykEO62li9Vu1j95V34Xk
	whFaoEDD4JU31Sq3A75ycEWf4gmRchFEXQaNmOh2EvuX5vgMwa3U3YqfQ9HkAnbhaiMlFVEoSsRvw
	mNUG9sjNfsOk1N61AwSvdt/ynbcKr6Aox7HaSVuFJgEiA8pNaFHpdHfDq13Kg+3ofG2GtCNDlkq41
	lheuJnqeaYO7liu41XQ47EgpFkKRGGKguBcbZAgIRdsH1RrJ+VnJR8QGhPdd0t9wq9e16qHIaq3a+
	OpI891VSTVIAIW3hegwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1OyI-008KEl-28;
	Fri, 10 Nov 2023 10:42:42 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1OyE-008KDY-2J
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 10:42:41 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r1Oy6-005eO9-4L; Fri, 10 Nov 2023 10:42:30 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r1Oxx-00Achk-1g;
	Fri, 10 Nov 2023 10:42:29 +0000
Message-ID: <f0c614a6-cf3a-b6e1-6f40-ad6d59460fcf@kot-begemot.co.uk>
Date: Fri, 10 Nov 2023 10:42:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] um: hostfs: catch EINTR and partial read/write
Content-Language: en-US
To: benjamin@sipsolutions.net, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20231110094425.1810667-1-benjamin@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20231110094425.1810667-1-benjamin@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_024238_918750_2A7B9B78 
X-CRM114-Status: GOOD (  28.86  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 10/11/2023 09:44, benjamin@sipsolutions.net wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The UM kernel uses signals for various purposes (SIGALRM for scheduling
> for example). These signals are interrupts for the UM kernel, which
> should not affect file system operations from userspace processes.
> 
> Said differently, in hostfs all operations are directly forwarded to the
> host and will block the entire UM kernel. As such, hostfs does not
> permit other tasks to be scheduled while operations are ongoing and
> these operations are fundamentally synchronous and not interruptible.
> 
> With all this, the only reasonable thing to do is to catch all EINTR
> situations and retry them. This includes retrying short read/write
> operations in order to ensure they finish.
> 
> If, at any point, hostfs becomes able to push operations into the
> background in order to schedule another task, then an abortion mechanism
> may be needed.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>   arch/um/include/shared/os.h |   7 ++-
>   fs/hostfs/hostfs_user.c     | 115 +++++++++++++++++++++++-------------
>   2 files changed, 80 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index 0df646c6651e..7c5564ebc5bb 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -18,7 +18,12 @@
>   #include <sys/types.h>
>   #endif
>   
> -#define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
> +#define CATCH_EINTR(expr) ({						\
> +		int __result;						\
> +		while ((errno = 0, ((__result = (expr)) < 0)) &&	\
> +		       (errno == EINTR));				\
> +		__result;						\
> +	})
>   
>   #define OS_TYPE_FILE 1
>   #define OS_TYPE_DIR 2
> diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
> index 840619e39a1a..dd30bcc6d58f 100644
> --- a/fs/hostfs/hostfs_user.c
> +++ b/fs/hostfs/hostfs_user.c
> @@ -17,6 +17,7 @@
>   #include <sys/syscall.h>
>   #include "hostfs.h"
>   #include <utime.h>
> +#include <os.h>
>   
>   static void stat64_to_hostfs(const struct stat64 *buf, struct hostfs_stat *p)
>   {
> @@ -44,9 +45,9 @@ int stat_file(const char *path, struct hostfs_stat *p, int fd)
>   	struct stat64 buf;
>   
>   	if (fd >= 0) {
> -		if (fstat64(fd, &buf) < 0)
> +		if (CATCH_EINTR(fstat64(fd, &buf)) < 0)
>   			return -errno;
> -	} else if (lstat64(path, &buf) < 0) {
> +	} else if (CATCH_EINTR(lstat64(path, &buf)) < 0) {
>   		return -errno;
>   	}
>   	stat64_to_hostfs(&buf, p);
> @@ -63,7 +64,7 @@ int access_file(char *path, int r, int w, int x)
>   		mode |= W_OK;
>   	if (x)
>   		mode |= X_OK;
> -	if (access(path, mode) != 0)
> +	if (CATCH_EINTR(access(path, mode)) != 0)
>   		return -errno;
>   	else return 0;
>   }
> @@ -82,7 +83,7 @@ int open_file(char *path, int r, int w, int append)
>   
>   	if (append)
>   		mode |= O_APPEND;
> -	fd = open64(path, mode);
> +	fd = CATCH_EINTR(open64(path, mode));
>   	if (fd < 0)
>   		return -errno;
>   	else return fd;
> @@ -92,7 +93,11 @@ void *open_dir(char *path, int *err_out)
>   {
>   	DIR *dir;
>   
> -	dir = opendir(path);
> +	do {
> +		errno = 0;
> +		dir = opendir(path);
> +	} while (dir == NULL && errno == -EINTR);
> +
>   	*err_out = errno;
>   
>   	return dir;
> @@ -112,9 +117,14 @@ char *read_dir(void *stream, unsigned long long *pos_out,
>   	DIR *dir = stream;
>   	struct dirent *ent;
>   
> -	ent = readdir(dir);
> +	do {
> +		errno = 0;
> +		ent = readdir(dir);
> +	} while (ent == 0 && errno == EINTR);
> +
>   	if (ent == NULL)
>   		return NULL;
> +
>   	*len_out = strlen(ent->d_name);
>   	*ino_out = ent->d_ino;
>   	*type_out = ent->d_type;
> @@ -125,30 +135,52 @@ char *read_dir(void *stream, unsigned long long *pos_out,
>   int read_file(int fd, unsigned long long *offset, char *buf, int len)
>   {
>   	int n;
> +	int read = 0;
> +
> +	do {
> +		errno = 0;
> +		n = pread64(fd, buf, len, *offset);
> +		if (n > 0) {
> +			read += n;
> +			*offset += n;
> +			len -= n;
> +			continue;
> +		}
> +	} while (n < 0 && errno == EINTR);
>   
> -	n = pread64(fd, buf, len, *offset);
> -	if (n < 0)
> -		return -errno;
> -	*offset += n;
> -	return n;
> +	if (read > 0)
> +		return read;
> +
> +	return -errno;
>   }
>   
>   int write_file(int fd, unsigned long long *offset, const char *buf, int len)
>   {
>   	int n;
> +	int written = 0;
> +
> +	do {
> +		errno = 0;
> +		n = pwrite64(fd, buf, len, *offset);
> +		if (n > 0) {
> +			written += n;
> +			*offset += n;
> +			len -= n;
> +			continue;
> +		}
> +	} while (n < 0 && errno == EINTR);
>   
> -	n = pwrite64(fd, buf, len, *offset);
> -	if (n < 0)
> -		return -errno;
> -	*offset += n;
> -	return n;
> +	if (written > 0)
> +		return written;
> +
> +	return -errno;
>   }
>   
>   int lseek_file(int fd, long long offset, int whence)
>   {
>   	int ret;
>   
> -	ret = lseek64(fd, offset, whence);
> +	ret = CATCH_EINTR(lseek64(fd, offset, whence));
>   	if (ret < 0)
>   		return -errno;
>   	return 0;
> @@ -158,9 +190,9 @@ int fsync_file(int fd, int datasync)
>   {
>   	int ret;
>   	if (datasync)
> -		ret = fdatasync(fd);
> +		ret = CATCH_EINTR(fdatasync(fd));
>   	else
> -		ret = fsync(fd);
> +		ret = CATCH_EINTR(fsync(fd));
>   
>   	if (ret < 0)
>   		return -errno;
> @@ -169,24 +201,24 @@ int fsync_file(int fd, int datasync)
>   
>   int replace_file(int oldfd, int fd)
>   {
> -	return dup2(oldfd, fd);
> +	return CATCH_EINTR(dup2(oldfd, fd));
>   }
>   
>   void close_file(void *stream)
>   {
> -	close(*((int *) stream));
> +	CATCH_EINTR(close(*((int *) stream)));
>   }
>   
>   void close_dir(void *stream)
>   {
> -	closedir(stream);
> +	CATCH_EINTR(closedir(stream));
>   }
>   
>   int file_create(char *name, int mode)
>   {
>   	int fd;
>   
> -	fd = open64(name, O_CREAT | O_RDWR, mode);
> +	fd = CATCH_EINTR(open64(name, O_CREAT | O_RDWR, mode));
>   	if (fd < 0)
>   		return -errno;
>   	return fd;
> @@ -200,33 +232,33 @@ int set_attr(const char *file, struct hostfs_iattr *attrs, int fd)
>   
>   	if (attrs->ia_valid & HOSTFS_ATTR_MODE) {
>   		if (fd >= 0) {
> -			if (fchmod(fd, attrs->ia_mode) != 0)
> +			if (CATCH_EINTR(fchmod(fd, attrs->ia_mode)) != 0)
>   				return -errno;
> -		} else if (chmod(file, attrs->ia_mode) != 0) {
> +		} else if (CATCH_EINTR(chmod(file, attrs->ia_mode)) != 0) {
>   			return -errno;
>   		}
>   	}
>   	if (attrs->ia_valid & HOSTFS_ATTR_UID) {
>   		if (fd >= 0) {
> -			if (fchown(fd, attrs->ia_uid, -1))
> +			if (CATCH_EINTR(fchown(fd, attrs->ia_uid, -1)))
>   				return -errno;
> -		} else if (chown(file, attrs->ia_uid, -1)) {
> +		} else if (CATCH_EINTR(chown(file, attrs->ia_uid, -1))) {
>   			return -errno;
>   		}
>   	}
>   	if (attrs->ia_valid & HOSTFS_ATTR_GID) {
>   		if (fd >= 0) {
> -			if (fchown(fd, -1, attrs->ia_gid))
> +			if (CATCH_EINTR(fchown(fd, -1, attrs->ia_gid)))
>   				return -errno;
> -		} else if (chown(file, -1, attrs->ia_gid)) {
> +		} else if (CATCH_EINTR(chown(file, -1, attrs->ia_gid))) {
>   			return -errno;
>   		}
>   	}
>   	if (attrs->ia_valid & HOSTFS_ATTR_SIZE) {
>   		if (fd >= 0) {
> -			if (ftruncate(fd, attrs->ia_size))
> +			if (CATCH_EINTR(ftruncate(fd, attrs->ia_size)))
>   				return -errno;
> -		} else if (truncate(file, attrs->ia_size)) {
> +		} else if (CATCH_EINTR(truncate(file, attrs->ia_size))) {
>   			return -errno;
>   		}
>   	}
> @@ -279,7 +311,7 @@ int make_symlink(const char *from, const char *to)
>   {
>   	int err;
>   
> -	err = symlink(to, from);
> +	err = CATCH_EINTR(symlink(to, from));
>   	if (err)
>   		return -errno;
>   	return 0;
> @@ -289,7 +321,7 @@ int unlink_file(const char *file)
>   {
>   	int err;
>   
> -	err = unlink(file);
> +	err = CATCH_EINTR(unlink(file));
>   	if (err)
>   		return -errno;
>   	return 0;
> @@ -299,7 +331,7 @@ int do_mkdir(const char *file, int mode)
>   {
>   	int err;
>   
> -	err = mkdir(file, mode);
> +	err = CATCH_EINTR(mkdir(file, mode));
>   	if (err)
>   		return -errno;
>   	return 0;
> @@ -309,7 +341,7 @@ int hostfs_do_rmdir(const char *file)
>   {
>   	int err;
>   
> -	err = rmdir(file);
> +	err = CATCH_EINTR(rmdir(file));
>   	if (err)
>   		return -errno;
>   	return 0;
> @@ -319,7 +351,7 @@ int do_mknod(const char *file, int mode, unsigned int major, unsigned int minor)
>   {
>   	int err;
>   
> -	err = mknod(file, mode, os_makedev(major, minor));
> +	err = CATCH_EINTR(mknod(file, mode, os_makedev(major, minor)));
>   	if (err)
>   		return -errno;
>   	return 0;
> @@ -329,7 +361,7 @@ int link_file(const char *to, const char *from)
>   {
>   	int err;
>   
> -	err = link(to, from);
> +	err = CATCH_EINTR(link(to, from));
>   	if (err)
>   		return -errno;
>   	return 0;
> @@ -339,7 +371,7 @@ int hostfs_do_readlink(char *file, char *buf, int size)
>   {
>   	int n;
>   
> -	n = readlink(file, buf, size);
> +	n = CATCH_EINTR(readlink(file, buf, size));
>   	if (n < 0)
>   		return -errno;
>   	if (n < size)
> @@ -351,7 +383,7 @@ int rename_file(char *from, char *to)
>   {
>   	int err;
>   
> -	err = rename(from, to);
> +	err = CATCH_EINTR(rename(from, to));
>   	if (err < 0)
>   		return -errno;
>   	return 0;
> @@ -371,7 +403,8 @@ int rename2_file(char *from, char *to, unsigned int flags)
>   #endif
>   
>   #ifdef SYS_renameat2
> -	err = syscall(SYS_renameat2, AT_FDCWD, from, AT_FDCWD, to, flags);
> +	err = CATCH_EINTR(syscall(SYS_renameat2, AT_FDCWD, from,
> +				  AT_FDCWD, to, flags));
>   	if (err < 0) {
>   		if (errno != ENOSYS)
>   			return -errno;
> @@ -392,7 +425,7 @@ int do_statfs(char *root, long *bsize_out, long long *blocks_out,
>   	struct statfs64 buf;
>   	int err;
>   
> -	err = statfs64(root, &buf);
> +	err = CATCH_EINTR(statfs64(root, &buf));
>   	if (err < 0)
>   		return -errno;
>   

If we are going to use this definition of CATCH_EINTR throughout we might as well remove the partial read/write code in UBD and other places.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

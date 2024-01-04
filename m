Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F727C47073
	for <linux-um@archiver.kernel.org>; Thu,  4 Jan 2024 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYRRCO4KBP/HYTlG/+rmoGgvbm1La7xMNMz+BwjWjtM=; b=1VPkqsC8ENF1262PXO/NRG2+gl
	v5WnDpxmTmMhQHfYfkGdT0e5nf+0h28I0p6piM4O9ftGYlYd0/C27Ao0G6R5jkgCXZmAesgw7lbAB
	OXaF9HKQeUGVPtR5C5uELhC68ZKsnN5MEN451YejApK6Wk6tibkWFkup8NiY0GxJ6qqZZXemoXOWa
	FZr0cZ/uiusROOrxJb1Og43by6btTR5PrOTHxWdHw2vVsiRbReIxJ5+CfkUe+2aoYSCNKmT439LZ1
	o+RbdgjLanT7BVoqgfcZkkjtgwfKgbp4CyKftSJLGf9BKmxDTKUCSiVOfMAYhvdngo5xLCTQ1V8Wa
	0c8CgqfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWBY-00FLZr-13;
	Thu, 04 Jan 2024 22:27:32 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWBV-00FLZX-1W
	for linux-um@lists.infradead.org;
	Thu, 04 Jan 2024 22:27:31 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so1286373e87.3
        for <linux-um@lists.infradead.org>; Thu, 04 Jan 2024 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704407247; x=1705012047; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYRRCO4KBP/HYTlG/+rmoGgvbm1La7xMNMz+BwjWjtM=;
        b=Gd2tZydsEQEU0UdEB1Djk5SyCCcATZP8JnRR1lDtwEmGaeOtMfMSMmOJrotUFhjqrW
         eSY9RCYJGmfURr7hTidcD6Vj2RNIdDEJgZJf1ZK9LDg78kQ9MtPjyfZQqiyS6hYBHwft
         rupYRXvO24L1kROiFF0uJnMm8tNVh0meBOq5moQNzR8FYwIID5gdcFa9cIkJ2RMrvO2/
         Txbu3+qBbC30XwW6wMUwgfsY20uEDssxLsJ9g/ITP7/5yI5bxwFXhbaqJvzmBDInzMpp
         uPRUFw+wp6oQwmmDY6lk8m8WJmgzSut7lhnTvIyHe7LFbKiWVklrPaHZBmLauL47vmPd
         D7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407247; x=1705012047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYRRCO4KBP/HYTlG/+rmoGgvbm1La7xMNMz+BwjWjtM=;
        b=uXyLg2BBHPBJgp0Y9lgGVwTO/9VUdrK6jBJIwsuZ1Fk1Mz0TycVOmkwRQfSvs8z58Y
         qGD2E7BheiQKbD9xcN9V/rOgk3xMspwNuwwJ3E6qXKrq0glLMrsipxUzaoK9G7DztIg5
         HkRyRlD4a+t4aAqwJ9Z4/U0lJD3kLzhvWCXJQyfXJGFv5mUvEbfv30ByUnk2dK7SRzwK
         nERADC808mAF7Nljj6WPtxjDcJ6XVlv3bYDuuqtfRfvk8sMab7hSNdaff3mHYua+91qu
         kgR+2mXN5ZvpQwOm+Ngo0v8FzwAhYCB032NZF9ZF30skQJEpYYKwVDDH5ODGyaNz9EHc
         tn3A==
X-Gm-Message-State: AOJu0YyfhGznsiJ9MZUa6AhDRdwTUjcAKTHklfogsqffym3Z2NwF29MN
	+TRE1kdAP9koBF56Ws4eGStGZAnJZuaW7FPfrWE=
X-Google-Smtp-Source: AGHT+IGICv9hErMY5za47fEQPMu9A2AbkZ/y5OVInSsa0kQAWvfGtTh1B6YfHb/TxfG/108F6DefeE8wEXmwvdPRKCs=
X-Received: by 2002:a19:e018:0:b0:50e:51fa:1d3b with SMTP id
 x24-20020a19e018000000b0050e51fa1d3bmr719599lfg.93.1704407247058; Thu, 04 Jan
 2024 14:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20231110094425.1810667-1-benjamin@sipsolutions.net>
In-Reply-To: <20231110094425.1810667-1-benjamin@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 4 Jan 2024 23:27:14 +0100
Message-ID: <CAFLxGvze3YR_LMvHK2Ox+6BF4wOo27GKA9JnS=-NgtCrPMFcUg@mail.gmail.com>
Subject: Re: [PATCH] um: hostfs: catch EINTR and partial read/write
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_142729_511050_0AF835E8 
X-CRM114-Status: GOOD (  31.02  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, Nov 10, 2023 at 10:44=E2=80=AFAM <benjamin@sipsolutions.net> wrote:
>
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

I'm confused. Your patches makes hostfs robust to EINTR but it doesn't
remove the blocking, right?

In what scenarios do you see hostfs failing due to signals right now?

> If, at any point, hostfs becomes able to push operations into the
> background in order to schedule another task, then an abortion mechanism
> may be needed.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/um/include/shared/os.h |   7 ++-
>  fs/hostfs/hostfs_user.c     | 115 +++++++++++++++++++++++-------------
>  2 files changed, 80 insertions(+), 42 deletions(-)
>
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index 0df646c6651e..7c5564ebc5bb 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -18,7 +18,12 @@
>  #include <sys/types.h>
>  #endif
>
> -#define CATCH_EINTR(expr) while ((errno =3D 0, ((expr) < 0)) && (errno =
=3D=3D EINTR))
> +#define CATCH_EINTR(expr) ({                                           \
> +               int __result;                                           \
> +               while ((errno =3D 0, ((__result =3D (expr)) < 0)) &&     =
   \
> +                      (errno =3D=3D EINTR));                            =
   \
> +               __result;                                               \
> +       })

This needs to be a patch on it's own.

>  #define OS_TYPE_FILE 1
>  #define OS_TYPE_DIR 2
> diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
> index 840619e39a1a..dd30bcc6d58f 100644
> --- a/fs/hostfs/hostfs_user.c
> +++ b/fs/hostfs/hostfs_user.c
> @@ -17,6 +17,7 @@
>  #include <sys/syscall.h>
>  #include "hostfs.h"
>  #include <utime.h>
> +#include <os.h>
>
>  static void stat64_to_hostfs(const struct stat64 *buf, struct hostfs_sta=
t *p)
>  {
> @@ -44,9 +45,9 @@ int stat_file(const char *path, struct hostfs_stat *p, =
int fd)
>         struct stat64 buf;
>
>         if (fd >=3D 0) {
> -               if (fstat64(fd, &buf) < 0)
> +               if (CATCH_EINTR(fstat64(fd, &buf)) < 0)
>                         return -errno;
> -       } else if (lstat64(path, &buf) < 0) {
> +       } else if (CATCH_EINTR(lstat64(path, &buf)) < 0) {
>                 return -errno;
>         }
>         stat64_to_hostfs(&buf, p);
> @@ -63,7 +64,7 @@ int access_file(char *path, int r, int w, int x)
>                 mode |=3D W_OK;
>         if (x)
>                 mode |=3D X_OK;
> -       if (access(path, mode) !=3D 0)
> +       if (CATCH_EINTR(access(path, mode)) !=3D 0)
>                 return -errno;
>         else return 0;
>  }
> @@ -82,7 +83,7 @@ int open_file(char *path, int r, int w, int append)
>
>         if (append)
>                 mode |=3D O_APPEND;
> -       fd =3D open64(path, mode);
> +       fd =3D CATCH_EINTR(open64(path, mode));
>         if (fd < 0)
>                 return -errno;
>         else return fd;
> @@ -92,7 +93,11 @@ void *open_dir(char *path, int *err_out)
>  {
>         DIR *dir;
>
> -       dir =3D opendir(path);
> +       do {
> +               errno =3D 0;
> +               dir =3D opendir(path);
> +       } while (dir =3D=3D NULL && errno =3D=3D -EINTR);
> +
>         *err_out =3D errno;
>
>         return dir;
> @@ -112,9 +117,14 @@ char *read_dir(void *stream, unsigned long long *pos=
_out,
>         DIR *dir =3D stream;
>         struct dirent *ent;
>
> -       ent =3D readdir(dir);
> +       do {
> +               errno =3D 0;
> +               ent =3D readdir(dir);
> +       } while (ent =3D=3D 0 && errno =3D=3D EINTR);
> +
>         if (ent =3D=3D NULL)
>                 return NULL;
> +
>         *len_out =3D strlen(ent->d_name);
>         *ino_out =3D ent->d_ino;
>         *type_out =3D ent->d_type;
> @@ -125,30 +135,52 @@ char *read_dir(void *stream, unsigned long long *po=
s_out,
>  int read_file(int fd, unsigned long long *offset, char *buf, int len)
>  {
>         int n;
> +       int read =3D 0;
> +
> +       do {
> +               errno =3D 0;
> +               n =3D pread64(fd, buf, len, *offset);
> +               if (n > 0) {
> +                       read +=3D n;
> +                       *offset +=3D n;
> +                       len -=3D n;
> +                       continue;
> +               }
> +       } while (n < 0 && errno =3D=3D EINTR);
>
> -       n =3D pread64(fd, buf, len, *offset);
> -       if (n < 0)
> -               return -errno;
> -       *offset +=3D n;
> -       return n;
> +       if (read > 0)
> +               return read;
> +
> +       return -errno;
>  }
>
>  int write_file(int fd, unsigned long long *offset, const char *buf, int =
len)
>  {
>         int n;
> +       int written =3D 0;
> +
> +       do {
> +               errno =3D 0;
> +               n =3D pwrite64(fd, buf, len, *offset);
> +               if (n > 0) {
> +                       written +=3D n;
> +                       *offset +=3D n;
> +                       len -=3D n;
> +                       continue;
> +               }
> +       } while (n < 0 && errno =3D=3D EINTR);
>
> -       n =3D pwrite64(fd, buf, len, *offset);
> -       if (n < 0)
> -               return -errno;
> -       *offset +=3D n;
> -       return n;
> +       if (written > 0)
> +               return written;
> +
> +       return -errno;
>  }
>
>  int lseek_file(int fd, long long offset, int whence)
>  {
>         int ret;
>
> -       ret =3D lseek64(fd, offset, whence);
> +       ret =3D CATCH_EINTR(lseek64(fd, offset, whence));
>         if (ret < 0)
>                 return -errno;
>         return 0;
> @@ -158,9 +190,9 @@ int fsync_file(int fd, int datasync)
>  {
>         int ret;
>         if (datasync)
> -               ret =3D fdatasync(fd);
> +               ret =3D CATCH_EINTR(fdatasync(fd));
>         else
> -               ret =3D fsync(fd);
> +               ret =3D CATCH_EINTR(fsync(fd));
>
>         if (ret < 0)
>                 return -errno;
> @@ -169,24 +201,24 @@ int fsync_file(int fd, int datasync)
>
>  int replace_file(int oldfd, int fd)
>  {
> -       return dup2(oldfd, fd);
> +       return CATCH_EINTR(dup2(oldfd, fd));
>  }
>
>  void close_file(void *stream)
>  {
> -       close(*((int *) stream));
> +       CATCH_EINTR(close(*((int *) stream)));
>  }
>
>  void close_dir(void *stream)
>  {
> -       closedir(stream);
> +       CATCH_EINTR(closedir(stream));
>  }
>
>  int file_create(char *name, int mode)
>  {
>         int fd;
>
> -       fd =3D open64(name, O_CREAT | O_RDWR, mode);
> +       fd =3D CATCH_EINTR(open64(name, O_CREAT | O_RDWR, mode));
>         if (fd < 0)
>                 return -errno;
>         return fd;
> @@ -200,33 +232,33 @@ int set_attr(const char *file, struct hostfs_iattr =
*attrs, int fd)
>
>         if (attrs->ia_valid & HOSTFS_ATTR_MODE) {
>                 if (fd >=3D 0) {
> -                       if (fchmod(fd, attrs->ia_mode) !=3D 0)
> +                       if (CATCH_EINTR(fchmod(fd, attrs->ia_mode)) !=3D =
0)
>                                 return -errno;
> -               } else if (chmod(file, attrs->ia_mode) !=3D 0) {
> +               } else if (CATCH_EINTR(chmod(file, attrs->ia_mode)) !=3D =
0) {
>                         return -errno;
>                 }
>         }
>         if (attrs->ia_valid & HOSTFS_ATTR_UID) {
>                 if (fd >=3D 0) {
> -                       if (fchown(fd, attrs->ia_uid, -1))
> +                       if (CATCH_EINTR(fchown(fd, attrs->ia_uid, -1)))
>                                 return -errno;
> -               } else if (chown(file, attrs->ia_uid, -1)) {
> +               } else if (CATCH_EINTR(chown(file, attrs->ia_uid, -1))) {
>                         return -errno;
>                 }
>         }
>         if (attrs->ia_valid & HOSTFS_ATTR_GID) {
>                 if (fd >=3D 0) {
> -                       if (fchown(fd, -1, attrs->ia_gid))
> +                       if (CATCH_EINTR(fchown(fd, -1, attrs->ia_gid)))
>                                 return -errno;
> -               } else if (chown(file, -1, attrs->ia_gid)) {
> +               } else if (CATCH_EINTR(chown(file, -1, attrs->ia_gid))) {
>                         return -errno;
>                 }
>         }
>         if (attrs->ia_valid & HOSTFS_ATTR_SIZE) {
>                 if (fd >=3D 0) {
> -                       if (ftruncate(fd, attrs->ia_size))
> +                       if (CATCH_EINTR(ftruncate(fd, attrs->ia_size)))
>                                 return -errno;
> -               } else if (truncate(file, attrs->ia_size)) {
> +               } else if (CATCH_EINTR(truncate(file, attrs->ia_size))) {
>                         return -errno;
>                 }
>         }
> @@ -279,7 +311,7 @@ int make_symlink(const char *from, const char *to)
>  {
>         int err;
>
> -       err =3D symlink(to, from);
> +       err =3D CATCH_EINTR(symlink(to, from));
>         if (err)
>                 return -errno;
>         return 0;
> @@ -289,7 +321,7 @@ int unlink_file(const char *file)
>  {
>         int err;
>
> -       err =3D unlink(file);
> +       err =3D CATCH_EINTR(unlink(file));
>         if (err)
>                 return -errno;
>         return 0;
> @@ -299,7 +331,7 @@ int do_mkdir(const char *file, int mode)
>  {
>         int err;
>
> -       err =3D mkdir(file, mode);
> +       err =3D CATCH_EINTR(mkdir(file, mode));
>         if (err)
>                 return -errno;
>         return 0;
> @@ -309,7 +341,7 @@ int hostfs_do_rmdir(const char *file)
>  {
>         int err;
>
> -       err =3D rmdir(file);
> +       err =3D CATCH_EINTR(rmdir(file));
>         if (err)
>                 return -errno;
>         return 0;
> @@ -319,7 +351,7 @@ int do_mknod(const char *file, int mode, unsigned int=
 major, unsigned int minor)
>  {
>         int err;
>
> -       err =3D mknod(file, mode, os_makedev(major, minor));
> +       err =3D CATCH_EINTR(mknod(file, mode, os_makedev(major, minor)));
>         if (err)
>                 return -errno;
>         return 0;
> @@ -329,7 +361,7 @@ int link_file(const char *to, const char *from)
>  {
>         int err;
>
> -       err =3D link(to, from);
> +       err =3D CATCH_EINTR(link(to, from));
>         if (err)
>                 return -errno;
>         return 0;
> @@ -339,7 +371,7 @@ int hostfs_do_readlink(char *file, char *buf, int siz=
e)
>  {
>         int n;
>
> -       n =3D readlink(file, buf, size);
> +       n =3D CATCH_EINTR(readlink(file, buf, size));
>         if (n < 0)
>                 return -errno;
>         if (n < size)
> @@ -351,7 +383,7 @@ int rename_file(char *from, char *to)
>  {
>         int err;
>
> -       err =3D rename(from, to);
> +       err =3D CATCH_EINTR(rename(from, to));
>         if (err < 0)
>                 return -errno;
>         return 0;
> @@ -371,7 +403,8 @@ int rename2_file(char *from, char *to, unsigned int f=
lags)
>  #endif
>
>  #ifdef SYS_renameat2
> -       err =3D syscall(SYS_renameat2, AT_FDCWD, from, AT_FDCWD, to, flag=
s);
> +       err =3D CATCH_EINTR(syscall(SYS_renameat2, AT_FDCWD, from,
> +                                 AT_FDCWD, to, flags));
>         if (err < 0) {
>                 if (errno !=3D ENOSYS)
>                         return -errno;
> @@ -392,7 +425,7 @@ int do_statfs(char *root, long *bsize_out, long long =
*blocks_out,
>         struct statfs64 buf;
>         int err;
>
> -       err =3D statfs64(root, &buf);
> +       err =3D CATCH_EINTR(statfs64(root, &buf));
>         if (err < 0)
>                 return -errno;

In general I'm not so happy with adding CATCH_EINTR() to all call sites.
As Anton suggested, a new helper would be nice for each file method.

--=20
Thanks,
//richard


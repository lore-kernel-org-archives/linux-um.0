Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriel de Perthuis <g2p.code@gmail.com>
Date: Sat, 27 Jul 2013 17:23:27 +0200
Message-Id: <1374938607-25747-1-git-send-email-g2p.code@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Accept /dev/fd/* uml block devices
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Gabriel de Perthuis <g2p.code@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Useful for
* limiting privileges
* opening block devices O_EXCL

Use dup to work around the fact /proc/self/fd
can't be opened after dropping privileges.
This proc behaviour doesn't match TLPI and might be a bug.

Qemu has a slightly more complex fdset approach
that provides fds with different access permissions.

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
---
 arch/um/os-Linux/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index c17bd6f..cee65ba 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -169,11 +169,11 @@ int os_file_mode(const char *file, struct openflags *mode_out)
 	return err;
 }
 
 int os_open_file(const char *file, struct openflags flags, int mode)
 {
-	int fd, err, f = 0;
+	int fd, fd0, err, f = 0;
 
 	if (flags.r && flags.w)
 		f = O_RDWR;
 	else if (flags.r)
 		f = O_RDONLY;
@@ -190,11 +190,15 @@ int os_open_file(const char *file, struct openflags flags, int mode)
 	if (flags.e)
 		f |= O_EXCL;
 	if (flags.a)
 		f |= O_APPEND;
 
-	fd = open64(file, f, mode);
+	if (!strncmp(file, "/dev/fd/", 8)
+	    && sscanf(file, "/dev/fd/%d", &fd0) == 1)
+		fd = dup(fd0);
+	else
+		fd = open64(file, f, mode);
 	if (fd < 0)
 		return -errno;
 
 	if (flags.cl && fcntl(fd, F_SETFD, 1)) {
 		err = -errno;
@@ -280,11 +284,11 @@ int os_file_size(const char *file, unsigned long long *size_out)
 
 	if (S_ISBLK(buf.ust_mode)) {
 		int fd;
 		long blocks;
 
-		fd = open(file, O_RDONLY, 0);
+		fd = os_open_file(file, of_read(OPENFLAGS()), 0);
 		if (fd < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "Couldn't open \"%s\", "
 			       "errno = %d\n", file, errno);
 			return err;
-- 
1.8.3.3.758.g90e98ff


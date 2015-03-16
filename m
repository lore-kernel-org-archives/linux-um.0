Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:07 +0100
Message-Id: <1426506079-26183-4-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 03/15] hostfs: Allow fsync on directories
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Historically hostfs did not open directories on the host filesystem
for performance and memory reasons.
But it turned out that this optimization has a drawback.
Calling fsync() on a hostfs directory returns immediately
with -EINVAL as fsync is not implemented.
While this is behavior is strictly speaking correct common userspace
like dpkg(1) stumbles over that and makes it impossible to use
hostfs as root filesystem.
The fix is easy, wire up the existing host open/fsync functions
to the directory file operations.

Reported-by: Daniel Gr=C3=B6ber <dxld@darkboxed.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 112ba5a..92b008f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -295,7 +295,7 @@ static int hostfs_readdir(struct file *file, struct=
 dir_context *ctx)
 	return 0;
 }
=20
-static int hostfs_file_open(struct inode *ino, struct file *file)
+static int hostfs_open(struct inode *ino, struct file *file)
 {
 	char *name;
 	fmode_t mode =3D 0;
@@ -386,7 +386,7 @@ static const struct file_operations hostfs_file_fop=
s =3D {
 	.write_iter	=3D generic_file_write_iter,
 	.write		=3D new_sync_write,
 	.mmap		=3D generic_file_mmap,
-	.open		=3D hostfs_file_open,
+	.open		=3D hostfs_open,
 	.release	=3D hostfs_file_release,
 	.fsync		=3D hostfs_fsync,
 };
@@ -395,6 +395,8 @@ static const struct file_operations hostfs_dir_fops=
 =3D {
 	.llseek		=3D generic_file_llseek,
 	.iterate	=3D hostfs_readdir,
 	.read		=3D generic_read_dir,
+	.open		=3D hostfs_open,
+	.fsync		=3D hostfs_fsync,
 };
=20
 static int hostfs_writepage(struct page *page, struct writeback_contro=
l *wbc)
--=20
2.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


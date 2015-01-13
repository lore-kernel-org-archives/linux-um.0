Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 13 Jan 2015 23:15:58 +0100
Message-Id: <1421187358-32600-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] hostfs: Use noop_fsync for directories
To: user-mode-linux-devel@lists.sourceforge.net
Cc: dxld@darkboxed.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Daniel reported that dpkg(1) dies if the root filesystem is a hostfs
because it does not expect fsync(2) to fail with EINVAL on directories.
While fsync(2) is allowed to fail with EINVAL if the filesystem does no=
t
support it we can do better and use noop_fsync() to not confuse userspa=
ce
further.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Daniel Gr=C3=B6ber <dxld@darkboxed.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index fd62cae..a7ac856 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -393,6 +393,7 @@ static const struct file_operations hostfs_dir_fops=
 =3D {
 	.llseek		=3D generic_file_llseek,
 	.iterate	=3D hostfs_readdir,
 	.read		=3D generic_read_dir,
+	.fsync		=3D noop_fsync,
 };
=20
 static int hostfs_writepage(struct page *page, struct writeback_contro=
l *wbc)
--=20
1.8.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


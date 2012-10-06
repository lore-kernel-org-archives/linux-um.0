Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <506FEC51.3020205@gmail.com>
Date: Sat, 06 Oct 2012 10:31:13 +0200
From: Marco Stornelli <marco.stornelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 14/22] hostfs: drop vmtruncate
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Removed vmtruncate.

Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
---
 fs/hostfs/hostfs_kern.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6c9f3a9..4348e84 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -848,9 +848,11 @@ int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 	    attr->ia_size != i_size_read(inode)) {
 		int error;
 
-		error = vmtruncate(inode, attr->ia_size);
-		if (err)
-			return err;
+		error = inode_newsize_ok(inode, attr->ia_size);
+		if (error)
+			return error;
+
+		truncate_setsize(inode, attr->ia_size);
 	}
 
 	setattr_copy(inode, attr);
-- 
1.7.3.4

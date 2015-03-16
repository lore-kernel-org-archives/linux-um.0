Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:15 +0100
Message-Id: <1426506079-26183-12-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 11/15] hostfs: hostfs_open: Reset open flags upon each retry
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

...otherwise we might end up with an incorrect mode mode.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 8bbceae..80ced3d 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -315,6 +315,8 @@ static int hostfs_open(struct inode *ino, struct file *file)
 	mode |= HOSTFS_I(ino)->mode;
 
 retry:
+	r = w = 0;
+
 	if (mode & FMODE_READ)
 		r = 1;
 	if (mode & FMODE_WRITE)
-- 
2.3.2


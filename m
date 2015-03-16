Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:14 +0100
Message-Id: <1426506079-26183-11-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 10/15] hostfs: Remove superfluous test in hostfs_open()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 06b3e3f..8bbceae 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -318,9 +318,7 @@ retry:
 	if (mode & FMODE_READ)
 		r = 1;
 	if (mode & FMODE_WRITE)
-		w = 1;
-	if (w)
-		r = 1;
+		r = w = 1;
 
 	name = dentry_name(file->f_path.dentry);
 	if (name == NULL)
-- 
2.3.2


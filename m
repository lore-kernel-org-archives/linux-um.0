Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:06 +0100
Message-Id: <1426506079-26183-3-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 02/15] hostfs: hostfs_file_open: Fix a fd leak in hostfs_file_open
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

In case of a race between to callers of hostfs_file_open()
it can happen that a file describtor is leaked.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 104d58d..112ba5a 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -329,6 +329,7 @@ retry:
 	/* somebody else had handled it first? */
 	if ((mode & HOSTFS_I(ino)->mode) == mode) {
 		mutex_unlock(&HOSTFS_I(ino)->open_mutex);
+		close_file(&fd);
 		return 0;
 	}
 	if ((mode | HOSTFS_I(ino)->mode) != mode) {
-- 
2.3.2


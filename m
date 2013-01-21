Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 21 Jan 2013 14:02:56 +0100
Message-Id: <1358773378-4700-13-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1358773378-4700-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1358773378-4700-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 12/15] fs/hostfs/hostfs_kern.c: adjust duplicate test
To: Jeff Dike <jdike@addtoit.com>
Cc: kernel-janitors@vger.kernel.org, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Julia Lawall <Julia.Lawall@lip6.fr>

Delete successive tests to the same location.  This looks like simple code
duplication.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@s exists@
local idexpression y;
expression x,e;
@@

*if ( \(x == NULL\|IS_ERR(x)\|y != 0\) )
 { ... when forall
   return ...; }
... when != \(y = e\|y += e\|y -= e\|y |= e\|y &= e\|y++\|y--\|&y\)
    when != \(XT_GETPAGE(...,y)\|WMI_CMD_BUF(...)\)
*if ( \(x == NULL\|IS_ERR(x)\|y != 0\) )
 { ... when forall
   return ...; }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 fs/hostfs/hostfs_kern.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 457addc..909fc21 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -727,8 +727,6 @@ static int hostfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 	__putname(name);
 	if (err)
 		goto out_put;
-	if (err)
-		goto out_put;
 
 	d_instantiate(dentry, inode);
 	return 0;


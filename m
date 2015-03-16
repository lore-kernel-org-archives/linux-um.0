Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YXTOw-0006NU-VV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:42 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXTOv-0005fB-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:42 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:10 +0100
Message-Id: <1426506079-26183-7-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 06/15] hostfs: Add a BUG_ON to detect behavior
	changes of dentry_path_raw()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org

hostfs' __dentry_name() relies on the fact that dentry_path_raw() will place
the path name at the end of the provided buffer.
While this is okay, add a BUG_ON() to detect behavior changes as soon
as possible.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 67e556c..3082a7e 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -93,6 +93,13 @@ static char *__dentry_name(struct dentry *dentry, char *name)
 		__putname(name);
 		return NULL;
 	}
+
+	/*
+	 * This function relies on the fact that dentry_path_raw() will place
+	 * the path name at the end of the provided buffer.
+	 */
+	BUG_ON(p + strlen(p) + 1 != name + PATH_MAX);
+
 	strlcpy(name, root, PATH_MAX);
 	if (len > p - name) {
 		__putname(name);
-- 
2.3.2


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


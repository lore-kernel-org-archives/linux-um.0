Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOKGA-0006r5-Qn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:34 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOKGA-0000K0-1Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:18 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Mon, 05 Mar 2007 21:49:02 +0100
Message-Id: <20070305204902.9072.1224.stgit@americanbeauty.home.lan>
In-Reply-To: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 04/11] uml - hostfs: avoid possible escapes from
	hostfs=.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid accepting things like -o .., -o dir/../../dir2, -o dir/../.. .
This may be considered useless, but YMMV. I consider that this has a limited
security value, exactly like disabling module support (in many case it is
useful).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 9baf697..0bcf7ac 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -936,6 +936,28 @@ static const struct address_space_operations hostfs_link_aops = {
 	.readpage	= hostfs_link_readpage,
 };
 
+static inline int str_ends_with(const char * str, const char* suffix)
+{
+	size_t len = strlen(str), suffix_len = strlen(suffix);
+	return strcmp(str + len - suffix_len, suffix) == 0;
+}
+
+static int contains_dotdot(const char* path)
+{
+	/*
+	 * Prevent escaping from hostfs=folder, even if this is not useful to
+	 * jail the UML superuser.
+	 * Since foo..bar is a valid name, we must look for /../ in the string,
+	 * or for ../ at the beginning, /.. at the end, or check whether '..' is
+	 * the complete string.
+	 */
+
+	return  strstr(path, "/../") != NULL ||
+		strcmp(path, "..") == 0 ||
+		strncmp(path, "../", strlen("../")) == 0 ||
+		str_ends_with(path, "/..");
+}
+
 static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 {
 	struct inode *root_inode;
@@ -951,6 +973,10 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	if (data == NULL)
 		data = "";
 
+	err = -EINVAL;
+	if (unlikely(contains_dotdot(data)))
+		goto out;
+
 	err = -ENOMEM;
 	name = kmalloc(strlen(root_ino) + 1
 			+ strlen(data) + 1, GFP_KERNEL);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

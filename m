Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YXTOq-0002Gn-F8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:36 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXTOp-0006RL-AL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:36 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:08 +0100
Message-Id: <1426506079-26183-5-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 04/15] hostfs: Handle bogus st.mode
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org

Make sure that we return EIO if one passes an invalid st.mode
into hostfs.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 92b008f..8163aac 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -534,11 +534,13 @@ static int read_name(struct inode *ino, char *name)
 		init_special_inode(ino, st.mode & S_IFMT, rdev);
 		ino->i_op = &hostfs_iops;
 		break;
-
-	default:
+	case S_IFREG:
 		ino->i_op = &hostfs_iops;
 		ino->i_fop = &hostfs_file_fops;
 		ino->i_mapping->a_ops = &hostfs_aops;
+		break;
+	default:
+		return -EIO;
 	}
 
 	ino->i_ino = st.ino;
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


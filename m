Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yb6sv-0002JX-6G
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:41 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yb6su-00087u-3t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:41 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Mar 2015 13:27:18 +0100
Message-Id: <1427372838-16605-7-git-send-email-richard@nod.at>
In-Reply-To: <1427372838-16605-1-git-send-email-richard@nod.at>
References: <1427372838-16605-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 7/7] um: hostfs: Reduce number of syscalls in
	readdir
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Currently hostfs issues every time a seekdir(), in fact
it has to do this only upon the first call.
Also telldir() can be omitted as we can obtain the directory
offset from readdir().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs.h      |  3 ++-
 fs/hostfs/hostfs_kern.c |  1 +
 fs/hostfs/hostfs_user.c | 12 +++++++++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 4fcd40d..00f9c12 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -66,7 +66,8 @@ extern int stat_file(const char *path, struct hostfs_stat *p, int fd);
 extern int access_file(char *path, int r, int w, int x);
 extern int open_file(char *path, int r, int w, int append);
 extern void *open_dir(char *path, int *err_out);
-extern char *read_dir(void *stream, unsigned long long *pos,
+extern void seek_dir(void *stream, unsigned long long pos);
+extern char *read_dir(void *stream, unsigned long long *pos_out,
 		      unsigned long long *ino_out, int *len_out,
 		      unsigned int *type_out);
 extern void close_file(void *stream);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index fd62cae..968a2b5 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -284,6 +284,7 @@ static int hostfs_readdir(struct file *file, struct dir_context *ctx)
 	if (dir == NULL)
 		return -error;
 	next = ctx->pos;
+	seek_dir(dir, next);
 	while ((name = read_dir(dir, &next, &ino, &len, &type)) != NULL) {
 		if (!dir_emit(ctx, name, len, ino, type))
 			break;
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 9765dab..1d1f293 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -97,21 +97,27 @@ void *open_dir(char *path, int *err_out)
 	return dir;
 }
 
-char *read_dir(void *stream, unsigned long long *pos,
+void seek_dir(void *stream, unsigned long long pos)
+{
+	DIR *dir = stream;
+
+	seekdir(dir, pos);
+}
+
+char *read_dir(void *stream, unsigned long long *pos_out,
 	       unsigned long long *ino_out, int *len_out,
 	       unsigned int *type_out)
 {
 	DIR *dir = stream;
 	struct dirent *ent;
 
-	seekdir(dir, *pos);
 	ent = readdir(dir);
 	if (ent == NULL)
 		return NULL;
 	*len_out = strlen(ent->d_name);
 	*ino_out = ent->d_ino;
 	*type_out = ent->d_type;
-	*pos = telldir(dir);
+	*pos_out = ent->d_off;
 	return ent->d_name;
 }
 
-- 
1.8.4.5


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


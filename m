Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKeW5-00B5Tj-Lv
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 09:55:43 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/6] seq_file: rename mangle_path to seq_mangle_path
Date: Fri, 12 Mar 2021 10:55:21 +0100
Message-Id: <20210312104627.3ac77adf84c4.I2f2e5cec5cc82a51652dafbeb0d1b88708b3c565@changeid>
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

The symbol mangle_path conflicts with a gcov symbol which
can break the build of ARCH=um with gcov, and it's also
not very specific and descriptive.

Rename mangle_path() to seq_mangle_path(), and also remove
the export since it's not needed or used by any modules.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/seq_file.c            | 11 +++++------
 include/linux/seq_file.h |  2 +-
 lib/seq_buf.c            |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index cb11a34fb871..dfa1982a87ca 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -413,7 +413,7 @@ void seq_printf(struct seq_file *m, const char *f, ...)
 EXPORT_SYMBOL(seq_printf);
 
 /**
- *	mangle_path -	mangle and copy path to buffer beginning
+ *	seq_mangle_path -	mangle and copy path to buffer beginning
  *	@s: buffer start
  *	@p: beginning of path in above buffer
  *	@esc: set of characters that need escaping
@@ -423,7 +423,7 @@ EXPORT_SYMBOL(seq_printf);
  *      Returns pointer past last written character in @s, or NULL in case of
  *      failure.
  */
-char *mangle_path(char *s, const char *p, const char *esc)
+char *seq_mangle_path(char *s, const char *p, const char *esc)
 {
 	while (s <= p) {
 		char c = *p++;
@@ -442,7 +442,6 @@ char *mangle_path(char *s, const char *p, const char *esc)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(mangle_path);
 
 /**
  * seq_path - seq_file interface to print a pathname
@@ -462,7 +461,7 @@ int seq_path(struct seq_file *m, const struct path *path, const char *esc)
 	if (size) {
 		char *p = d_path(path, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
@@ -505,7 +504,7 @@ int seq_path_root(struct seq_file *m, const struct path *path,
 			return SEQ_SKIP;
 		res = PTR_ERR(p);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 			else
@@ -529,7 +528,7 @@ int seq_dentry(struct seq_file *m, struct dentry *dentry, const char *esc)
 	if (size) {
 		char *p = dentry_path(dentry, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877..0a7dda239e56 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -104,7 +104,7 @@ static inline void seq_setwidth(struct seq_file *m, size_t size)
 }
 void seq_pad(struct seq_file *m, char c);
 
-char *mangle_path(char *s, const char *p, const char *esc);
+char *seq_mangle_path(char *s, const char *p, const char *esc);
 int seq_open(struct file *, const struct seq_operations *);
 ssize_t seq_read(struct file *, char __user *, size_t, loff_t *);
 ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter);
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 707453f5d58e..90b50a514edb 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -274,7 +274,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 	if (size) {
 		char *p = d_path(path, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


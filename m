Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCg12-0002Ov-2O
 for linux-um@lists.infradead.org; Tue, 24 Sep 2019 08:17:45 +0000
Message-ID: <c8cbee753dc0306fd7597f43a45e05d99d404b29.camel@sipsolutions.net>
Subject: static EXPORT_SYMBOL checker causes false positives on ARCH=um
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 24 Sep 2019 10:17:40 +0200
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
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Denis Efremov <efremov@linux.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-kbuild@vger.kernel.org

Hi,

With the new commit 15bfc2348d54 ("modpost: check for static
EXPORT_SYMBOL* functions") we get a lot of warnings on ARCH=um builds:

WARNING: "rename" [vmlinux] is a static EXPORT_SYMBOL
WARNING: "lseek" [vmlinux] is a static EXPORT_SYMBOL
WARNING: "ftruncate64" [vmlinux] is a static EXPORT_SYMBOL
[...]
see https://p.sipsolutions.net/7232995f34907b9d.txt


This hack fixes *most* of them:

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 820eed87fb43..3e443563ebea 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1931,12 +1931,18 @@ static void check_sec_ref(struct module *mod, const char *modname,
 static char *remove_dot(char *s)
 {
 	size_t n = strcspn(s, ".");
+	char *at;
 
 	if (n && s[n]) {
 		size_t m = strspn(s + n + 1, "0123456789");
 		if (m && (s[n + m] == '.' || s[n + m] == 0))
 			s[n] = 0;
 	}
+
+	at = strchr(s, '@');
+	if (at)
+		*at = 0;
+
 	return s;
 }
 

(but obviously just serves to give you an idea of what's going on).


With that, only two remain for me:

WARNING: "__guard" [vmlinux] is a static EXPORT_SYMBOL
WARNING: "__stack_smash_handler" [vmlinux] is a static EXPORT_SYMBOL

and I think that's because they don't even exist at all, so arguably the
code shouldn't export them, but I didn't find a way to detect at build
time if -fstack-protector was enabled or not?

Any thoughts?

Thanks,
johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


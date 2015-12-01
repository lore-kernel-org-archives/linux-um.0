Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Geyslan G. Bem" <geyslan@gmail.com>
Date: Tue,  1 Dec 2015 17:18:55 -0300
Message-Id: <1449001135-29980-1-git-send-email-geyslan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: fix returns without va_end
To: jdike@addtoit.com
Cc: richard@nod.at, hwhilse@gmail.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, jg.victorino1@gmail.com, peter.senna@gmail.com, "Geyslan G. Bem" <geyslan@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

When using va_list ensure that va_start will be followed by va_end.

Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
---
 arch/um/drivers/net_user.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index e697a41..e9f8445 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -249,21 +249,23 @@ void close_addr(unsigned char *addr, unsigned char *netmask, void *arg)
 
 char *split_if_spec(char *str, ...)
 {
-	char **arg, *end;
+	char **arg, *end, *ret = NULL;
 	va_list ap;
 
 	va_start(ap, str);
 	while ((arg = va_arg(ap, char **)) != NULL) {
 		if (*str == '\0')
-			return NULL;
+			goto out;
 		end = strchr(str, ',');
 		if (end != str)
 			*arg = str;
 		if (end == NULL)
-			return NULL;
+			goto out;
 		*end++ = '\0';
 		str = end;
 	}
+	ret = str;
+out:
 	va_end(ap);
-	return str;
+	return ret;
 }
-- 
2.6.2


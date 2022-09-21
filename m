Return-Path: <linux-kernel-owner@vger.kernel.org>
From: cgel.zte@gmail.com
Subject: [PATCH linux-next] um: use strscpy() is more robust and safer
Date: Wed, 21 Sep 2022 09:29:44 +0000
Message-Id: <20220921092944.230413-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, baihaowen@meizu.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
List-ID: <linux-um.lists.infradead.org>

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/um/os-Linux/umid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 7a1abb829930..288c422bfa96 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -40,7 +40,7 @@ static int __init make_uml_dir(void)
 				__func__);
 			goto err;
 		}
-		strlcpy(dir, home, sizeof(dir));
+		strscpy(dir, home, sizeof(dir));
 		uml_dir++;
 	}
 	strlcat(dir, uml_dir, sizeof(dir));
@@ -243,7 +243,7 @@ int __init set_umid(char *name)
 	if (strlen(name) > UMID_LEN - 1)
 		return -E2BIG;
 
-	strlcpy(umid, name, sizeof(umid));
+	strscpy(umid, name, sizeof(umid));
 
 	return 0;
 }
@@ -262,7 +262,7 @@ static int __init make_umid(void)
 	make_uml_dir();
 
 	if (*umid == '\0') {
-		strlcpy(tmp, uml_dir, sizeof(tmp));
+		strscpy(tmp, uml_dir, sizeof(tmp));
 		strlcat(tmp, "XXXXXX", sizeof(tmp));
 		fd = mkstemp(tmp);
 		if (fd < 0) {
-- 
2.25.1


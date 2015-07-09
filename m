Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <christophe.jaillet@wanadoo.fr>) id 1ZD434-0005AM-KS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jul 2015 05:07:02 +0000
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]
	helo=smtp.smtpout.orange.fr)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZD433-0001OV-K8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jul 2015 05:07:02 +0000
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu,  9 Jul 2015 07:06:04 +0200
Message-Id: <1436418364-5201-2-git-send-email-christophe.jaillet@wanadoo.fr>
In-Reply-To: <1436418364-5201-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1436382947-13181-1-git-send-email-christophe.jaillet@wanadoo.fr>
	<1436418364-5201-1-git-send-email-christophe.jaillet@wanadoo.fr>
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
Subject: [uml-devel] [PATCH 2/2] um: umid: Use strdup to simplify code
To: jdike@addtoit.com, richard@nod.at
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kernel-janitors@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Replace a malloc+strcpy by an equivalent strdup in order to improve
readability.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/um/os-Linux/umid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index b514ead..cc9ac2e 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -48,12 +48,11 @@ static int __init make_uml_dir(void)
 		strlcat(dir, "/", sizeof(dir));
 
 	err = -ENOMEM;
-	uml_dir = malloc(strlen(dir) + 1);
+	uml_dir = strdup(dir);
 	if (uml_dir == NULL) {
-		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
+		printf("make_uml_dir : strdup failed, errno = %d\n", errno);
 		goto err;
 	}
-	strcpy(uml_dir, dir);
 
 	if ((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)) {
 		printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
-- 
2.1.4


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


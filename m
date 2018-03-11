Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 9/9] um/drivers/vector_user: Delete an unnecessary variable
 initialisation in user_init_tap_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <ed22974c-5c72-9a56-f67a-1ffab61f0646@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:24:58 +0100
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 15:50:29 +0100

The local variable "fd" will eventually be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index bd625034a0f0..3bd510eded58 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -119,9 +119,8 @@ struct arglist *uml_parse_vector_ifspec(char *arg)
 static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 {
 	struct ifreq ifr;
-	int fd = -1;
 	struct sockaddr_ll sock;
-	int err = -ENOMEM, offload;
+	int err = -ENOMEM, fd, offload;
 	char *iface;
 	struct vector_fds *result;
 
-- 
2.16.2



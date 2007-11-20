Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Joe Perches <joe@perches.com>
Date: Mon, 19 Nov 2007 17:48:00 -0800
Message-Id: <1195523331-15303-9-git-send-email-joe@perches.com>
In-Reply-To: <1195523331-15303-8-git-send-email-joe@perches.com>
References: 1234567 <1195523331-15303-1-git-send-email-joe@perches.com>
	<1195523331-15303-2-git-send-email-joe@perches.com>
	<1195523331-15303-3-git-send-email-joe@perches.com>
	<1195523331-15303-4-git-send-email-joe@perches.com>
	<1195523331-15303-5-git-send-email-joe@perches.com>
	<1195523331-15303-6-git-send-email-joe@perches.com>
	<1195523331-15303-7-git-send-email-joe@perches.com>
	<1195523331-15303-8-git-send-email-joe@perches.com>
Message-Id: <fbeb04f6d7134565611741ad0148e1b401362ef9.1195454434.git.joe@perches.com>
In-Reply-To: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
References: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
Subject: [uml-devel] [PATCH 08/59] arch/um: Add missing "space"
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/um/drivers/vde_user.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/vde_user.c b/arch/um/drivers/vde_user.c
index d9941fe..56533db 100644
--- a/arch/um/drivers/vde_user.c
+++ b/arch/um/drivers/vde_user.c
@@ -80,7 +80,7 @@ void vde_init_libstuff(struct vde_data *vpri, struct vde_init *init)
 
 	vpri->args = kmalloc(sizeof(struct vde_open_args), UM_GFP_KERNEL);
 	if (vpri->args == NULL) {
-		printk(UM_KERN_ERR "vde_init_libstuff - vde_open_args"
+		printk(UM_KERN_ERR "vde_init_libstuff - vde_open_args "
 		       "allocation failed");
 		return;
 	}
-- 
1.5.3.5.652.gf192c


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

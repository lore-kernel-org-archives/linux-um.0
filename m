Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Joe Perches <joe@perches.com>
Date: Sun, 28 Jun 2009 09:26:15 -0700
Message-Id: <ea88a396964053c31a743f997d4cc6e7d53987cf.1246173680.git.joe@perches.com>
In-Reply-To: <cover.1246173664.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Subject: [uml-devel] [PATCH 10/62] arch/um/drivers/net_kern.c: Remove
	unnecessary semicolons
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
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, trivial@kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/um/drivers/net_kern.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 3b44b47..5072d4b 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -533,7 +533,7 @@ static int eth_parse(char *str, int *index_out, char **str_out,
 		     char **error_out)
 {
 	char *end;
-	int n, err = -EINVAL;;
+	int n, err = -EINVAL;
 
 	n = simple_strtoul(str, &end, 0);
 	if (end == str) {
-- 
1.6.3.1.10.g659a0.dirty


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


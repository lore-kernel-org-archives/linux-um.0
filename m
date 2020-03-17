Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jE0ME-0008O7-EB
 for linux-um@lists.infradead.org; Tue, 17 Mar 2020 00:45:23 +0000
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 0/2] fixes to the hypervisor ubd thread
Date: Mon, 16 Mar 2020 20:45:05 -0400
Message-Id: <20200317004507.1513370-1-krisman@collabora.com>
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
To: jdike@addtoit.com
Cc: richard@nod.at, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>, anton.ivanov@cambridgegreys.com

Hi,

While debugging a somewhat related issue, I ran into two issues I
believe can cause the hypervisor to write garbage to the pipe.

This was find by visual inspection and is only slightly tested.  It
seems to partially some the problems my test case shows.

Please, let me know what you think

Gabriel Krisman Bertazi (2):
  um: ubd: Prevent buffer overrun on command completion
  um: ubd: Retry buffer read on any kind of error

 arch/um/drivers/ubd_kern.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.25.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


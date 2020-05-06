Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/15] maccess: unexport probe_kernel_write and
 probe_user_write
Date: Wed,  6 May 2020 08:22:09 +0200
Message-Id: <20200506062223.30032-2-hch@lst.de>
In-Reply-To: <20200506062223.30032-1-hch@lst.de>
References: <20200506062223.30032-1-hch@lst.de>
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
To: x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, netdev@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org

These two functions are not used by any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/maccess.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 3ca8d97e50106..cf21e604f78cb 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -121,7 +121,6 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(probe_kernel_write);
 
 /**
  * probe_user_write(): safely attempt to write to a user-space location
@@ -148,7 +147,6 @@ long __probe_user_write(void __user *dst, const void *src, size_t size)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(probe_user_write);
 
 /**
  * strncpy_from_unsafe: - Copy a NUL terminated string from unsafe address.
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


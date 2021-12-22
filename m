Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzwou-009d9G-NH
 for linux-um@lists.infradead.org; Wed, 22 Dec 2021 08:17:57 +0000
Date: Wed, 22 Dec 2021 09:17:53 +0100
From: hch <hch@lst.de>
Subject: Re: remove set_fs for UML
Message-ID: <20211222081753.GB22041@lst.de>
References: <20211215165612.554426-1-hch@lst.de>
 <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: hch <hch@lst.de>, anton ivanov <anton.ivanov@cambridgegreys.com>, x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Dec 21, 2021 at 10:05:03PM +0100, Richard Weinberger wrote:
> So far UML seems to work with these changes applied. :-)
> I have applied both patches to my UML tree for now, I assume x86 maintainers are fine with
> patch 1/2?

Looks like patch 1 needs this fixup for some configurations, where
pci.h doesn't get pulled into kvm by other means.

But we probably want an ACK from the x86 maintainers to be sure anyway..

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 0c76c45fdb686..fad546df0bbac 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -16,6 +16,7 @@
 #include "spte.h"
 
 #include <asm/e820/api.h>
+#include <asm/memtype.h>
 #include <asm/vmx.h>
 
 static bool __read_mostly enable_mmio_caching = true;

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


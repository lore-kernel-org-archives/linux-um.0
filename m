Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNY8h-004Vpt-6w
 for linux-um@lists.infradead.org; Fri, 25 Feb 2022 10:47:56 +0000
Date: Fri, 25 Feb 2022 11:47:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] firmware: google: Properly state IOMEM dependency
Message-ID: <Yhiz1s35vfqC4S0v@kroah.com>
References: <20220225041502.1901806-1-davidgow@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220225041502.1901806-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>
Cc: Julius Werner <jwerner@chromium.org>, Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, anton ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Feb 25, 2022 at 12:15:02PM +0800, David Gow wrote:
> The Google Coreboot implementation requires IOMEM functions
> (memmremap, memunmap, devm_memremap), but does not specify this is its
> Kconfig. This results in build errors when HAS_IOMEM is not set, such as
> on some UML configurations:
> 
> /usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
> coreboot_table.c:(.text+0x311): undefined reference to `memremap'
> /usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
> memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
> /usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
> /usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
> vpd.c:(.text+0x300): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
> vpd.c:(.text+0x382): undefined reference to `memremap'
> /usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
> vpd.c:(.text+0x59d): undefined reference to `memremap'
> /usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
> collect2: error: ld returned 1 exit status
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>
> Acked-By: Julius Werner <jwerner@chromium.org>
> ---

What commit id does this fix?

thanks,

greg k-h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


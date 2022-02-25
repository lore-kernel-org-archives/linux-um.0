Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNPgh-002u0y-Ga
 for linux-um@lists.infradead.org; Fri, 25 Feb 2022 01:46:29 +0000
Received: by mail-wm1-x335.google.com with SMTP id
 az26-20020a05600c601a00b0037c078db59cso815366wmb.4
 for <linux-um@lists.infradead.org>; Thu, 24 Feb 2022 17:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20220224040136.1595119-1-davidgow@google.com>
 <c877cf8b-7dd0-9766-e4cb-123dba5075a3@cambridgegreys.com>
In-Reply-To: <c877cf8b-7dd0-9766-e4cb-123dba5075a3@cambridgegreys.com>
From: Julius Werner <jwerner@chromium.org>
Date: Thu, 24 Feb 2022 17:46:07 -0800
Message-ID: <CAODwPW8EyNr87ZMervpo0avoKpi+OvzOELrTgWV1S-1R1DSuwA@mail.gmail.com>
Subject: Re: [PATCH] firmware: google: Properly state IOMEM dependency
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: David Gow <davidgow@google.com>, Julius Werner <jwerner@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Hutchings <ben@decadent.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org

Acked-By: Julius Werner <jwerner@chromium.org>

On Thu, Feb 24, 2022 at 12:02 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 24/02/2022 04:01, David Gow wrote:
> > The Google Coreboot implementation requires IOMEM functions
> > (memmremap, memunmap, devm_memremap), but does not specify this is its
> > Kconfig. This results in build errors when IOMEM is not enabled, such as
> > on some UML configurations:
> >
> > /usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
> > coreboot_table.c:(.text+0x311): undefined reference to `memremap'
> > /usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
> > memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
> > /usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
> > /usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
> > vpd.c:(.text+0x300): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
> > vpd.c:(.text+0x382): undefined reference to `memremap'
> > /usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
> > vpd.c:(.text+0x59d): undefined reference to `memremap'
> > /usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
> > collect2: error: ld returned 1 exit status
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >   drivers/firmware/google/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> > index 931544c9f63d..7ac866a985c6 100644
> > --- a/drivers/firmware/google/Kconfig
> > +++ b/drivers/firmware/google/Kconfig
> > @@ -21,7 +21,7 @@ config GOOGLE_SMI
> >
> >   config GOOGLE_COREBOOT_TABLE
> >       tristate "Coreboot Table Access"
> > -     depends on ACPI || OF
> > +     depends on IOMEM && (ACPI || OF)
> >       help
> >         This option enables the coreboot_table module, which provides other
> >         firmware modules access to the coreboot table. The coreboot table
> >
> Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>
>
> --
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661
> https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


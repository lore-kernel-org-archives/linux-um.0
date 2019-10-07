MIME-Version: 1.0
Date: Mon, 7 Oct 2019 10:26:49 +0200
References: <20191004145544.5066-1-krzk@kernel.org>
	<20191004145544.5066-3-krzk@kernel.org>
In-Reply-To: <20191004145544.5066-3-krzk@kernel.org>
Message-ID: <CAMuHMdW0DSujexoGq4CJAYP40DvMcigk08aEnyQ72haY6jds5Q@mail.gmail.com>
Subject: Re: [RESEND TRIVIAL 3/3] treewide: arch: Fix Kconfig indentation
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jiri Kosina <trivial@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Openrisc <openrisc@lists.librecores.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, Linux-sh list <linux-sh@vger.kernel.org>, linux-um@lists.infradead.org, keyrings@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, dmaengine@vger.kernel.org, linux-edac@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, netdev <netdev@vger.kernel.org>, dm-devel@redhat.com, linux-raid@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, linux-rtc@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>, esc.storagedev@microsemi.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-spi <linux-spi@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, ac100@lists.launchpad.net, linux-tegra <linux-tegra@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, Linux MM <linux-mm@kvack.org>, linux-security-module@vger.kernel.org, linux-integrity <linux-integrity@vger.kernel.org>, linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Fri, Oct 4, 2019 at 4:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

>  arch/m68k/Kconfig.bus                  |  2 +-
>  arch/m68k/Kconfig.debug                | 16 ++++++++--------
>  arch/m68k/Kconfig.machine              |  8 ++++----

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


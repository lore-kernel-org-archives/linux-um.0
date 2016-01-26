Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 03/22] scsi: Fix dependencies for !HAS_IOMEM and !HAS_DMA
 archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-4-git-send-email-richard@nod.at>
From: John Garry <john.garry@huawei.com>
Message-ID: <56A74743.6000308@huawei.com>
Date: Tue, 26 Jan 2016 10:15:31 +0000
MIME-Version: 1.0
In-Reply-To: <1453760661-1444-4-git-send-email-richard@nod.at>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, "James E.J. Bottomley" <JBottomley@odin.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 25/01/2016 22:24, Richard Weinberger wrote:
> Not every arch has io or DMA memory.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   drivers/scsi/hisi_sas/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/hisi_sas/Kconfig b/drivers/scsi/hisi_sas/Kconfig
> index 37a0c71..f9157f4 100644
> --- a/drivers/scsi/hisi_sas/Kconfig
> +++ b/drivers/scsi/hisi_sas/Kconfig
> @@ -2,5 +2,6 @@ config SCSI_HISI_SAS
>   	tristate "HiSilicon SAS"
>   	select SCSI_SAS_LIBSAS
>   	select BLK_DEV_INTEGRITY
> +	depends on HAS_IOMEM && HAS_DMA
>   	help
>   		This driver supports HiSilicon's SAS HBA
>

I think that there is already a fix for depencencies from Geert:
http://git.kernel.org/cgit/linux/kernel/git/jejb/scsi.git/log/?h=fixes

Cheers,
John



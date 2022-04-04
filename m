Return-Path: <kvalo@kernel.org>
From: Kalle Valo <kvalo@kernel.org>
Subject: Re: Build regressions/improvements in v5.18-rc1
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
	<20220404074734.1092959-1-geert@linux-m68k.org>
	<alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
Date: Mon, 04 Apr 2022 21:39:15 +0300
In-Reply-To: <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg> (Geert
	Uytterhoeven's message of "Mon, 4 Apr 2022 10:16:08 +0200 (CEST)")
Message-ID: <874k38u20c.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>, linux-rdma@vger.kernel.org, linux-um@lists.infradead.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-xfs@vger.kernel.org, alsa-devel@alsa-project.org, linux-s390@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> /kisskb/src/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:
>> error: case label does not reduce to an integer constant: => 3798:2,
>> 3809:2
>
> arm64-gcc5.4/arm64-allmodconfig
> powerpc-gcc5/powerpc-allmodconfig
> powerpc-gcc5/ppc64_book3e_allmodconfig

After v5.17 there were two commits to brcmfmac/sdio.c:

$ git log --oneline v5.17.. drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
ed26edf7bfd9 brcmfmac: Add BCM43454/6 support
6d766d8cb505 brcmfmac: pcie: Declare missing firmware files in pcie.c

I can't see how either of them could cause this warning. Could something
else cause this or am I missing something?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <kvalo@kernel.org>
From: Kalle Valo <kvalo@kernel.org>
Subject: Re: Build regressions/improvements in v5.18-rc1
In-Reply-To: <CAMuHMdV_-3TOHYehUsHeqwHjQtzN1Ot886K7vwPr4P-4u8eehw@mail.gmail.com>
	(Geert Uytterhoeven's message of "Tue, 5 Apr 2022 08:46:06 +0200")
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
	<20220404074734.1092959-1-geert@linux-m68k.org>
	<alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
	<874k38u20c.fsf@tynnyri.adurom.net>
	<CAMuHMdV_-3TOHYehUsHeqwHjQtzN1Ot886K7vwPr4P-4u8eehw@mail.gmail.com>
Date: Tue, 05 Apr 2022 09:52:33 +0300
Message-ID: <87czhwrphq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>, linux-rdma <linux-rdma@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-xfs@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Mon, Apr 4, 2022 at 8:39 PM Kalle Valo <kvalo@kernel.org> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> >> /kisskb/src/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:
>> >> error: case label does not reduce to an integer constant: => 3798:2,
>> >> 3809:2
>> >
>> > arm64-gcc5.4/arm64-allmodconfig
>> > powerpc-gcc5/powerpc-allmodconfig
>> > powerpc-gcc5/ppc64_book3e_allmodconfig
>>
>> After v5.17 there were two commits to brcmfmac/sdio.c:
>>
>> $ git log --oneline v5.17.. drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> ed26edf7bfd9 brcmfmac: Add BCM43454/6 support
>> 6d766d8cb505 brcmfmac: pcie: Declare missing firmware files in pcie.c
>>
>> I can't see how either of them could cause this warning. Could something
>> else cause this or am I missing something?
>
> Doh, I should not have reduced the CC list in the xfs subthread...
>
> The builds above are all gcc-5 builds, so they are affected by the same
> issue as XFS: unsigned constants that don't fit in int are lacking a
> "U" suffix.
>
> I assume Arnd's patch for
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> fixes this?
> https://lore.kernel.org/all/CAK8P3a0wRiS03imdXk2WbGONkSSczEGdE-ue5ubF6UyyDE9dQg@mail.gmail.com

Great, thanks. I assume Arnd will submit it officially at some point.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


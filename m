Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6809C77B7C
	for <linux-um@archiver.kernel.org>; Wed,  2 Jul 2025 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilep2gaQ0OFsHrvPdaYZiXUCrraldT2TlF6XoPbWUiE=; b=saM9xBO5+5Ln6h9l0mu6/zmJT4
	4vOy0fbPXoVSEDR1QCQxKUs+7GrAALEuBPjA/fofKHwO+FMtcqkWFiDJjEVR9oAuBD/f0QRouvHxd
	yN6bX9qX9Ja1SF2N7wlPDsQ4T4Dx5/QB2qJkMBjrj8++10IbwXAuMIi1vgFaSXkp8LnDkB1yrazM0
	9Tw5ZI6FJNQQ715jXPAkZQxnzcnPe1Lo7sIC7E+7no1XzoZygM6pyoB/lXgsC+1V7Bkm7Di5Z9TAX
	UzucoFiggWw5xIP1FJZcEVFb17a+ZFK+smXR7WpElUxPJVnliToTyw0+19/zffKdSOTgMgRqe3tG9
	uaOzdChg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWzrn-00000008sLB-1lTi;
	Wed, 02 Jul 2025 15:59:23 +0000
Received: from out187-1.us.a.mail.aliyun.com ([47.90.187.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWyyf-00000008iv0-3ANh
	for linux-um@lists.infradead.org;
	Wed, 02 Jul 2025 15:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751468539; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ilep2gaQ0OFsHrvPdaYZiXUCrraldT2TlF6XoPbWUiE=;
	b=KorhMlKQJa3B9tMdWB2lREBoJ4Av94DN1f0P36wiYO1Q+qWLBZ/PCfX6SGh+Zpid2Zy/gzhpKiVHKkdHPKi1mADQW0HkIrY6hFo/A0+RCXIi3gDkY0Zk6LLp/LPlm+jKpD4WyAqbgHQtKgOy+0W8iblOgnDWxahkRudAKbB+5Vg=
Received: from 30.174.123.102(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dcKZk9f_1751468528 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 02 Jul 2025 23:02:15 +0800
Message-ID: <fc4e51e0-4ffc-42f0-a400-3d889ca749eb@antgroup.com>
Date: Wed, 02 Jul 2025 23:02:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Turn HAS_IOPORT_MAP off
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 kernel test robot <lkp@intel.com>
References: <20250628164740.353989-1-tiwei.btw@antgroup.com>
 <CAMuHMdUa1D3mLtNfOhE9RB7uWyf765-9kiQzG5ku05zz2f+zjw@mail.gmail.com>
 <e7d95c03-5098-401e-b885-1569822cdd0e@app.fastmail.com>
 <c71581d8-350f-4523-862f-5be84358ad8f@antgroup.com>
 <1724be1e-174c-4837-8768-83a90004f7fe@app.fastmail.com>
 <dcb0d307-a0cf-480e-888f-1020d1441d1d@antgroup.com>
 <49982e79-957d-401b-882c-849d2892bf4c@app.fastmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <49982e79-957d-401b-882c-849d2892bf4c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_080226_417302_56ED5928 
X-CRM114-Status: GOOD (  13.74  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 2025/7/2 21:39, Arnd Bergmann wrote:
> On Wed, Jul 2, 2025, at 15:02, Tiwei Bie wrote:
>> On 2025/7/2 19:09, Arnd Bergmann wrote:
>>> On Tue, Jul 1, 2025, at 14:22, Tiwei Bie wrote:
>>> xtensa selects NO_IOPORT_MAP, which means that HAS_IOPORT_MAP
>>> gets disabled here:
>>>
>>> arch/xtensa/Kconfig:config NO_IOPORT_MAP
>>> arch/xtensa/Kconfig-    def_bool n
>>
>> The value of NO_IOPORT_MAP on xtensa is inverted compared to that
>> on most other platforms that explicitly defines NO_IOPORT_MAP.
> 
> Ah of course, sorry for misunderstanding. Apparently this only
> existed because it was selected by a long gone platform:
> 
> -config XTENSA_PLATFORM_S6105
> -       bool "S6105"
> -       select HAVE_IDE
> -       select SERIAL_CONSOLE
> -       select NO_IOPORT_MAP

Cool, that makes sense!

> 
> Before commits
> 
> d38efc1f150f ("xtensa: adopt generic io routines")
> d046f77ec4a4 ("xtensa: set NO_IOPORT to 'n' by default")
> 
> it was always-on, and I think the idea at the time was to
> make it behave more like the generic PCI code, while it
> was originally copied from sparc, which does things quite
> differently.
> 
> It is rather clear that the I/O port implementation on
> xtensa never actually worked, and some of the comments
> on its PCI code suggest that it was never really used
> either.

Thanks for the details. I'm not really familiar with xtensa;
my understanding comes merely from reading the code. Please
feel free to proceed with your patch. I also think it is a
more generic solution. :)

Regards,
Tiwei



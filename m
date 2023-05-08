Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8211AC77B7F
	for <linux-um@archiver.kernel.org>; Mon,  8 May 2023 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xde7OgWffM4FE3muwEsZXEk9VPgFJlTvzO9FV11o8Es=; b=bX2JPOC5ZdgApV
	on5BKL67bjprWx1fnGZFCSg7qMOTuersplzPgE2/56znhH+89d7hTdM3/Tr7VYsSRDicREDsVy+Nm
	fWahShLWERC0X1Ixs45S63cQmXzKe6S6wp8CJHw9EVgxeq8sU0OUycV2q/705JpXuOiIm2KlxDOy4
	tt6Gk9T9WGNMq5EXnNw3c5+iFNbhSEOdJ03QhKgeTcBeF1L3IAm1IvFpJdc3+C0lGfLzNV0qESIm+
	ioO7xqcVFm68KScGanVibf7IyKAioLKHcKYJmSFEqxDingo4EPrL9hxpOZ7qJm818dU5rpF3m4DxG
	5MUNObnTW/EAiY73qFjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pw35A-000tLA-0c;
	Mon, 08 May 2023 15:47:24 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pw358-000tKW-0B;
	Mon, 08 May 2023 15:47:23 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 348Fl3jg054523;
	Mon, 8 May 2023 10:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1683560823;
	bh=ThTMpPXBEPh4HdHzswHAKDf5fokfeMb5MpOdHcvdqgE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cAwMBQtt+9p61ybgcF82DbpMQgD20dsGzxfdQiMdlKtBtnVK2UXR045dEAVRh0lw2
	 sTOwAqMYxGlLQJ385l3l0Bl8nRyL358LToNs2y2d5uPVKZa1Lk3e+hQ4572pQfyh7L
	 0GnxlXQCzr1YRXEg2m0XQFvatQYp7I0Uu4DaPNUU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 348Fl3t3121784
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 May 2023 10:47:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 May 2023 10:47:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 May 2023 10:47:03 -0500
Received: from [10.250.149.252] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 348FkvEU003096;
	Mon, 8 May 2023 10:46:58 -0500
Message-ID: <a80f540a-492a-0585-9ed1-de3397535e07@ti.com>
Date: Mon, 8 May 2023 21:16:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Build regressions/improvements in v6.4-rc1
Content-Language: en-US
To: Pratyush Yadav <pratyush@kernel.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Richard Weinberger
	<richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes
 Berg <johannes@sipsolutions.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-um@lists.infradead.org>, <linux-media@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-phy@lists.infradead.org>,
        <sparclinux@vger.kernel.org>
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
 <20230508115727.2597864-1-geert@linux-m68k.org>
 <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
 <mafs035466ebk.fsf@amazon.de>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <mafs035466ebk.fsf@amazon.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_084722_193721_D5859E81 
X-CRM114-Status: GOOD (  15.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 5/8/2023 8:49 PM, Pratyush Yadav wrote:
> On Mon, May 08 2023, Geert Uytterhoeven wrote:
> 
>> On Mon, 8 May 2023, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v6.4-rc1[1] compared to v6.3[2].
>>>
>>> Summarized:
>>>  - build errors: +9/-16
>>>  - build warnings: +1/-1439
>>>
>>> Happy fixing! ;-)
>>>
>>> Thanks to the linux-next team for providing the build service.
>>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ac9a78681b921877518763ba0e89202254349d1b/ (all 152 configs)
>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/457391b0380335d5e9a5babdec90ac53928b23b4/ (all 152 configs)
>>>
>>>
> [...]
>>
>>>  + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27
> 
> Hmm, I don't get why we get this warning. Line 495 is in
> s25fs256t_post_bfpt_fixup(). It declares 'op' and then it does
> 
>     op = (struct spi_mem_op)
>         CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
>                       SPINOR_REG_CYPRESS_ARCFN, 1,
>                       nor->bouncebuf);
>     ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
> 

Not all the fields of struct get initialized if you assign later on in
the function vs at the time of declaration... For example cmd.dtr isn't
explicitly set to any value here and may have garbage?
> 
> which initializes 'op' before using it. Same with line 364 which is in
> the function cypress_nor_set_addr_mode_nbytes().
> 
> Even the compiler warnings [0] don't seem to make much sense to me:
> 
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c: In function 's25fs256t_post_bfpt_fixup':
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: error: 'op' is used uninitialized [-Werror=uninitialized]
>     495 |         struct spi_mem_op op;
>         |                           ^~
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: note: 'op' declared here
>     495 |         struct spi_mem_op op;
>         |                           ^~
> 
> [0] http://kisskb.ellerman.id.au/kisskb/buildresult/14922057/
> 
>>
>> um-x86_64-gcc12/um-allyesconfig
>>
> [...]
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

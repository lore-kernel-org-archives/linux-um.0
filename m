Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6340C4332F
	for <linux-um@archiver.kernel.org>; Wed,  4 Jan 2023 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=djhkkOMZRw4VtBuEnFgr0DVO2M87COifDZsHic4BQUQ=; b=JcgUgfCH49miry
	aflHPm3DHLbesBHAegvqFx2zGUrb2v+UQ65J0M7wfPLhkTozAP2iJrw101/ypnNL7lV0hcTXQpT8y
	qZwVoLg7raSQp7c9cmjW5l+YRtIs2QPaq5qQv3UehOlYdUQcfJeqDn5yfDm5M5TbFNsE6ef/dxoJN
	Y1vQtz8+JwUPsEWMqar9wb5SIIwCQY2Bgj1Ks4pIvmmHyyWknMeAF4Lo6h064hnFKGkUfiJiBr3iU
	/7hqJZbqtKQ1ELmVrnb/MViYKHd9EpbZ4fDI0s+LLv33VTxEpz2SGTFaXVUBgQjjZA34/4xUty4GJ
	FGXlmez8ICYKkDNDgxUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD0vv-008Ms6-F0; Wed, 04 Jan 2023 10:23:43 +0000
Received: from mail-qt1-f176.google.com ([209.85.160.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD0q2-008Ld4-OA
	for linux-um@lists.infradead.org; Wed, 04 Jan 2023 10:17:40 +0000
Received: by mail-qt1-f176.google.com with SMTP id jr11so26821414qtb.7
        for <linux-um@lists.infradead.org>; Wed, 04 Jan 2023 02:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUwAn0nEqMKSXDK8OVReUF5AGlB7lvlwoglxNqDeTrQ=;
        b=T241mDj1fywya1iF/X1LnGmtVaytwqun3RXNVIx21hSS1Rp7C1pcHxbONggnOcqJ80
         CYmOObx4KRj/mtkQ9UayIm8K4n7xzdMPDy65h/BFRnJ4RRKyqZ62PDQMF5/CWrp2Kgp8
         JVXfFDUwo0N5JcqCbZ/UgXQ/FT+JmYRnUPjP4Qvmf2Yz8qUaEoIzEsmalyD5H0lP8t88
         FFP4X/Snx4NJ+Zk+dyHH2SsOCFQbX4bgecNg4dsRIC/YGNeqvJGPt8RiiZGdj8HnEIEm
         wmPY1hhn+1kbF/CfrQjeLwzKDDTTa3RQBbRUwd7b51/Yct0yEeD262lwV6yUgG4msBDi
         TM1A==
X-Gm-Message-State: AFqh2komcJPVL5JLj2BQh6j7N2kznLla8WBGhQCvudpQrFI/qsyS5V8S
	dZyugwIsl1//p50jKsv7uH+uaqBDg2QmXA==
X-Google-Smtp-Source: AMrXdXsP4VfUxojMLVPTJwOaxa4wScUGbTjJFYd8c6WH1a1B35EXsxbxZ09kzPkW4hwnpZixPZx37w==
X-Received: by 2002:a05:622a:1e1b:b0:3a7:f9a3:b86b with SMTP id br27-20020a05622a1e1b00b003a7f9a3b86bmr78476334qtb.13.1672827455318;
        Wed, 04 Jan 2023 02:17:35 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id cb20-20020a05622a1f9400b003ab5d6cd6c5sm19793937qtb.16.2023.01.04.02.17.34
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 02:17:34 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id l139so1673215ybl.12
        for <linux-um@lists.infradead.org>; Wed, 04 Jan 2023 02:17:34 -0800 (PST)
X-Received: by 2002:a25:aae1:0:b0:6fc:1c96:c9fe with SMTP id
 t88-20020a25aae1000000b006fc1c96c9femr6122796ybi.36.1672827454676; Wed, 04
 Jan 2023 02:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20230104081408.4074275-1-linmq006@gmail.com>
In-Reply-To: <20230104081408.4074275-1-linmq006@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Jan 2023 11:17:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAUX-nht=erTjycx617gDin8eiZRb55ry4idN37umPnQ@mail.gmail.com>
Message-ID: <CAMuHMdXAUX-nht=erTjycx617gDin8eiZRb55ry4idN37umPnQ@mail.gmail.com>
Subject: Re: [PATCH v2] um: vector: Fix memory leak in vector_config
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_021738_845229_0AD036E6 
X-CRM114-Status: GOOD (  18.25  )
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

On Wed, Jan 4, 2023 at 9:18 AM Miaoqian Lin <linmq006@gmail.com> wrote:
> kstrdup() return newly allocated copy of the string.
> Call kfree() to release the memory when uml_parse_vector_ifspec() fails.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - only call kfree() when uml_parse_vector_ifspec() fails.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

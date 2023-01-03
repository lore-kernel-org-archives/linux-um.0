Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DADC3DA7D
	for <linux-um@archiver.kernel.org>; Tue,  3 Jan 2023 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=80VPbK/2JYfQWCVMYpE6iLYos7A9xLmaOf7xKLB4lJE=; b=V/MZqdjh6nWZqf
	yQEHIsS++TBHQsI7aBwnjVJrfRHZ+xFR+cLULQHRkYCZF45KptSdx5PnbXVvKcGiDdfwun6nmHKSA
	fciCiqX2AN9ExDl7WuAO3ppRipleJA6m4dckvu9uWZIfsgifO93CgiKiZfNmz40XEB6LKaxLj+dA4
	rkwAlL+suO2rOQD0RyIyNuHfljOpmFJ2a9DBCvBTQgYbqOK7ehE2TzlT2I+rHppIcAZFWQR8+iIHX
	TNUwKw4Lo+KtQIXQEacs9v7JZTXAAaZYQkNKsEU4/ZTkpw5mE+/12rD+PkDuEWTPrPjO2vQyHl94M
	w5aUa2L4bLvHFAFky6bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCgLC-001CBX-RS; Tue, 03 Jan 2023 12:24:26 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCf43-000sWN-D5
	for linux-um@lists.infradead.org; Tue, 03 Jan 2023 11:02:42 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pCeXF-005C2N-6D; Tue, 03 Jan 2023 10:28:45 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1pCeXB-004VNL-Fn; Tue, 03 Jan 2023 10:28:44 +0000
Message-ID: <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com>
Date: Tue, 3 Jan 2023 10:28:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Miaoqian Lin <linmq006@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221229075323.1394010-1-linmq006@gmail.com>
 <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_030239_754007_5FBAC2AE 
X-CRM114-Status: GOOD (  22.81  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


On 03/01/2023 08:00, Geert Uytterhoeven wrote:
> Hi Miaoqian,
>
> On Thu, Dec 29, 2022 at 8:53 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>> kstrdup() return newly allocated copy of the string.
>> Call kfree() to release the memory when after use.
>>
>> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Thanks for your patch!
>
>> --- a/arch/um/drivers/vector_kern.c
>> +++ b/arch/um/drivers/vector_kern.c
>> @@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
>>
>>          parsed = uml_parse_vector_ifspec(params);
>>
>> +       kfree(params);
> Are you sure the memory pointed to by "params" is no longer used?
> "parsed" seems to contain pointers pointing to (parts of) the string
> pointed to by "params", so it cannot be freed.

+1.

I was just about to send the same comment.

>
>>          if (parsed == NULL) {
>>                  *error_out = "vector_config failed to parse parameters";
>>                  return -EINVAL;
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

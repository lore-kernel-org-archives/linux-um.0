Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3753DCFD2E0
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 08:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MtOXo2p9/XIZHu8Zkzqckg+RKXCzEUbnXFSl6QpaOnc=; b=HEfeOuZ8BChoNxI+r6nHCiJKB5
	oVP3PlhFX1o2el1MH7ag9WKXMObOg6PyEAqVXIBrFqnVxK1DQR88aO4ksIvWtcKdsJ5C00KeEws5W
	RlxqkniDfSTYm0djTqWh0afQJNBvM+mRe3lwDZmOiNA9rp0tJVpilzpvCxtmW0Yvz4zFWhs3mzoG9
	MpIOusFESO1KFBpKIOSUmxxmFJxyzFgcer0lThK2ld7JUXEyADfmzd0+YSqqRQwO65jcaIA2o7Y6Q
	xlBF0XXgGGGrpd7ABXpB8k+AYO/Byasr9e8YOjXZ0Ys4UUVdmwnf5hzE5A1Nk/eVw8C7NpurJdexA
	/N7YV29w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBNA-0000000FjjK-3m2a;
	Fri, 11 Oct 2024 08:51:44 +0000
Received: from out0-204.mail.aliyun.com ([140.205.0.204])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBN7-0000000Fjj1-0oIY
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 08:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728636697; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MtOXo2p9/XIZHu8Zkzqckg+RKXCzEUbnXFSl6QpaOnc=;
	b=kBScQIdFrkoX0KjBV0AnpdfJPrFvxu9YiUDNbL2BwePeMDGTvQFUW9Rj9sIBJ8PykZuRiZ6c06KanH2uAxabITHEANDZv39AyLnDGZ1u6Q97hEwOb17t6MrcCycdhbzhza2Afu4UeLWWh1PPZncnOM4llwKEad1yy/BXmDyqwBk=
Received: from 30.121.32.252(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeRJfab_1728636688 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 16:51:35 +0800
Message-ID: <5f129f05-1d50-4076-aae6-99638dce35b9@antgroup.com>
Date: Fri, 11 Oct 2024 16:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
 <99d9e95fcb27160da5ff931fcfe16a07b3256574.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <99d9e95fcb27160da5ff931fcfe16a07b3256574.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_015141_731822_F88774FF 
X-CRM114-Status: UNSURE (   7.13  )
X-CRM114-Notice: Please train this message.
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

Hi Johannes,

On 2024/10/11 15:38, Johannes Berg wrote:
> Hi Tiwei,
> 
> So kind of a nit, but if the resulting code looks like this:
> 
>> @@ -184,17 +172,14 @@ static inline pte_t pte_wrprotect(pte_t pte)
>>  {
>>  	if (likely(pte_get_bits(pte, _PAGE_RW)))
>>  		pte_clear_bits(pte, _PAGE_RW);
>> 	return pte;
>>  }
> 
> then the if really isn't needed?
> 
> Same for all the others, I guess.

Makes sense. It looks a bit odd. Will drop the if. Thanks for the review!

Regards,
Tiwei

> 
> johannes



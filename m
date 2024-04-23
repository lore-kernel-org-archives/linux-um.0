Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94726C4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGpCGDLM61ejMNOyLJt8CjD5GKhvUW/9uVClM+cy3Nw=; b=VeM0S/y7EDeSjpzcZclr7KBzXz
	ailpLh9QDfb32Cjqko5ZPCPOiXKCLIJb5vxpMksnYHmxgdUd5l3wyCV9d3VW0xNE7OkNGj3+jcrH2
	L76a+CVWorS9sk5zi4gkz1qXzPhJi3ayV8Mbq+vHgL/ryMTNEliJIDNIBBjz3RvmJp/53o+gGKir/
	pa9Pc/WSvUkFcDKxgra3z7ZIhql9L5PBhtaXQoHPZmDEzPzozGGh1ZzTVEyYJGD/lVKwtsoIfCo7K
	ZonIcfCW0wxmQHvOtBnHsmiC1SSuf5d2Xlmjob+yTKj/hoFa2EEI++VGTDimIxsQstzKxjWJay/iZ
	LwuTJBpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEzb-0000000HK7P-1FFs;
	Tue, 23 Apr 2024 12:11:23 +0000
Received: from out0-196.mail.aliyun.com ([140.205.0.196])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEzX-0000000HK51-058M
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:11:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713874277; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zGpCGDLM61ejMNOyLJt8CjD5GKhvUW/9uVClM+cy3Nw=;
	b=qv4GEanAMxzYxWuOm1HrZtKbkEqwv7HERJTHVgAy+hV/vhLR1cSas3/LVrlGp6n/MIZeuK0JzkgG+Vl6oeHRMWeMqYswELtB5jPH1ebLA/gwh8SowmkyhILVwSTh6qFm5OUirJnIlFaIZcH1eqxg1OqBM92A/JsPUrA+oFXA1jw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.XJXNWHL_1713874275;
Received: from 30.230.91.3(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNWHL_1713874275)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:11:16 +0800
Message-ID: <c2d61760-ca89-49d0-b366-89b3cd76438f@antgroup.com>
Date: Tue, 23 Apr 2024 20:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] um: Fix the -Wmissing-prototypes warning for
 __switch_mm
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
 <20240423112457.2409319-3-tiwei.btw@antgroup.com>
 <8134c423c1a7f911cb5ae2f2e8e40e80f2e5270f.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <8134c423c1a7f911cb5ae2f2e8e40e80f2e5270f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_051119_727588_60F46ADB 
X-CRM114-Status: UNSURE (   5.09  )
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

On 4/23/24 7:29 PM, Johannes Berg wrote:
> On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>>
>> --- a/arch/um/include/shared/skas/mm_id.h
>> +++ b/arch/um/include/shared/skas/mm_id.h
>> @@ -15,4 +15,6 @@ struct mm_id {
>>  	int kill;
>>  };
>>  
>> +extern void __switch_mm(struct mm_id *mm_idp);
>>
> 
> Maybe drop the extern while at it?

Sure, will do. I also prefer to drop the extern.
Thanks for the review! :)

Regards,
Tiwei


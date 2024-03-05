Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6B2C54E49
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HIGWyWFKm21LUWNRDQwApvt+mnlPgIrdOOiTsdeUyp8=; b=M/z0RruFqwWffGI889l05AfMuM
	tvbJ7nV45SjFKbSK6d8opzaYVe65uqTfLLGajjRLcEU7fv0U7FJ1C3Jwziza0cFLKppeOs1RGyd7y
	Mstdjl0ARsTQMgYtI6m2SPXHhaothjS9c4HBZKZUSoYwauupOPp2gcUq1yhJ3r2Sb0KmnVz2JOvas
	KrJC5aYiu2pq/JRZTaO5zjQWwkKAbVZ86OIxRKhxm7GBQDBKhxfIc3GYqi93cDAGI13DygGJzBCfM
	BVePf6dK9iBbDbvZtNg4eCIIQXKsHQkBXYDQn//IWyWKW2yX+j9seo7eFY6qVVnyodHyuu/Cgg2d4
	4KmEtZ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSpE-0000000DIca-3zL1;
	Tue, 05 Mar 2024 11:19:12 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSpA-0000000DIUo-1FzF
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 11:19:10 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.WfsbWle_1709637532;
Received: from 30.230.19.235(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WfsbWle_1709637532)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 19:18:58 +0800
Message-ID: <9d297bf5-4f54-431b-ab8d-c5be825f129e@antgroup.com>
Date: Tue, 05 Mar 2024 19:18:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -Wmissing-prototypes warnings in user-mode linux
Content-Language: en-US
To: Jani Nikula <jani.nikula@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: intel-xe@lists.freedesktop.org, Lucas De Marchi <lucas.demarchi@intel.com>
References: <87jzmh2chs.fsf@intel.com>
 <5d1dfb9fce5d7647ff3203080416eadc9806059a.camel@sipsolutions.net>
 <87frx52btl.fsf@intel.com>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <87frx52btl.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_031908_542612_DE15EB73 
X-CRM114-Status: GOOD (  14.45  )
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

On 3/5/24 6:49 PM, Jani Nikula wrote:
> On Tue, 05 Mar 2024, Johannes Berg <johannes@sipsolutions.net> wrote:
>> On Tue, 2024-03-05 at 12:34 +0200, Jani Nikula wrote:
>>> We're seeing a lot of -Wmissing-prototypes warnings when building
>>> user-mode Linux. For example, our CI hits things like [1], and it's just
>>> extra noise in the build.
>>
>> Yeah ...
>>
>>> I started adding some prototypes, but I lost my way around the arch/
>>> subdirectory a bit. I'm not always quite sure what should or could be
>>> included where, or whether a new header should be added instead, etc.,
>>> so it wasn't going as quickly as I'd hoped.
>>>
>>> Do you perhaps already have plans or, better yet, patches to address
>>> this? Feels like it should be fairly quick for someone familiar with the
>>> arch/um codebase.
>>
>> I think this series addressed most already?
>>
>> https://patchwork.ozlabs.org/project/linux-um/list/?series=393619
>>
>> But I haven't checked myself yet.
> 
> Oh, nice, it certainly helps!
> 
> But after applying that in my branch, I do still get a bunch of
> warnings.

Thanks for raising this topic!                            
                                                              
Indeed. To make it easier to review, the current series only addressed
the -Wmissing-prototypes warnings that can be fixed straightforwardly (e.g.
by turning into static functions or including missing headers). The remaining 
-Wmissing-prototypes warnings mainly fall into the following categories:

- Symbols defined and used in os-Linux/;                
- Symbols defined in os-Linux/, but declared in kernel headers;
- Symbols defined in individual files and not called explicitly;

My plan was to fix the remaining warnings in followup series. Ultimately,
I wish we can let cc treat -Wmissing-prototypes warnings as errors.

Regards,
Tiwei


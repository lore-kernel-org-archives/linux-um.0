Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686DFC54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUzc2o0T7NINwOmyKphINa1WTIwlQYfERfp0LCVwbw0=; b=ELD25VB1cMMvpl2EcfYB3Fp+Nq
	OGpRnUNhHMJfW476s6dkFGTawh3PshR0AEBGBJQS5EYuxmPWQ2OC7ga18kv6mUTX+j2b/aWQUXikZ
	3zRMGAFZlYn/xejs2GasKcNMCksZzp+vqQFwD1WIGWz5VCcf6HGVdeR/4HreyIfzlQfRj+FUdoYw0
	Gr18ew6bOyjQUHk2WczOCjpbJ7gnKjOgVbmnxhYJgogm7KXXd2/zJRC49Wx1nW/ilW4/b3Xx747XF
	jQRL2gvAv2DlE/z8kHhk3UYdkI0Eac+Fdu3+IAtjAkEbkxnwPE9SO9WbtQRp8XpRjWzSZdApOZ/xO
	LFd8hK7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVl4-0000000E1cV-17RH;
	Tue, 05 Mar 2024 14:27:06 +0000
Received: from out0-193.mail.aliyun.com ([140.205.0.193])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVl0-0000000E1Z5-2xSM
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 14:27:05 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.WfwGJqM_1709648800;
Received: from 30.121.51.238(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WfwGJqM_1709648800)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 22:26:54 +0800
Message-ID: <496c61e9-0f0a-41d1-ac3c-61992b3f0b96@antgroup.com>
Date: Tue, 05 Mar 2024 22:26:39 +0800
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
 <9d297bf5-4f54-431b-ab8d-c5be825f129e@antgroup.com>
 <87y1aw23n3.fsf@intel.com>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <87y1aw23n3.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_062703_192757_A93CA2DB 
X-CRM114-Status: GOOD (  10.62  )
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

On 3/5/24 9:45 PM, Jani Nikula wrote:
> On Tue, 05 Mar 2024, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
>> Thanks for raising this topic!                            
>>                                                               
>> Indeed. To make it easier to review, the current series only addressed
>> the -Wmissing-prototypes warnings that can be fixed straightforwardly (e.g.
>> by turning into static functions or including missing headers). The remaining 
>> -Wmissing-prototypes warnings mainly fall into the following categories:
>>
>> - Symbols defined and used in os-Linux/;                
>> - Symbols defined in os-Linux/, but declared in kernel headers;
>> - Symbols defined in individual files and not called explicitly;
>>
>> My plan was to fix the remaining warnings in followup series. Ultimately,
>> I wish we can let cc treat -Wmissing-prototypes warnings as errors.
> 
> Yay! That's good to hear.
> 
> If you want to get build testing from our CI, using our configs, please
> just Cc: intel-xe@lists.freedesktop.org when sending the patches. You'll
> get the results in reply.

Cool. Will Cc the list in the future. Thanks! :)

Regards,
Tiwei


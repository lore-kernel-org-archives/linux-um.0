Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58503C54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JpOtNh0MmSkAvHt3A4G+bPxeYauGr3Df/25TJPebuaQ=; b=rBYKmD0zuiD4qFa3B9ZVID+J4j
	gWbbbiuIM0QwAZhg93nhozXObzARQJeThmlQQA5af7n8g3ZzVF9xJMrp5y+iQ+ZwTnHkLEv4sEsom
	9yDIC6Uz7UW5kSs4Ca/CSga8tkY4aMxQFRJsJO8UyCWSnPZcDVTrPElXIdhJlKvIj9Wg2TOg8qfxC
	+vKM20kxS6IHFLjJDrvCb6V+yQlmBpNQfBYyYtd2ovDHAGF0J/VRfR/cCVHg5VRdTKb1SXb0Agb0h
	zGWpvCvJ6DMAyb3DjFV6Mo8+K3Z7eI2SfTu0TS4pwzmTE6az0Hy9LikklfoNhB/MILeTVIE+rYnv3
	DJU2oojg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8NH-0000000540v-1bZl;
	Tue, 26 Mar 2024 15:06:03 +0000
Received: from out0-219.mail.aliyun.com ([140.205.0.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8ND-000000053zC-209I
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 15:06:01 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.WwaCo0e_1711465550;
Received: from 30.39.128.129(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WwaCo0e_1711465550)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 23:05:51 +0800
Message-ID: <28a3e497-87b7-42ab-8724-2c49594bb4a5@antgroup.com>
Date: Tue, 26 Mar 2024 23:05:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] um: Fix -Wmissing-prototypes warnings for
 text_poke*
Content-Language: en-US
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, jani.nikula@intel.com,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
 <20240306101925.1088870-9-tiwei.btw@antgroup.com>
 <tvkjne4liqm3xx64jtkvqhlvvkwmiwlavif7gdh47xlzeltyp5@ymlqsvkdbppr>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <tvkjne4liqm3xx64jtkvqhlvvkwmiwlavif7gdh47xlzeltyp5@ymlqsvkdbppr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_080559_837073_4EB6B6F8 
X-CRM114-Status: GOOD (  12.05  )
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

On 3/26/24 10:13 PM, Lucas De Marchi wrote:
> On Wed, Mar 06, 2024 at 06:19:24PM +0800, Tiwei Bie wrote:
>> The prototypes for text_poke* are declared in asm/text-patching.h
>> under arch/x86/include/. It's safe to include this header, as it's
>> UML-aware (by checking CONFIG_UML_X86).
> 
> but would it work when building on something other than x86? Or is that
> not a thing?

I think it doesn't matter, because uml is x86 only (i.e. uml only supports
x86 currently). And that's how uml works currently. I described the specific
header file to be included in the commit log just to make the changes easier
to review.

PS. The header is included via below search path set in arch/um/Makefile:

HEADER_ARCH     := $(SUBARCH)

ifneq ($(filter $(SUBARCH),x86 x86_64 i386),)
        HEADER_ARCH := x86 
endif
......
HOST_DIR := arch/$(HEADER_ARCH)
......
KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
                   -I$(srctree)/$(HOST_DIR)/include/uapi \
                   -I$(objtree)/$(HOST_DIR)/include/generated \
                   -I$(objtree)/$(HOST_DIR)/include/generated/uapi

Regards,
Tiwei

> 
> Lucas De Marchi
> 
>>
>> This will address below -Wmissing-prototypes warnings:
>>
>> arch/um/kernel/um_arch.c:461:7: warning: no previous prototype for ‘text_poke’ [-Wmissing-prototypes]
>> arch/um/kernel/um_arch.c:473:6: warning: no previous prototype for ‘text_poke_sync’ [-Wmissing-prototypes]
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---
>> arch/um/kernel/um_arch.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
>> index 7a9820797eae..e95f805e5004 100644
>> --- a/arch/um/kernel/um_arch.c
>> +++ b/arch/um/kernel/um_arch.c
>> @@ -23,6 +23,7 @@
>> #include <asm/cpufeature.h>
>> #include <asm/sections.h>
>> #include <asm/setup.h>
>> +#include <asm/text-patching.h>
>> #include <as-layout.h>
>> #include <arch.h>
>> #include <init.h>
>> -- 
>> 2.34.1
>>



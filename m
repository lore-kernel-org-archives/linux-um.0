Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6888CC4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wTjKYtAEHOduKI0XEVExYwKYYYwxDyq717ZSUBWZezY=; b=J32X2BVdoRiKEsct9JaHFgJgeh
	ysqVmFGCVJqfesyJr6A4VBz6duC8OExbauJkKMI59rhORa5smMT+WTpPgtTSj7wxIuTCUpRSFXkF5
	iTJ6vO8J9WW7b4bcxw3FpZLB2kEW6VvawhKPvZ+t5lI8G3OGIyDCcT/JiTdnd2dnCj9gsxTyF47Is
	2SO2LqcXgVYlrdLMx01BFIhl1/NahgKbe1I/DK/3GaS7Dfquv0v+e0I+mcChxDpiyYjq3EYt+B3Xz
	qK0/ToFbTU4GPrj2ctcxMcI+p5i2DdzZEvIacozpGYkcO9Smv67cB9FE0sd7I/rFhIusEJ1RabUqO
	V8ynh6Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFHn-0000000HNwW-1klb;
	Tue, 23 Apr 2024 12:30:11 +0000
Received: from out0-199.mail.aliyun.com ([140.205.0.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFHi-0000000HNtG-2JNw
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713875396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wTjKYtAEHOduKI0XEVExYwKYYYwxDyq717ZSUBWZezY=;
	b=whZat2hHYEm71LsbpPCYqDUGwzig8xGB/tMO7TZr6MT2TU1xQa4+q/D7dWc7Zhn7tSpV4hm8kJ2y1eFj90UJRmCRD9mirz03PzKe8OhOTThfDD5DYUYZU96PwMCjIytZdYK3dCcyiembRGHok+ZKRndRj20pB7yUIokCoYBzZlM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.XJWNeVg_1713875393;
Received: from 30.230.91.3(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJWNeVg_1713875393)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:29:53 +0800
Message-ID: <3ce6a032-1bcd-47d2-86fb-0b33c541508d@antgroup.com>
Date: Tue, 23 Apr 2024 20:29:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] um: Add an internal header shared among the user code
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
 <20240423112457.2409319-6-tiwei.btw@antgroup.com>
 <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
 <ee636701-3f92-4424-8b04-dd2cecd8313a@antgroup.com>
 <21cd05c895abc4f4e66190b26632543ff7990b32.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <21cd05c895abc4f4e66190b26632543ff7990b32.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_053007_360221_831E2410 
X-CRM114-Status: GOOD (  12.29  )
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

On 4/23/24 8:22 PM, Johannes Berg wrote:
> On Tue, 2024-04-23 at 20:09 +0800, Tiwei Bie wrote:
>> On 4/23/24 7:30 PM, Johannes Berg wrote:
>>> On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>>>>
>>>>  $(USER_OBJS:.o=.%): \
>>>> -	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
>>>> +	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h \
>>>> +		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(CFLAGS_$(basetarget).o)
>>>>
>>>
>>> Why not just include it explicitly?
>>
>> I think it might be more convenient if we include it implicitly,
>> especially since there are two levels of directories under os-Linux/.
>> But I don't have a strong opinion on this. I'm also willing to
>> include it explicitly.
> 
> Yeah, ok, dunno.
> 
>>> We do have the warnings?
>>
>> Yeah. Without this patch, I can get below warnings with `make ARCH=um defconfig && make ARCH=um`:
>>
> 
> Sure. I meant, we don't need to hide the include, if we need to add it
> to some other file, we'll have the warnings as a reminder. :)
> 
> I don't think anyone today would write the code as it is now ...

Makes sense. Will include it explicitly. Thanks!

Regards,
Tiwei


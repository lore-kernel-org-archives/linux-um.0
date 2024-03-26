Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6516C54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40q98yBWD7xSonO0NjX37rwqaQ+PXA3Wuqyv7TRfrXM=; b=l4gDANc9KnmJnKMqSoZcUTncUW
	4bvT/2ocxguarFvUdPonQfHuY0JUp+YfZn5gTgZSiKIsgTA4gvnLko8TiTjOncqxYiyzsGa7bgzRm
	qV60a2NuaNWU0NrloDYDLpPZ1HedF5nh7NS9qdSEG/tLccAg1H65g1GWdMWhrvRrad1pmJrNQqYNw
	4iVZSNwh2bLM0PFAAhVqaEIwKR5O77LJgEs2QK5DBN80mA2N1udPbvftSInQpLPGpzhfzwJI9oodu
	XfgYqYjHNoQIx52KudS+XeGTdvL7zahzLvn7A+zdaMhYSFq63inNPK4Z/VDF9eDUJJ7GYZOytJR7a
	BhOWrHog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8OX-000000054So-0Gp3;
	Tue, 26 Mar 2024 15:07:21 +0000
Received: from out0-205.mail.aliyun.com ([140.205.0.205])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8OS-000000054R3-2Wb8
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 15:07:20 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.WwaCo0l_1711465551;
Received: from 30.39.128.129(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WwaCo0l_1711465551)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 23:07:11 +0800
Message-ID: <9e396277-f742-41d7-be82-290c0b2368d2@antgroup.com>
Date: Tue, 26 Mar 2024 23:07:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] um: Minor fixes and cleanups
Content-Language: en-US
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, jani.nikula@intel.com,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
 <fbd44e8a-713b-4e66-9241-e18fc78c9168@antgroup.com>
 <zhm2eyo5hy6wta5ga6zqgg546q2atjekdxoivksht2kdrqppoy@6ck7iwpfxidr>
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <zhm2eyo5hy6wta5ga6zqgg546q2atjekdxoivksht2kdrqppoy@6ck7iwpfxidr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_080718_208827_B5D3B74C 
X-CRM114-Status: GOOD (  17.51  )
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

On 3/26/24 10:16 PM, Lucas De Marchi wrote:
> On Tue, Mar 26, 2024 at 08:27:25PM +0800, Tiwei Bie wrote:
>> Hi,
>>
>> Gentle ping.. Please take a look at this series if possible. The changes
>> in this series are very straightforward, so it shouldn't require much effort
>> to review. But they cover a wide area, making them prone to conflicts
>> with other patches :/, e.g.
>>
>> https://lore.kernel.org/linux-um/20240326073750.726636-1-surenb@google.com/T/#u
>>
>> Sorry to be impatient, but pinging this. This series was originally posted
>> two months ago, and hasn't received a review yet. Just want to make sure that
>> this series is not lost..
>>
>> PS. I have tested this series on both of 64bit and 32bit platforms manually.
>> There is also a CI test report from patchwork@emeril.freedesktop.org:
>>
>> https://lore.kernel.org/all/87bk7rzj70.fsf@intel.com/
> 
> 
> yeah, it's a clear improvement.
> 
> For patches 1-5 and 7, feel free to add my Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> I commented on patch 8 as I'm not sure it's the right approach and same
> thing applies to patch 9.  Patch 6 I'm just not sure as it's the first
> time I see that file, so I will leave it to others.

Thanks for the review! I do appreciate it. :)

Regards,
Tiwei

> 
> thanks
> Lucas De Marchi
> 
>>
>> Thanks,
>> Tiwei
>>
>> On 3/6/24 6:19 PM, Tiwei Bie wrote:
>>> A series of minor fixes and cleanups for UML.
>>>
>>> Most changes in this series are very straightforward. Please consider
>>> picking this series for v6.9.
>>>
>>> There are still some remaining -Wmissing-prototypes warnings. I plan to
>>> send a followup RFC series first to fix those warnings.
>>>
>>> Feedbacks on this series would be appreciated. Thanks!
>>>
>>> Changes since v2:
>>> https://lore.kernel.org/lkml/20240205114708.25235-1-tiwei.btw@antgroup.com/
>>> - Add "um: Move declarations to proper headers";
>>> - Add "um: Fix -Wmissing-prototypes warnings for text_poke*";
>>> - Add "um: Fix -Wmissing-prototypes warnings for __warp_* and foo";
>>> - Make do_set_thread_area() static;
>>> - Add the missing header for calibrate_delay_is_known;
>>>
>>> Tiwei Bie (9):
>>>   um: Make local functions and variables static
>>>   um: Fix the declaration of vfree
>>>   um: Remove unused functions
>>>   um: Fix the return type of __switch_to
>>>   um: Add missing headers
>>>   um: Stop tracking host PID in cpu_tasks
>>>   um: Move declarations to proper headers
>>>   um: Fix -Wmissing-prototypes warnings for text_poke*
>>>   um: Fix -Wmissing-prototypes warnings for __warp_* and foo
>>>
>>>  arch/um/drivers/pcap_kern.c                |  4 +-
>>>  arch/um/drivers/ubd_user.c                 |  2 +-
>>>  arch/um/include/asm/ptrace-generic.h       |  3 ++
>>>  arch/um/include/shared/as-layout.h         |  1 -
>>>  arch/um/include/shared/kern_util.h         |  1 +
>>>  arch/um/include/shared/um_malloc.h         |  2 +-
>>>  arch/um/kernel/kmsg_dump.c                 |  2 +-
>>>  arch/um/kernel/mem.c                       |  2 +
>>>  arch/um/kernel/physmem.c                   |  3 +-
>>>  arch/um/kernel/process.c                   | 48 +++++-----------------
>>>  arch/um/kernel/ptrace.c                    |  3 --
>>>  arch/um/kernel/reboot.c                    |  1 +
>>>  arch/um/kernel/skas/mmu.c                  |  1 +
>>>  arch/um/kernel/skas/process.c              |  5 +--
>>>  arch/um/kernel/time.c                      |  7 ++--
>>>  arch/um/kernel/tlb.c                       |  7 +---
>>>  arch/um/kernel/um_arch.c                   |  1 +
>>>  arch/um/kernel/um_arch.h                   |  2 +
>>>  arch/um/os-Linux/drivers/ethertap_kern.c   |  2 +-
>>>  arch/um/os-Linux/drivers/tuntap_kern.c     |  2 +-
>>>  arch/um/os-Linux/main.c                    |  5 +++
>>>  arch/um/os-Linux/signal.c                  |  4 +-
>>>  arch/um/os-Linux/start_up.c                |  1 +
>>>  arch/x86/um/asm/ptrace.h                   |  6 +++
>>>  arch/x86/um/bugs_32.c                      |  1 +
>>>  arch/x86/um/bugs_64.c                      |  1 +
>>>  arch/x86/um/elfcore.c                      |  1 +
>>>  arch/x86/um/fault.c                        |  1 +
>>>  arch/x86/um/os-Linux/mcontext.c            |  1 +
>>>  arch/x86/um/os-Linux/registers.c           |  2 +-
>>>  arch/x86/um/os-Linux/tls.c                 |  1 +
>>>  arch/x86/um/ptrace_32.c                    |  2 -
>>>  arch/x86/um/shared/sysdep/kernel-offsets.h |  3 ++
>>>  arch/x86/um/tls_32.c                       |  2 +-
>>>  arch/x86/um/user-offsets.c                 |  3 ++
>>>  35 files changed, 63 insertions(+), 70 deletions(-)
>>>
>>



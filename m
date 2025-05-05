Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD7C3ABB0
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VydPJeeyZkYhPW1JxKO9dzuWpf006/6Sweex32bwfkY=; b=qq+YFjNwGioC51Ctis3PCXjAQa
	nNNlHsQbxNvGwmwlkoh3iBRxtOFvLZCybv3CqljlEztHepxGHd9SyXkcfRw7JkYKsdMk7jNlvCG12
	kqs6LHqKCTq6vStVbbxs0s4VOr9+QGeB9M0XsU1kXDB3LJe774Ul9VXAey9ONyc+dm359XSg4clEo
	sOXsNH0DRjDuI+K8L7W+gD8p6yKDwVOFCrUCI1UmqHvLOragfG10zq2gwHuWdqj8V9pwSQY/Rptih
	9Is8tU+VeNDFlG+7DDPUeojwF+a5vJuO/RoGwjw9BqrY5jgWR9WLASKkuUGapcDvLNDuEFIAYqQr+
	QsydpuFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwJc-00000007YFG-11Hi;
	Mon, 05 May 2025 13:57:04 +0000
Received: from out0-217.mail.aliyun.com ([140.205.0.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwJE-00000007YCp-1Huq
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 13:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746453393; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VydPJeeyZkYhPW1JxKO9dzuWpf006/6Sweex32bwfkY=;
	b=CUqinLLDEf8KohuRiDkiqSS2LGs3CpM3LPzaKy7fQ2e8DkB1lTAi6Dp/7+bI9aOtiwtTJryOrAq921V2b7XjsdEHAbcF3ZRsZTtzRfAfPMRPTv3bCGmkb79UhLDICgoeDpk1R27qAVBy4f+R7rZfpRDFh5seT+OYhRKfst8Xda8=
Received: from 30.174.84.188(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cfHLcQa_1746453380 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 05 May 2025 21:56:30 +0800
Message-ID: <8d09925a-1863-455b-b139-278bbe7253f3@antgroup.com>
Date: Mon, 05 May 2025 21:56:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] um: vector: Eliminate the dependency on uml_net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, linux-um@lists.infradead.org
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
 <20250503051710.3286595-3-tiwei.btw@antgroup.com>
 <CAMuHMdX0Zc91nTtH7MPn5bSfV4AuZOrsNshFGYjKzsyRRdr0bw@mail.gmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <CAMuHMdX0Zc91nTtH7MPn5bSfV4AuZOrsNshFGYjKzsyRRdr0bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_065640_921943_1BE53207 
X-CRM114-Status: GOOD (  18.99  )
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

Hi Geert,

On 2025/5/5 17:12, Geert Uytterhoeven wrote:
> Hi Tiwel,
> 
> On Sat, 3 May 2025 at 07:17, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
>> The only dependency on uml_net (i.e., the legacy network transport
>> infrastructure) is the call to uml_net_setup_etheraddr(). Implement
>> it inside vector to eliminate the uml_net dependency completely. It
>> will allow us to remove uml_net in the next step.
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> 
> Thanks for your patch!
> 
>> --- a/arch/um/drivers/vector_kern.c
>> +++ b/arch/um/drivers/vector_kern.c
>> @@ -27,7 +27,6 @@
>>  #include <init.h>
>>  #include <irq_kern.h>
>>  #include <irq_user.h>
>> -#include <net_kern.h>
>>  #include <os.h>
>>  #include "mconsole_kern.h"
>>  #include "vector_user.h"
>> @@ -1539,7 +1538,56 @@ static void vector_timer_expire(struct timer_list *t)
>>         napi_schedule(&vp->napi);
>>  }
>>
>> +static void vector_setup_etheraddr(struct net_device *dev, char *str)
>> +{
>> +       u8 addr[ETH_ALEN];
>> +       char *end;
>> +       int i;
>>
>> +       if (str == NULL)
>> +               goto random;
>> +
>> +       for (i = 0; i < 6; i++) {
>> +               addr[i] = simple_strtoul(str, &end, 16);
>> +               if ((end == str) ||
>> +                  ((*end != ':') && (*end != ',') && (*end != '\0'))) {
>> +                       printk(KERN_ERR
> 
> pr_err() (and friends, everywhere)
> 
>> +                              "setup_etheraddr: failed to parse '%s' "
>> +                              "as an ethernet address\n", str);
> 
> Please don't split error messages, as it makes it harder to
> grep for them (everywhere)
> 
>> +                       goto random;
>> +               }
>> +               str = end + 1;
>> +       }
> 
> Can this use mac_pton()?
> 
>> +       if (is_multicast_ether_addr(addr)) {
>> +               printk(KERN_ERR
>> +                      "Attempt to assign a multicast ethernet address to a "
>> +                      "device disallowed\n");
>> +               goto random;
>> +       }
>> +       if (!is_valid_ether_addr(addr)) {
>> +               printk(KERN_ERR
>> +                      "Attempt to assign an invalid ethernet address to a "
>> +                      "device disallowed\n");
>> +               goto random;
>> +       }
>> +       if (!is_local_ether_addr(addr)) {
>> +               printk(KERN_WARNING
>> +                      "Warning: Assigning a globally valid ethernet "
>> +                      "address to a device\n");
>> +               printk(KERN_WARNING "You should set the 2nd rightmost bit in "
>> +                      "the first byte of the MAC,\n");
>> +               printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
>> +                      addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
>> +                      addr[5]);
> 
> Perhaps make a copy of addr[] with the bit set, so you can use %pM?
> 
>> +       }
>> +       eth_hw_addr_set(dev, addr);
>> +       return;

Thanks for the review! To keep changes minimal, vector_setup_etheraddr()
was copied from uml_net_setup_etheraddr() with only the name altered. This
series has been applied to the uml/next branch. I will submit a follow-up
patch to address your comments.

Regards,
Tiwei

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 



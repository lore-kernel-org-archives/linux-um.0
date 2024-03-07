Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A3CC48BF6
	for <linux-um@archiver.kernel.org>; Thu,  7 Mar 2024 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CEUroHRud//+MTdEiRJr23aPL5vO2Oqq1OV4r+2SD9E=; b=d9RPlrod/JRDksXfHt4mTURkaQ
	HaTuQabXlZSUbkbMs44UytDR24LWLsGiazWaavK1u6ah78ygWFTfOeo5uuMGm0f6WrK9JD6Kxl6kY
	pXnEC72X8VufTEargGQgXszLcw9X3rIVNVyg5AyeJjFA828xOgSXczn7UW07PlEgKiVGuCB3mvCDJ
	BqEPOGbk3TFvRGmTYmc7H3RktxKhZWum2FsRyW++gyEpLH0ALuQQ3bdndMwc5K+SNgICQJ5j9bPUB
	QonuRhX+M/8rHuTHYqYOc2zPaQp2EEq4irv/Ti1zjfE9oTC6Tn1ikPfmPuijTJxLQhQQa/8iBSvTY
	DsWYbV2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBKH-00000004A30-3K9r;
	Thu, 07 Mar 2024 10:50:13 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBKF-00000004A1t-16YJ
	for linux-um@lists.infradead.org;
	Thu, 07 Mar 2024 10:50:12 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riBK5-00DtdZ-EY; Thu, 07 Mar 2024 10:50:01 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riBK0-002kf3-2N;
	Thu, 07 Mar 2024 10:50:01 +0000
Message-ID: <4ee83195-99f5-4823-b4d0-339ef4127013@cambridgegreys.com>
Date: Thu, 7 Mar 2024 10:49:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Waqar Hameed <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@axis.com, Richard Weinberger <richard@nod.at>,
 linux-um@lists.infradead.org
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
 <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
 <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
 <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
 <a485fbdea26e19afe00f603bd65c83e2be20abe6.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <a485fbdea26e19afe00f603bd65c83e2be20abe6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_025011_337958_D2512449 
X-CRM114-Status: GOOD (  13.41  )
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



On 07/03/2024 10:29, Johannes Berg wrote:
> On Thu, 2024-03-07 at 10:27 +0000, Anton Ivanov wrote:
>>>
>>> How's that required to be formatted and loaded? tcpdump itself can also
>>> dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
>>> so probably not useful). Perhaps we could even automatically call
>>> 'tcpdump' at runtime?
>>
>> That is one option.
>>
>> As far as common use cases are concerned, at present you can:
>>
>> tcpdump -ddd, convert it to raw binary (3 liner in a language of choice) and pass that to vecX as a bpffile=
>>
>> It may be worth it to make vecX also take the -ddd format directly by adding "format" options to bpffile.
>>
>> I'd rather do that instead of invoking tcpdump out of a device open. The -ddd notation (+/- a comma here and there) is
>> standard - it is also used by iptables, etc. It can used by other code generators as well.
> 
> Yeah, that makes sense, this is all kind of special configuration
> anyway, and given that it's been broken forever ...
> 
> I actually doubt anyone would scream if we just removed it, so maybe
> just remove it and if they do scream, point to the above, including said
> 3-liner in the response?

Let's make it so.

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


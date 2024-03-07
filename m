Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD44C48BF6
	for <linux-um@archiver.kernel.org>; Thu,  7 Mar 2024 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwjkeoQmVaN91w56Z+JLE95IZ7Bh98KSuQfvZhawA+E=; b=uJH+ZaJTqd+ykKUmMYsmCeYSnn
	ksQNv2zp6E9IFL9/GLgw1SIgH+X6cjojZl/i+BFLnEhYdyNncq8gzlnOKQqZOU79UvYUYRzFP0xV2
	FlODu4loZ24MpSq7PbBkF0vuhcHzEi1/Ouw0lB7V9W+Gb01+o1FsqUEQvIcZVXz774A+CV90uUPaK
	jh+QcV1NC6Yc7y9Pm+PevmppVnrdSq5OqoFJncktlAsQTmGgzBmKowb7OYSIcDbQsbRxrzdSRSpJO
	aAmzxzN2Q4yD6/Kp0QCWRhwxOz/MaZp+VtXWS8f+32GTDoBZTsmome/p5H4dIkdHkKr99aEGdLAOM
	7ocjKzug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAyu-000000045MA-00cc;
	Thu, 07 Mar 2024 10:28:08 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAyq-000000045Jt-3KtU
	for linux-um@lists.infradead.org;
	Thu, 07 Mar 2024 10:28:06 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riAyi-00DtX0-4e; Thu, 07 Mar 2024 10:27:56 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riAye-002hiC-1k;
	Thu, 07 Mar 2024 10:27:55 +0000
Message-ID: <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
Date: Thu, 7 Mar 2024 10:27:52 +0000
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
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_022804_869932_E5855CD1 
X-CRM114-Status: GOOD (  18.90  )
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



On 07/03/2024 10:03, Johannes Berg wrote:
> On Thu, 2024-03-07 at 09:54 +0000, Anton Ivanov wrote:
>>
>> PCAP is not feasible to incorporate into the build system at present.
>> It has grown all kinds of warts over the years and brings a lot of dependencies.
>> IMHO we should remove it from the tree. It has reached a point where it cannot
>> be built on a modern system.
> 
> I suppose it might be possible to call pcap-config? But agree that it
> doesn't seem really worth investing in.
> 
>> The users who need the same functionality can produce a bpf filter using tcpdump
>> and load it as "firmware" into the vector/raw driver.
>>
>> I am working on a pure python bpf compiler which takes the same syntax as PCAP.
>> It is showing signs of life and it can do some of the simpler use cases. Once
>> that is ready, it should be possible to use that instead of pcap/tcpdump.
> 
> How's that required to be formatted and loaded? tcpdump itself can also
> dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
> so probably not useful). Perhaps we could even automatically call
> 'tcpdump' at runtime?

That is one option.

As far as common use cases are concerned, at present you can:

tcpdump -ddd, convert it to raw binary (3 liner in a language of choice) and pass that to vecX as a bpffile=

It may be worth it to make vecX also take the -ddd format directly by adding "format" options to bpffile.

I'd rather do that instead of invoking tcpdump out of a device open. The -ddd notation (+/- a comma here and there) is
standard - it is also used by iptables, etc. It can used by other code generators as well.

> 
> johannes
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


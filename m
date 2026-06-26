Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1FBCDE008
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CghO9lIv4zQqNcqBMvGABxKSM2Ww4PWojiXi45gW8Lw=; b=qRBPOnZDDdrMQNIzK2DQ3Kl1nK
	ZRFa3O6rLlfyO5a5McazfJbMSRHD3HfKrrJp+F2A96JkOEswIZg7AOgqR2pWuuC98nUUBvjgapQvP
	Gx5VTsiA3pqqrxM/VjgHeR7t0uhH2keChvau81Wgjl4Cosi9/UZsxWOSIY+dWO9L47pP5MPVOS6/I
	d0Xhl5rVBEQDtmbkRDld4W0XDi58qfjJmA3/aulp0QwEZ1B9TnQn9LscPWo2tcfAI1MrQx9kP9SL0
	3aidgYbd8V2rNuydDoyC0Z2mzwbWt0ngtaM4/Bqw4NO8xudn586WG8Wyblu3I1LFtLWIZ6cMODjHs
	fNzqZQ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd2Rh-0000000Aw6B-0eQZ;
	Fri, 26 Jun 2026 09:01:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd2Rf-0000000Aw65-46n8
	for linux-um@bombadil.infradead.org;
	Fri, 26 Jun 2026 09:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CghO9lIv4zQqNcqBMvGABxKSM2Ww4PWojiXi45gW8Lw=; b=IclH5bZanqFGiNRhldNwpqF9tv
	qqvx1aQe850RkP7oQlGKgM8NWwhxhF8RXrsM7OqD/l9ryxkMCN1LK4+Y0p+fxCRedJJgJIC3lVFSM
	ij5YcIYjichbmGASL0NAwTqg7u+DluSMoUc7uj8zkXsXk8blB9SLdabcC0VwdmKwGoIkURtm29LcW
	Zai1y4E2qR08Langu1BpbOcIp1WuOiClrYm4NnWbu7WOfTW7EqlEZ/8LNw1KQMJeCLhojvJS6wjOl
	+TkBrdT5KqC95gmPD/40Nq6Y84BKgxaJdovI99pY8++zyWp4f1y4CMRvqpYqADl0t6FjqV/w/eoyT
	0mMdfl8Q==;
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wd2Rc-00000004dhJ-3aWC
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 09:01:54 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wd1ot-001u1R-T0; Fri, 26 Jun 2026 08:21:51 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wd1kq-0000000BoSt-0qIQ;
	Fri, 26 Jun 2026 09:21:50 +0100
Message-ID: <6a20b442-b97f-4cae-9168-30201d5ef82c@cambridgegreys.com>
Date: Fri, 26 Jun 2026 09:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
To: David Laight <david.laight.linux@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
References: <20260626043731.319287-1-ebiggers@kernel.org>
 <20260626043731.319287-3-ebiggers@kernel.org>
 <20260626084113.42eae31c@pumpkin>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20260626084113.42eae31c@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_100153_123010_DC95FA35 
X-CRM114-Status: GOOD (  15.26  )
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



On 26/06/2026 08:41, David Laight wrote:
> On Thu, 25 Jun 2026 21:37:25 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
>> If the CPU declares AVX or AVX-512 support, verify that all the
>> corresponding xstate bits are also set.  If any are missing, warn and
>> don't set the corresponding X86_FEATURE_* flags.
>>
>> This eliminates the perceived need for UML-supporting AVX and AVX-512
>> optimized code in the kernel (that is, lib/raid/ currently) to start
>> checking the xstate bits in addition to X86_FEATURE_AVX*.
>>
> ...
>>   static void __init parse_host_cpu_flags(char *line)
>>   {
>> +	u64 xcr0 = read_xcr0();
>>   	int i;
>> +
>>   	for (i = 0; i < 32*NCAPINTS; i++) {
>>   		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
> 
> 'line' comes from /proc/cpuinfo
> Surely something would be terribly wrong if that included something the kernel
> had disabled (or didn't support).
> 
> 	David
> 
> 
>> -			set_cpu_cap(&boot_cpu_data, i);
>> +			validate_and_set_cpu_cap(i, xcr0);
>>   	}
>>   }
>>   
>>   static void __init parse_cache_line(char *line)
>>   {
> 
> 
> 
 >
Lots of other stuff will go wrong before that. Glibc, things compiled with LLVM, python, perl, etc.

Half of the userland will go belly up, because AVX is used in string operations and hashing if it is available.

UML is just another userland application from this perspective, so there is no reason for it to behave any different from the rest of the userland.
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661




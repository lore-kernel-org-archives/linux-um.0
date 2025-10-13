Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459CFCCD185
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1aJOeaPPB1LUMhLyvXF0SOu3n0ovMqgDmMOTUIZYXXs=; b=c/oh8TDworulQzb2dtY3sbV6J4
	7/ceDW/HCnAzCN4izriYxmgYU+lR2IrYah+6Pjrg0Edm+TpodbTrHNC5CX+M4F6/4QGTdkZpl/loq
	jcZRnBX1VpLo+OrN7b6kJ1t7B6ojuuHJp8Q+xkDwSFWXgQoBMUSgjYOdf2Ed9kURK3IXlIBXhMZfl
	jBV4iueJBqQ1B7+zrpc7sr2Xhi5QkBYbvokW3M2awegsH3KdNGcwDoR0Fm1ZZ3RrEN87yqeGcoMfT
	ToEL/UvZMeACMxq4KQvG1dYN7pfYBYWvl4Lc8hU2PchB1S7jdY2jIkBJhU9U1HYcSWop5zwqJlDDE
	KHxffwKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OTt-0000000EJkx-3gQB;
	Mon, 13 Oct 2025 19:45:17 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OTr-0000000EJkH-3FY2
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 19:45:17 +0000
Received: from [IPV6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d] ([IPv6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59DJiSUF1442566
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 13 Oct 2025 12:44:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59DJiSUF1442566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760384682;
	bh=1aJOeaPPB1LUMhLyvXF0SOu3n0ovMqgDmMOTUIZYXXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OIcplRenwsuEFxrQG/i7vbTNL5ee01maFltEu/9+zMjTrqySBAieZqr/Jnicpqoey
	 b2HHI6yIRprdPUAGYIWjF/kEanvHHWXiC6nPSVA5IqK35TSVZ+7IrLFGmq98r1j8DZ
	 V5aeeP4aUdWPcHl9xR2EvzbOu0Jiq4U5iHSVyec1uPZV1rwgNuPSY0NPtjes+43aIl
	 K+H3VHnCes599MCCY8JoDUtC3q84PpJfE6CcvcH+f08aBA9dJ3t2a/zXK+rcx8az32
	 UvQcHsa4qPbKZ9DC6gaWyDpFxKVkpNfFVN7H2GKOXZ8fif9gO0qQ83SQs1WuiyNyu6
	 EQ1aEfan++sog==
Message-ID: <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
Date: Mon, 13 Oct 2025 12:44:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan
 <shuah@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de>
 <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
 <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_124515_811341_8810B39C 
X-CRM114-Status: UNSURE (   8.88  )
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

On 2025-10-13 10:14, Andy Lutomirski wrote:
> 
> I don't actually remember whether the kernel ever used this.  It's
> possible that there are ancient kernels where passing a wild, non-null
> pointer would blow up.  But it's certainly safe to pass null, and it's
> certainly safe for the kernel to ignore the parameter.
> 

One could imagine an architecture which would have to execute an actual system
call wanting to use this, but on x86 it is pointless -- even the LSL trick is
much faster than a system call, and once you account for whatever hassle you
would have to deal with do make the cache make sense (probably having a global
generation number and/or a timestamp to expire it) it well and truly makes no
sense.

	-hpa



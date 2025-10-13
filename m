Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B04CCD185
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzCgvPG4aCYIt5U2/uF5XWAxPeOEelq2YRV2TeCo8zQ=; b=w33VHf5W3oM+zs3tBnJXrrcRa1
	tOCMOHJrT3/UInToXGu/KMs7PhyKpwC7FxfIBt9CXP95wCubUuzNpsdsXHLMZU1ga9kUggIr+lpYT
	NioU8/nLEUyd/swCi2+xD2ad3AOCnIH/tZwXhmshasUatEAgCtmDWtCRjt4P8ey672KylTWIM0MCT
	Cp7dW/64235VLke3v6IZMLNGA6+rGION9J2oBeiRX4RDMzrGb4Vq6ajj1LN5GoPJ9ujZZ2w7QrtRP
	F7rRCCDorntigJsgU2hk8kiXLb41EcJN5BfCE7/GL/vc9ljk0GXrH3rtwTU/82deuynpl/IYgj6Nd
	F6fMhSUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8PoB-0000000EWoc-0kd5;
	Mon, 13 Oct 2025 21:10:19 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Po8-0000000EWo1-2dNu
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 21:10:17 +0000
Received: from [IPV6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d] ([IPv6:2601:646:8081:9484:201e:bc0f:a7c6:ca8d])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59DL9bFB1473312
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 13 Oct 2025 14:09:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59DL9bFB1473312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760389780;
	bh=OzCgvPG4aCYIt5U2/uF5XWAxPeOEelq2YRV2TeCo8zQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cMd67WoOzA4jU4tRxio15jlNW2gMHZRxCZExgtMI3hc6F1bR+FFsKY5zGygn7k4Ht
	 1jzcy6j8UKiFa4jjP8JG4Ukwnmr9yOlz+dgxvT0Z1Qc60vjnoLiye+3tZQBQ33a4ck
	 POM5nApdVKga/EVyRL79HJiBHLfa+Hobx5BtA7IrG1kqj+u/TEhFdQrUicdfBg6oia
	 wtIwnrOtj7NJhqoOeS4J+3SZq3L4Xy38DiBL5iXRQ11zCbdpPFpRSPqcljY0ZvD95d
	 Nnra0LThGgnrPnoBBmno0+2CHn+URmyBysN69/FI+IK6z4sK7RBrtSQ5jiyOJLJ2gI
	 WkYz9DUtkxygQ==
Message-ID: <cb5991f4-fc6b-43d9-a60b-f28b5eeda5d3@zytor.com>
Date: Mon, 13 Oct 2025 14:09:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
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
 <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
 <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_141016_672008_EFF46E9A 
X-CRM114-Status: UNSURE (   8.14  )
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

On 2025-10-13 13:32, Andy Lutomirski wrote:
> 
> The global timestamp would just be some field in the vvar area, which
> we have plenty of anyway.
> 
> But I agree, accelerating getcpu is pointless.  In any case, anything
> that historically thought it really really wanted accelerated getcpu
> can, and probably does, use rseq these days.
> 

Indeed. And with RDPID it is fast enough that the bulk of the cost is probably
in the vdso call.

	-hpa



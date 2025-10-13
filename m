Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9642ACCD18D
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MzpJMWVhNoOjgk4BJX8F1SShnKbckMn+Nc+zuR294Q0=; b=J82WU6Aej8jmZaguTKuqHES0zB
	cQAt3dRq6hAJ44j5FWJYhKa4hHtS99tP14MWFt36VZUBGredDLr8q+Mb8XV4i6g+QqD4VLJjzzg3T
	mw1a25aVRo9K8b7k1hEQMs1i6ToOvMNBQq4e5WpsZ8SLwuDJRtwuc93YmEYvNwehDt3btpqF+lH3F
	dNfl6R+chDFwkRy9C9pUoB3tpU4io3+UcfM+505G0OWy3dEVTlPaJTuYZ/NULI7qnwZoWthZ2r//7
	uaOx4u6H3A3LNJ29HT5aulIvXTkPLjI2mPoaPb/8sjTR2WHjXWLtaL0YFOp9PHFUAEbecuqclRQ1J
	FW28EEmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8LDD-0000000Dq0X-3AAp;
	Mon, 13 Oct 2025 16:15:51 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8LDB-0000000Dq03-44E8
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 16:15:51 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59DGEplg1360107
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 13 Oct 2025 09:14:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59DGEplg1360107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760372093;
	bh=MzpJMWVhNoOjgk4BJX8F1SShnKbckMn+Nc+zuR294Q0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JQss/l/MXShiySKzZWsav9VeArEu5N+uHoA047KLEMyntuwcMeK9wlN7HIQ0Tqk38
	 JWP3hXYKNvikpWfX6arlx9W0uwDMOxRmDNvKTDAE5F6UoQRuW2UYdQH8FS/dmu5d3E
	 IWsydJI7iSqT/4JiUB/QpAvO0m3CLOT54r0BnuzOxjwp1hTkoYG5cC2cXMzIqbFFu/
	 hVeOMUm7eShn55+XGXxv1i0cXqiWlUTDXcOMz142IMJrmHCUqBtj9hGS3pSQf+YHB+
	 vjYWunPASD2OmpmvS1CGd8ToW6X150kS6ymSlNwqvCNTUzUlIQ4v/fyvlZZe23Moc7
	 PV1r9bSGOj9qg==
Date: Mon, 13 Oct 2025 09:14:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>
CC: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
User-Agent: K-9 Mail for Android
In-Reply-To: <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de> <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
Message-ID: <9F23DEFF-FCD7-488E-B31C-E891A7521D9E@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_091550_009784_1517CB29 
X-CRM114-Status: UNSURE (   8.08  )
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

On October 13, 2025 7:06:55 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 10/13/25 02:20, Thomas Wei=C3=9Fschuh wrote:
>> -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused);
>> -int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu=
_cache *unused)
>> +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)=
;
>> +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
>>  {
>>  	int cpu_id;
>
>It would ideally be nice to have a _bit_ more history on this about
>how it became unused any why there is such high confidence that
>userspace never tries to use it=2E
>
>Let's say someone comes along in a few years and wants to use this
>'unused' parameter=2E Could they?

I believe it was a private storage area for the kernel to use=2E=2E=2E whi=
ch it doesn't=2E Not doing anything at all with the pointer is perfectly le=
gitimate=2E


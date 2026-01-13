Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5104D29DC3
	for <linux-um@archiver.kernel.org>; Tue, 13 Jan 2026 06:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vX59/flKMUDb8zjb/CqTAfKlTuGyJwgf2lJ9POWv81Y=; b=dwSM0+gM8T6HGgo5SpfiIYrDyd
	4OBSqTp6oq9S+5dNJu8wwzVPJJu2caXo5nk/h2p4sMhkFjttbID+pr7hobAu0g/dO61ERZKS9tn/L
	/l8t8MjxA0AhtHN75NYexapHXIVBZUbwAOlnoJFD6S0V3af5qRQ+a4SyESzZ7m1vs+5DzRHO2FZhe
	jxlxNqOk2AQHrq9cmKmq6oRTH8uDq6DRnG0iouOyITvwcfABKC4oGMZlwZIZArNNvM4VmX+UL+AK0
	gdcEuFJsJlLRvE0YQv8oB2cEMQxLBIpHfvOCfwMkZFmaDt48PTV8ezJY60QBNGdabUr6gONrjGwTT
	Fanee7hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYF0-00000006cJo-2fyV;
	Tue, 13 Jan 2026 06:50:58 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYEv-00000006cI7-1lAu
	for linux-um@lists.infradead.org;
	Tue, 13 Jan 2026 06:50:55 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-88fe44cce7eso56304176d6.3
        for <linux-um@lists.infradead.org>; Mon, 12 Jan 2026 22:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768287051; x=1768891851; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX59/flKMUDb8zjb/CqTAfKlTuGyJwgf2lJ9POWv81Y=;
        b=dYgF0Sad+e/3ei1BsxSG9JGFeU41ISDCNWE1e16g1VDfh6Hq6VdXaDQNiH3EUzKSWr
         PhzixEPFueJRzQ++/5euIVDkSNbbr1+kCQHEO0jnoPPgaoz8TdGXuI+ENV/wiRU7dC4h
         6FhoxFsv+Pw8I8Rwx+MQg0JNfazblufsZK9voMQXk/08qGd/Pqa4CqotHjRTNOZAF5oa
         u2b/Azo17ZubUElFE6ZAcuO9EydBIlcQNiaQiriA6W0H2rOAMH8A8J/6oqOtAFCIcMYf
         gCJ/FoEQBnuuudNy9YCRrAcSPtSU4hHMI9YBJR8YgIEdDgpgzfj0/hPzw0ViUziK16IP
         lxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768287051; x=1768891851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX59/flKMUDb8zjb/CqTAfKlTuGyJwgf2lJ9POWv81Y=;
        b=MQCyY0rpBlZWCvRF+6jfHtXUpT/WkiANX8Fb1dZode/5J9QI7UDx9eAU7j86kyJGNs
         z0o6WsxL2vZRzeQu3xDOzLvf2764RkNNmeUOnyyZrMVlq0Cx4TG9QmhYyRmDaAiqY8Sf
         coiSMZHBRn2psgXUnybnzrOzFQO+oJpecOwTlqUS+Rtt8FLYCpJuU7S5gXCZQolKRaQX
         mn2H+WsIE96BcSURlPFjilC+Z1jpfZUjYR4mR6cKEDgh3R0N8pwEaOIweSKyuXvB1I1E
         bgkxc+Th6JZpLL2hqEC0a6sF9Ma0S6xGwG9jsYLoLokLQk6YBkIS3wCcBlqkplpe1B2j
         TkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWZKuycY2Eg5rlVP1miYgenPwKOtwF2w3dJsvo+LpT7wlyQNLYG5i0JMlnyk1W6bE6tGct/u7wBQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzYT9/12lwHItD6Wx6O2tF8ZKqfsTVgwFpfJeKd4Vm3PCs1CV3A
	S2BXkpmHLSNtkZIwbNLepeW5zFvKFSMlA2qWIwu71r7twWYOcV27ELXo
X-Gm-Gg: AY/fxX5M6BKq90pPguhqMncuQEjWEjSbdPt0BeROFJoCjFEfYSYrhBcjpfY+UXE/R4c
	3sUPgLQSPO1TaxZyKhHrm+iSpaYB8/DUeuQoyaqg5HuXBrIbQKGwGhN+tFk4zNik/CmIJoDuDzT
	JsQ2hIc0cBITzYG2uMK8wGue1uc6JUofu7pAw/ldAhjnxSPAQae6/DldSfrA+DwNOHFCUvOsw+T
	f+ZlyDfWdIW+kjM0I9Qb75mFpxq8G9T9W56jf6QFhmyg32hDLiX1YIs4nv/NjH2L8N8qU0CCLFL
	BQ9v1XS8Epi/o/QnF3vl9opUTKSonbRFWRcYaY9emBysodgu8abcVi5nlugEI6zLSsf/UIsk0WB
	gHbZNOmGLeTwOaKlAoQ+KQxVY6DF1NVzYawPen//K/LggzMLegVkf7Vc1pd4Cc+BGsRnQTB+Vs9
	E+Rz4EsE88N0MuIrlC4vtdu14m5cAVEJuTHipZor9zfqJdcO9pD0FEfxegIg==
X-Google-Smtp-Source: AGHT+IFA85MjM1cnTGL5nks8UTBaUTRvSeGOw/MqVWENdA/8we2okwkLgNeF33lCoaLlOIlw7RP7mg==
X-Received: by 2002:a05:6214:4291:b0:888:81f1:a05e with SMTP id 6a1803df08f44-890842d1be9mr273660036d6.60.1768287051243;
        Mon, 12 Jan 2026 22:50:51 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cdfb0sm152433806d6.6.2026.01.12.22.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:50:50 -0800 (PST)
Message-ID: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Date: Tue, 13 Jan 2026 08:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_225053_460931_34B552A1 
X-CRM114-Status: GOOD (  10.23  )
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

On 1/13/26 00:23, Andrew Morton wrote:
> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
>> v3 changes:
>> * fix empty_zero_page initialization on arm
>> * fix ZONE_DMA limit calculation on powerpc
>> * add Acks
> 
> updated, thanks.  I'll suppress the ensuing email flood.
> 
> Kalle, can you please retest sometime, see if the BeagleBone Black boot
> failure was fixed?
> 
> Seems we haven't heard back from rmk regarding
> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.

Hello!

I will test this v3 patch ASAP and reply results here.
Collective sorry for the delay; I have been busy!

BR
Kalle


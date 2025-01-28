Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D70C0218A
	for <linux-um@archiver.kernel.org>; Tue, 28 Jan 2025 10:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2XyAQrOTcI19ilumWSMw1hLrZQh31wPEOX9kHRV/Kjk=; b=CuQJXw8MSpTb65tyqWHCl8GL4+
	nw3ehQQ3YSRpQBUpsVD0NkduyRMfprxZWSn+ejbDK5CR/b4G8/uMZ4k8yTd0a/0m/IwGMhoi/fX+N
	NtmCp5uMyaAeqwSIHyF24rBCZEj9xxjZx6kTySxU93GgoLNcWdU6O1eiMO3tQcF1/h/JubQ7k7zCF
	VEjPYEO3/lBTp4tFtdzpokJQpRVwOwC+JioXKxmqzjhjKUySO3CyfSJZb8fvvt8MhdcahwMoiVU1d
	BtgJljDNdBJN2yAJ8jmMySsmbPhTmC4sVsVCGjL4uJl9aZG1hOcq4KWyDHgeAWGG6S137nQkOxRgH
	9TD/Mb0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcitw-00000004en2-0Z5p;
	Tue, 28 Jan 2025 10:33:00 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcise-00000004eUh-0ne4
	for linux-um@lists.infradead.org;
	Tue, 28 Jan 2025 10:31:41 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4362f61757fso57651465e9.2
        for <linux-um@lists.infradead.org>; Tue, 28 Jan 2025 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738060298; x=1738665098; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XyAQrOTcI19ilumWSMw1hLrZQh31wPEOX9kHRV/Kjk=;
        b=ZTbtuNsnZa6/cI9aGZgu/fNQDHDA05Qb1vlKIsZyqb7UoCbySMKueoZe/b9Yenemp9
         GWP5Y90Kx8hITzOcSYLfpNbrFTpyELihogg6EbjnGn0PaD+cdy9j9jReTbAEE7HKTNhr
         YGhvyFjsnXNPZ/Fi7AZQoNNmvV3FQIqLVjhU4+fpUSQRjiY3ku2697CI5jbMQu86p8pj
         dZRNS/ROy2Rxx0IM/J8WCJZt5aP1s/CJeUMCtj89eA6awKuuMopg7lZZZumQizdalr5A
         S+WUFlTEbrVJ5Y0+AzLrt5G9XYnpTc3hmNRykDJT8apLY1YdN2soZBv0j+PdmDVVJgIN
         ZZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738060298; x=1738665098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XyAQrOTcI19ilumWSMw1hLrZQh31wPEOX9kHRV/Kjk=;
        b=Kg4HjvBv1gHzIPIiMdTp8Prou5A3YZg2iVSIbGA10sf3WUB+Aa8bfqMHZmq4t7nUHo
         r7dYsbwywp+V7wFiiGv2Stt2lYMA7LMbWVwkXtdQok/Z8bXLV7UdFmMH3M5MbOm8EWow
         ANfQ+diRAl3oQYxhxeB/wXmm0ml9DXYWvY6ve71GA8jTH/b0b6CUDTK2M0UnaiLUvy+A
         IFwyjg4hsk166jEEWXtXOycMWo4Cvk5Odfnk4srvjEiyYz8v+MS0m7Bpowb1KqieIpuj
         g71DgjXCOdGUcOxJhJlqDK/8A9aBwOwWyP9GmWMhYrNr5v2IqCIDpBsHGs7G9q7cHqME
         mkIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+bI+As/SLIgYfp3rFUezkNVi4ptCZ2Kyog67Tc65q8Bqv9I3tFs34VIeWkUNkUoIHCX9wC/i9QA==@lists.infradead.org
X-Gm-Message-State: AOJu0YykOkcavV2YePW1asYe0VK1a/WmgP1CWuX6UtQozx8VrD7Yg+nl
	fVvTUQ3+22GUpx5szQf1XZ8W5ZPEnmjQE/6EtF1pxE0TXrPPv2ApvBI8wCBjVs4=
X-Gm-Gg: ASbGnctODUAOCnF5mXC3eLBdaHkRN+mlZKrqk7i0LCTGH/21bUUmyDSXyWWNhgpsKnR
	GuiBuYnHFwDTM8jZJKHneTQw1MSvmibczMMw0CDWZ/pcs8TtkhDTt2IBST5Va5Oafbz+kOZIXgI
	vYCKdyWFfJc/8qIO3g4H1gnhdRgBRsNlQ4Ci03ygELgN1ts/jDLFXcgwiKPkbTQHL51Gy0KtWDL
	YNojP6ah90Br6PS8plLpqZsvSadaMR1b3plRSOFtU+uEgDkm2k5PxkQmpCAb5tKapd73GDP8VxX
	L8zNSvmq0hqzAHjZRpw=
X-Google-Smtp-Source: AGHT+IF66ZZk/rhZtGcWoNDXw91fpPKUDEMFBtm8dpseiNoX9eGm2cyqqMp6iJGiup5xykF6TH0wXg==
X-Received: by 2002:a05:6000:1788:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-38bf56633damr43631218f8f.16.1738060298374;
        Tue, 28 Jan 2025 02:31:38 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188d5dsm14110246f8f.55.2025.01.28.02.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 02:31:38 -0800 (PST)
Message-ID: <099b8e0b-2c64-482f-8c22-32afc5b21beb@suse.com>
Date: Tue, 28 Jan 2025 11:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] module: switch to execmem API for remapping as RW
 and restoring ROX
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Borislav Petkov <bp@alien8.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Gomez <da.gomez@samsung.com>, Daniel Thompson <danielt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Gow <davidgow@google.com>,
 Douglas Anderson <dianders@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 Jason Wessel <jason.wessel@windriver.com>, Jiri Kosina <jikos@kernel.org>,
 Joe Lawrence <joe.lawrence@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
 Richard Weinberger <richard@nod.at>, Sami Tolvanen
 <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org
References: <20250126074733.1384926-1-rppt@kernel.org>
 <20250126074733.1384926-7-rppt@kernel.org>
 <021665c5-b017-415f-ad2b-0131dcc81068@suse.com> <Z5iq2GJKIdlB9APM@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Z5iq2GJKIdlB9APM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_023140_248098_3A6216F0 
X-CRM114-Status: GOOD (  14.84  )
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

On 1/28/25 11:00, Mike Rapoport wrote:
> On Mon, Jan 27, 2025 at 01:50:31PM +0100, Petr Pavlu wrote:
>> On 1/26/25 08:47, Mike Rapoport wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> Instead of using writable copy for module text sections, temporarily remap
>>> the memory allocated from execmem's ROX cache as writable and restore its
>>> ROX permissions after the module is formed.
>>>
>>> This will allow removing nasty games with writable copy in alternatives
>>> patching on x86.
>>>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>
>> [...]
>>
>>> +static void module_memory_restore_rox(struct module *mod)
>>> +{
>>> +	for_class_mod_mem_type(type, text) {
>>> +		struct module_memory *mem = &mod->mem[type];
>>> +
>>> +		if (mem->is_rox)
>>> +			execmem_restore_rox(mem->base, mem->size);
>>> +	}
>>> +}
>>> +
>>
>> Can the execmem_restore_rox() call here fail? I realize that there isn't
>> much that the module loader can do if that happens, but should it be
>> perhaps logged as a warning?
> 
> It won't fail at this point. set_memory APIs may fail if they need to split
> a large page and could not allocate a new page table, but here all the
> splits were already done at module_memory_alloc() time.

Ok, thanks for the explanation.

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr


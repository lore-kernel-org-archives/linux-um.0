Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DE7C02188
	for <linux-um@archiver.kernel.org>; Mon, 27 Jan 2025 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VG6M7E++/3Ce9GXj2tezC00IBdvh1kteyj5hzR0NwA8=; b=jUtTOPDVbVrn67dxZE7oBvFCc2
	xScvPxsvmG+zXh8cOqFArFzexZXPvw7pY63SYkiEC8mr+aBt7ohF6+crrHwmWKpUYX1NzJfHwStu8
	5PN3oMdqgm999/zwmHERSFFucc7/JFYiw76llnGMVQBkZkjkGB92G9Vt1PY5tt1KVR+EZ49FC1Thi
	tVBUrb+QptNmQnzQejEOhoVYDoI2kfFyiaCqjwE0zjl3clQn4vzVx2Kboj2DdwG9FCTLSLHjC+LRU
	NXM3LrcmZ+EM/ZOwcMawf4wovr4/Mci/dlNb9vjSfTRIXQxxRLXjKNVglpCAgKQI3k5WkWZTHy84/
	N9Zg3mKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcOqx-00000002LFL-0r0P;
	Mon, 27 Jan 2025 13:08:35 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcOZX-00000002JFK-1HJZ
	for linux-um@lists.infradead.org;
	Mon, 27 Jan 2025 12:50:36 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-43618283d48so30801595e9.1
        for <linux-um@lists.infradead.org>; Mon, 27 Jan 2025 04:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737982234; x=1738587034; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG6M7E++/3Ce9GXj2tezC00IBdvh1kteyj5hzR0NwA8=;
        b=cEnSUCj7RnXYjRpek6ojlmfJiIRhtIlg9a+poGV2v7Jrl/3wmzXL1+sUBWAVT0YC+e
         XoniCXSo0pYyLNLgQIkFtSTYv2llUopj60ShlOZyyxJLcPFJCP/W0QjwGVfF4+M++jAw
         IQs8nvi1RmLxQB022tuU7Q2I/8NRiMr/j6xGevb7lHhrJBqCr05/l1bglY3Rya72pJ7H
         eM8isH7xFCBrz2EZnl8fCZv7soU+UCay7EiSsa5j8EsVVaymi9NFnJw6A5G7llDOBsVy
         msbQi9YgVLsUH572YLEBGoZnIPUSydT9oVhrqjI52beaa5IKax0QjGWk4fgvMANWu0Oh
         LICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982234; x=1738587034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG6M7E++/3Ce9GXj2tezC00IBdvh1kteyj5hzR0NwA8=;
        b=WofqVUbAX6OLVoWh9STqyYQllhP1Q5DK1ImPDJiSEwnVV9DgdRe8TGzWaUct2OKnB2
         UpXgQDKS6JEXCMVtEqTGhEPWTVfplg9YcG1V60hDFcJFodGCB1M3Snzu/u4XOxxtdQh9
         21oxv7/kJu9MJXYrcMFdmzA54fcOuZ0S91Umj27ff1Sfkh4q9W7nwEnv6DSUUNhoq1zy
         hpOE3xahbavoBHztDqb4ABYs5CHjozD8a8uUdm0vdoeSfG/VHbmfY03VNsudn8Jtb/Bm
         dhL+Dj1+FazK8YT0YVjps9E7Gi4PBXs8KzvT13FvA6ZZlcU6D8VntDT62eikKWISXHex
         PosA==
X-Forwarded-Encrypted: i=1; AJvYcCV+UJrKd2HX1Ad6kOabLHsII7jTDKBn3wuD7oh/x02xonQmCnLV6Iwx5WsseqkoJfPxA/e8zdomlg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyi2t5o1YEkkNhElN6AHczmeQM3t3SMomi7asWSmUCzdp70Kc2O
	Ammq+p7Fk9R/kIU2tRJm80KOOAUI6NoySHTrOfjZPSjS/czNAO6TxAleTk7Z/R4=
X-Gm-Gg: ASbGncuYm48A8AA8oPZsc5/y17adiEB3CBZWRHBCbZ67iWrqvOueiHj8vk7nMyyJ3KW
	LsXo+nWyj0By3HCwqfr/rmcp0/1o87LjXdge/IXbhBk5uzSXR4WNFlF23QeZvXwYBNbd/EXxx/+
	fNmZiF+9A3cx9ZU4iv30phaVyD2XWjGTZUcimPhqGCXHLg8IsTzysQ9/ogKCKiDhrjBL+HiI5qK
	vyni2c+EwSHJMb1cCDsTkPMSzww+0FMVGy7MOimsB2jZ+21ErKduSI3q2/YbPXObfDC/508rO+C
	hH3iW+XU
X-Google-Smtp-Source: AGHT+IHGKx5XPAjKkuM8tLdY/iEmI+lFN9vw68MEGkVKzufCkr8AVUadSDTJkGDjd3qRPKQy8gyy+g==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr435221995e9.14.1737982233635;
        Mon, 27 Jan 2025 04:50:33 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54bfb0sm128676475e9.32.2025.01.27.04.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 04:50:33 -0800 (PST)
Message-ID: <021665c5-b017-415f-ad2b-0131dcc81068@suse.com>
Date: Mon, 27 Jan 2025 13:50:31 +0100
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250126074733.1384926-7-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_045035_352218_7963C008 
X-CRM114-Status: GOOD (  14.73  )
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

On 1/26/25 08:47, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Instead of using writable copy for module text sections, temporarily remap
> the memory allocated from execmem's ROX cache as writable and restore its
> ROX permissions after the module is formed.
> 
> This will allow removing nasty games with writable copy in alternatives
> patching on x86.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

[...]

> +static void module_memory_restore_rox(struct module *mod)
> +{
> +	for_class_mod_mem_type(type, text) {
> +		struct module_memory *mem = &mod->mem[type];
> +
> +		if (mem->is_rox)
> +			execmem_restore_rox(mem->base, mem->size);
> +	}
> +}
> +

Can the execmem_restore_rox() call here fail? I realize that there isn't
much that the module loader can do if that happens, but should it be
perhaps logged as a warning?

-- 
Thanks,
Petr


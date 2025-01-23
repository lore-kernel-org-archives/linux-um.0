Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF6AC0218B
	for <linux-um@archiver.kernel.org>; Thu, 23 Jan 2025 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDz8608lNaW0P9BTT1X9DLek8Kcys+jnF/tb6a9Lcbw=; b=c0/K//czHrw7XtJuYf/EeWPT8+
	Q1GQdigDqdbfBiDdpjPpluuuBSKpmu/HBwKkAENandX8iPMWjgab2XPfBQxFRg16MFlywSiFmCxOC
	z39zDpo83EVqjsaX6Z8rIjb1G8goI+Py/XiFFnmb9uLbFpt5Qu1SQKht7ekAtX1SIlHwcYovK8GFP
	lL2NB5WgYc8+xf9r0YotbyAtwNfr4Yql+B+lSRWzpdgKaE0OIQmVt1VWpXc6PltsO6D0gxDZfBFww
	CY1f3i1z6v140BOQs6058PJ+0gCobcTkKgqF/p6oOA/rSwmQyT2VCMnVLtEkIXAdjHb1l8GeWiod5
	nGQmvVOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tay15-0000000CaeC-33oV;
	Thu, 23 Jan 2025 14:17:07 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tay0X-0000000CaYW-2mbZ
	for linux-um@lists.infradead.org;
	Thu, 23 Jan 2025 14:16:34 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-436345cc17bso7128575e9.0
        for <linux-um@lists.infradead.org>; Thu, 23 Jan 2025 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737641791; x=1738246591; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDz8608lNaW0P9BTT1X9DLek8Kcys+jnF/tb6a9Lcbw=;
        b=OzMl0BImbNi8R4T/9M7YbAPBH48gmUybx5pYQ5jRXmwX1K7T3Wp4bHnfP9WACU/AKp
         Dfbfyd6FLRYZn/rKt4mzGLsL2zr3wHINwS1aeZrWz2oWPeZ8YWY8kfyNUV5QkStkrYam
         xeqHnyy+0JV/kVZ+UCbkX8l/CO8jIamZA4rFeWYsGiatpGpwcpQW7S+BuPi8lp3IgqTX
         1eMVsIKABngNx3h23HI/6gJusSEvEamlS6NOVbgaErF8cu/IvQRfEToRcma5OcgLS8Xk
         L0WrlxMHxNdnxqHldtOWV2fw8vEIGwyaeKjBfcrWXhjl3vINzumyYTVKRzU1RyiJzK0t
         1Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737641791; x=1738246591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDz8608lNaW0P9BTT1X9DLek8Kcys+jnF/tb6a9Lcbw=;
        b=jt1dFhRoeHJvtz5DkYFirnu8DeAn9LaeHIpvRVJW4LHwi6P/uKVS70pTXz1szieGtz
         QzFkSPfehqMYh1HOyszBnUUnF8fTqdtbfIuV5dPbl8UEBLKS8SeLx0wnGs4kf0VH5pgP
         vvLjdUh6xETlNCLsM7a9jiUL7ZS3xJ3J66MX2wn7YxAF6yy82t+330MbGGKScyvv05n6
         HmtleahlSQ4fpCTnYw0jgbp0ZLNCQc5QvIv4DFokoNzbKM6YIhy8zgynwLlg9fdOkvxM
         gzEQOyn8GgpkxLgnN9KRPr02gsvu5NehZJ9nwa+N29kbBREpGW/LNU/qMks4SyMYTX9C
         W7vg==
X-Forwarded-Encrypted: i=1; AJvYcCVvGpAgwrp/vYSF39f7hcFAcUneUXTtG8inm4deo+GwTnJg4OzgpK7j/UGQ9dcGfA33VZuhJEwiGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxGRsTkf32jRnW9tuexShtXKubBfWSeddEEPE5MwXbp4055iqKv
	5089p88KccHEA81Ou2CwqqN0AiNngML3qJoq+imG8Mdc3/Z/OFKYyERg5BkAhS8=
X-Gm-Gg: ASbGncushkNIowOHJ8UGOs8d/zGZaJ/c3UK0p7D16d0+pvvCpNIg+o57HDK11CfYN+d
	7ayVPq3r8nESvWujjsofCMGXpt5UA9WdAfustmFQ8QV1quXFAZ4LysccSre3KQv6l50+uSnHVxS
	VUeGk0fltX3tpfHxTCl00Lbzuu63GhEBZWQGo50HbJlv7rJrWIJa79dd9lVGNJbPrkLPdjW8LGT
	WwhiqWJbnXQl/rKLPdPgbwVG2+lxNIZo3JoRN8GxQXWSd4v5PUXDVRynCtdbZpg9v1c+WeRqhRY
	mqH3prla
X-Google-Smtp-Source: AGHT+IEZ3PnxYGUvf8/rU964wji50OH+SsshrvGk6eo7bEmtZzJZRo7kuLNRZ25HdqIFvqguWQOL1A==
X-Received: by 2002:a5d:4243:0:b0:386:2a3b:8aa with SMTP id ffacd0b85a97d-38bf57b3f56mr16813575f8f.37.1737641791528;
        Thu, 23 Jan 2025 06:16:31 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275595sm19543698f8f.67.2025.01.23.06.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 06:16:31 -0800 (PST)
Message-ID: <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com>
Date: Thu, 23 Jan 2025 15:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] module: introduce MODULE_STATE_GONE
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
 Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121095739.986006-7-rppt@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250121095739.986006-7-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_061633_713511_C061DE07 
X-CRM114-Status: GOOD (  16.57  )
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

On 1/21/25 10:57, Mike Rapoport wrote:
> In order to use execmem's API for temporal remapping of the memory
> allocated from ROX cache as writable, there is a need to distinguish
> between the state when the module is being formed and the state when it is
> deconstructed and freed so that when module_memory_free() is called from
> error paths during module loading it could restore ROX mappings.
> 
> Replace open coded checks for MODULE_STATE_UNFORMED with a helper
> function module_is_formed() and add a new MODULE_STATE_GONE that will be
> set when the module is deconstructed and freed.

I don't fully follow why this case requires a new module state. My
understanding it that the function load_module() has the necessary
context that after calling layout_and_allocate(), the updated ROX
mappings need to be restored. I would then expect the function to be
appropriately able to unwind this operation in case of an error. It
could be done by having a helper that walks the mappings and calls
execmem_restore_rox(), or if you want to keep it in module_memory_free()
as done in the patch #7 then a flag could be passed down to
module_deallocate() -> free_mod_mem() -> module_memory_free()?

It is at least good that MODULE_STATE_GONE is only set in free_module()
past the sysfs teardown, so it never shows in
/sys/module/<mod>/initstate. Otherwise, this would require teaching kmod
about this state as well.

-- 
Thanks,
Petr


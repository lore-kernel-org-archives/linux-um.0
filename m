Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249C6C0218B
	for <linux-um@archiver.kernel.org>; Fri, 24 Jan 2025 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4p8V7L+SybE9UNVkk/PglJRrxpw6EHRMFcIJ2bc0MU=; b=qpm4o4DxesLiAeBY7CNlD97DFr
	hqA0M7pQoQCG5d4WOIuLSYxqEqudMESHEbx7TLP85sDzZTDq2NIh9ajIFhKNzwkiqoWwGLve9Xpj3
	yQkJX5rANZACwhf47VQxEcPeqiI5MK2pW5jrqbIhIl7RPHlsU2Up6zDdlLjguhhjcqVDg4YYqh90G
	03Mrg5kmsg4Sm2wQjjtksYYlE7FSmuntEddb0Wt9b+/o5LnceM2C9m/aSTdsjcLdyf31fr7FzOVv1
	dtNsSTnsv2eKIjgsej4RCSFjquaB91eRpfITAe9EmFb1jO5JO7Rj6JQwVCmI2CK95LIoavNJInrhj
	8Q8ybGeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJI1-0000000EhUf-41bp;
	Fri, 24 Jan 2025 13:00:01 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJHz-0000000EhTg-0zua
	for linux-um@lists.infradead.org;
	Fri, 24 Jan 2025 13:00:00 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-436a03197b2so13925375e9.2
        for <linux-um@lists.infradead.org>; Fri, 24 Jan 2025 04:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737723597; x=1738328397; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4p8V7L+SybE9UNVkk/PglJRrxpw6EHRMFcIJ2bc0MU=;
        b=U7qdvo+t1pQf9ue8Q29LrsnBJCD657m3MvnUiWhtaZTLoPVh/uGtG708jAxCCRaMW7
         NkgAptZ+6CadlmqGwInh75RhSjqQnuYUdJ3fxgwTCy3Mvr7MVJeoH195yhqoaIIawWRV
         7+FgJy3mVZMH4EvSlChvbe8dYgjbrqd6wROwz1z+U35twKTOtMtMaUZxidB3Utzfhene
         sEUJU+pnmJ0sz0Q51rSxa1KLM4Aepnhw545VkYqfA7X/Mxl2VkpK3yJ7bGmQX7Wmcf+N
         aqzig6NpQ4aOzo4QMppXA4BUrPWN6uRMy7jWI7VOFZh/lpBtIADUX9G4tTaDTdjGj9az
         s6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723597; x=1738328397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4p8V7L+SybE9UNVkk/PglJRrxpw6EHRMFcIJ2bc0MU=;
        b=bdaSCGO9PQhix4BhE9tkqSXAKhQe9qEd0Itkgd6kR36o8EUYMf+JOfTs0M6OyAisJj
         vxQo+63sCWu8oep1bxEMPLPlaQui0Hc+gptg/AE4xV91VPulkVSR5k/oPN/xrHcVoxUB
         F/u4AjHqRRk8R8uzAijFIWxrQTMxiIk//poHielktFcy/EBPvkoeYys9wbnYb8JvA+Ah
         zKOpwKnnAmPkmbCSmG+7zyUd9zgB6mQa4dqSY2X/DthNSvdbMLziq6o1sRkVZYnhfPmj
         lVceOXIsk7fiYAcCNiYwDAsIoSfAbSjwwxplre9nwMq5qSuq6rA3GEsArQPdR7H89iY8
         Jo/g==
X-Forwarded-Encrypted: i=1; AJvYcCXU3scq4azCoNjVVja/iNCq6iWje8JSTj+35g5ZUXj1wHV9y6S2zfKPSx/72+ZhJxKZiyZQ15CI7Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzfqan0SWQPzSVNku+5tfaurbRpBvIkqzdO5BISqofu48UNDw0B
	BG1uWXMIvFg+v17i5Un+Eayl17+A03pvEeWHazzeaqqKPD1J95api6jak4bnRkM=
X-Gm-Gg: ASbGncs5pcip6Edr7pqrV0rUFwIUq99mJQvZxYVocA4jDlrnHmEscIdWKD8LP8u7O+x
	88B5K0ygGbVgOVUE7y9boM0HLg/IAkvNMfa2j5ZpeopV4bsKudpYFvAkcR+XdSe/ncuFc4DlntD
	LNsOb4rWm/BmVrxknlFboS96P/Z3e4iNBT5klm3nmTojLZufzaJsUhKPV9sRcGrWKVZieJWNNVp
	/rJ+6Me/rTovGzGx2B7D2cmQ6WtaJjmiqBmU3tPQVHJmVHCtmGz9WrZUVqF3h39JR5JgLvTZdMy
	fWwyjnHPVPG99oB6hN8=
X-Google-Smtp-Source: AGHT+IEDbDZN2m5CHXDDsa3oj6Ebp9OHdbtruLTcN0mhHSAJojPcoO/LDhDZ6xjm5yK5+6pSh7FY3A==
X-Received: by 2002:a05:600c:63d5:b0:438:a46b:1a6 with SMTP id 5b1f17b1804b1-438a46b0388mr219468875e9.18.1737723597250;
        Fri, 24 Jan 2025 04:59:57 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501721sm25207325e9.9.2025.01.24.04.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 04:59:56 -0800 (PST)
Message-ID: <8c6972c4-c1bb-402a-a72d-f92b87ee5a89@suse.com>
Date: Fri, 24 Jan 2025 13:59:55 +0100
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
 Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
 Richard Weinberger <richard@nod.at>, Sami Tolvanen
 <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121095739.986006-7-rppt@kernel.org>
 <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com> <Z5N0UVLTJrrK8evM@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Z5N0UVLTJrrK8evM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_045959_282814_58BA10EE 
X-CRM114-Status: GOOD (  31.69  )
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

On 1/24/25 12:06, Mike Rapoport wrote:
> On Thu, Jan 23, 2025 at 03:16:28PM +0100, Petr Pavlu wrote:
>> On 1/21/25 10:57, Mike Rapoport wrote:
>>> In order to use execmem's API for temporal remapping of the memory
>>> allocated from ROX cache as writable, there is a need to distinguish
>>> between the state when the module is being formed and the state when it is
>>> deconstructed and freed so that when module_memory_free() is called from
>>> error paths during module loading it could restore ROX mappings.
>>>
>>> Replace open coded checks for MODULE_STATE_UNFORMED with a helper
>>> function module_is_formed() and add a new MODULE_STATE_GONE that will be
>>> set when the module is deconstructed and freed.
>>
>> I don't fully follow why this case requires a new module state. My
>> understanding it that the function load_module() has the necessary
>> context that after calling layout_and_allocate(), the updated ROX
>> mappings need to be restored. I would then expect the function to be
>> appropriately able to unwind this operation in case of an error. It
>> could be done by having a helper that walks the mappings and calls
>> execmem_restore_rox(), or if you want to keep it in module_memory_free()
>> as done in the patch #7 then a flag could be passed down to
>> module_deallocate() -> free_mod_mem() -> module_memory_free()?
> 
> Initially I wanted to track ROX <-> RW transitions in struct module_memory
> so that module_memory_free() could do the right thing depending on memory
> state. But that meant either ugly games with const'ness in strict_rwx.c,
> an additional helper or a new global module state. The latter seemed the
> most elegant to me.
> If a new global module state is really that intrusive, I can drop it in
> favor a helper that will be called from error handling paths. E.g.
> something like the patch below (on top of this series and with this patch
> reverted)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 7164cd353a78..4a02503836d7 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1268,13 +1268,20 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  	return 0;
>  }
>  
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
>  static void module_memory_free(struct module *mod, enum mod_mem_type type)
>  {
>  	struct module_memory *mem = &mod->mem[type];
>  
> -	if (mod->state == MODULE_STATE_UNFORMED && mem->is_rox)
> -		execmem_restore_rox(mem->base, mem->size);
> -
>  	execmem_free(mem->base);
>  }
>  
> @@ -2617,6 +2624,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  
>  	return 0;
>  out_err:
> +	module_memory_restore_rox(mod);
>  	for (t--; t >= 0; t--)
>  		module_memory_free(mod, t);
>  	if (codetag_section_found)
> @@ -3372,6 +3380,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  				       mod->mem[type].size);
>  	}
>  
> +	module_memory_restore_rox(mod);
>  	module_deallocate(mod, info);
>   free_copy:
>  	/*
>  

This looks better to me.

My view is that the module_state tracks major stages of a module during
its lifecycle. It provides information to the module loader itself,
other subsystems that need to closely interact with modules, and to the
userspace via the initstate sysfs attribute.

Adding a new state means potentially more complexity for all these
parts. In this case, the state was needed because of a logic that is
local only to the module loader, or even just to the function
load_module(). I think it is better to avoid adding a new state only for
that.

-- 
Thanks,
Petr


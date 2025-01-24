Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57633C02181
	for <linux-um@archiver.kernel.org>; Fri, 24 Jan 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UQWWJ4GUjFEA0dJ61qiJ0w7V+q7n1+jTTHCZ/wJ2aNI=; b=YBEAgI6lVJ4aqtLLkgIzNVauDU
	HIL0c62MQvbTYk9Y4/wR3N2NPXpMuKENvurYXJHUKIGghrac6TGx2VGcBj4y46h1/YczOURvz5bqz
	EleEt90/BujTkKVlzfElUlLqXbt+h1nWG9ffK5ei2eGnSope80vbVrCk2hyaigVaZd09XfDhYLLbU
	ah1hA9sG79uaJPwXh87xwpZZnfIYqQCiluKaS/LQqniMv1yliQU/M4/WNS0bIrJZI2lT82FkOyweX
	6nylQgIZwF0G4mZ7DPJB3jMndKwQjAflYKIQlxmHPPbqoEXaUwtoj9hikhz6n7hZ1qpBsgGaU0Kzl
	bH5FLlxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJpv-0000000Eklv-2dAc;
	Fri, 24 Jan 2025 13:35:03 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJps-0000000EkkO-2hY2
	for linux-um@lists.infradead.org;
	Fri, 24 Jan 2025 13:35:02 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-436341f575fso22301765e9.1
        for <linux-um@lists.infradead.org>; Fri, 24 Jan 2025 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737725698; x=1738330498; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQWWJ4GUjFEA0dJ61qiJ0w7V+q7n1+jTTHCZ/wJ2aNI=;
        b=BSne5kbep6E3JLi4Vv89CXRek0RlzJwEf7MczDfudoKu8qLB2usDFgEK2wkqHw8URx
         A+ZjqGVm6vAr89BIeNv30tehpnXzdWP6LxjLngHxcuki4IqAb+6ocsO7brkCmhwRsXKS
         rBM24RkUTQ49TntIpq8g5OadEWYEjpNvmCsshLeC4dX2zpzu0sCZ1QI3abW3ZEklk23x
         2I8aUDBwvsKRzemaBUkX2hFmp3qsf3HEOJGcncJnZ31/d9TGQo8KRK3/VaErPZ24mLZd
         z0cL4kU+adZYHH4rgUp4AcgbZQIrhkla2iRjzFLqkxfzzcAQqLPQkAG2zuIG8PE6kIrB
         XRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737725698; x=1738330498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQWWJ4GUjFEA0dJ61qiJ0w7V+q7n1+jTTHCZ/wJ2aNI=;
        b=H681AQMDP6thORsICgRPPLoJkTZvJNA7xeOeTNI3mm8wGjH6NiTQT3ET7+sJKiQHYM
         ebSb6ynFMTEj2EkPhBPGDLVPPhz3d/dI+13dK7e+ZWCH76SschYs0IdOiCRHxHtKm4hE
         9Ov7/smVX/qFVq2czEAraI0g3/OWF/bxo0Mp4C2XgAnnV9S+uobzVuYruUKs3DP3WNj2
         Q8z7XtHJE9XCtdVL8yW6/ZqUafn+4bn0KkaJ1hCnVAaz9/MJUmGyLc1wkdZsq3FOwrPc
         eGiB7HV64VlIki/Kf9hhs0uq5vbL7bcCh3+hYi4w4yXv7r5WWlDyX74w9ttB1v3xOctQ
         dZhg==
X-Forwarded-Encrypted: i=1; AJvYcCUBM943CafkZP5JrrZ0FpPruh0pAPGdFGpWEVh66gwuPDDKjWPn15/XcZ0NJSp8Rm3dm+5S1u1ZOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YylLlb7KVS9fQ7PX2Hd76Wb9TEC0Jcpny3ux6VCzw5qpOcrZclZ
	k9RLeT859c4JIfCP0pWvRNVlqOteAfIn3uf/q7ipt09wBiAEidthCFLZQkHpGks=
X-Gm-Gg: ASbGnctFclIucjzN85ZgxfN6Nim/qyDysYKslVfAkN52iUWrVmc43kP4xiDw0Sj4e0Q
	DjwxL/Oi+hn3LW69FtCS2wvmCsf6QhrECv/1dpLVckpbFzrKS2XlFc1Jhm2OelVAMBYomM8nQp4
	ErWC/nVb5QVhifD09DjrB5ScVmxIP3t4ne+2nEEKyyCa8oTTwYX+qc28uw/ksExN2/UaROb+8/9
	kwvtAPxIvwrMQDTop5h9cH/cD/X4deKh7IYl+NWNCNZjMuJZ1SGrxebOuFV+sNl0j3nsR/PfNsW
	78PLA6E=
X-Google-Smtp-Source: AGHT+IF3s4fU5+t8/f+hOsEy5Nf5bcm49sgfqQgftaIHUM1gK9rPTY+VC8hE4cREhJOWCxCt9EWOug==
X-Received: by 2002:a5d:64a3:0:b0:385:f909:eb2c with SMTP id ffacd0b85a97d-38bf57a77a2mr37468273f8f.38.1737725698250;
        Fri, 24 Jan 2025 05:34:58 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0besm2727227f8f.79.2025.01.24.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 05:34:57 -0800 (PST)
Date: Fri, 24 Jan 2025 14:34:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v2 06/10] module: introduce MODULE_STATE_GONE
Message-ID: <Z5OW_3dbdcZrNCgW@pathway.suse.cz>
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121095739.986006-7-rppt@kernel.org>
 <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com>
 <Z5N0UVLTJrrK8evM@kernel.org>
 <8c6972c4-c1bb-402a-a72d-f92b87ee5a89@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6972c4-c1bb-402a-a72d-f92b87ee5a89@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_053500_712468_E9817203 
X-CRM114-Status: GOOD (  42.24  )
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

On Fri 2025-01-24 13:59:55, Petr Pavlu wrote:
> On 1/24/25 12:06, Mike Rapoport wrote:
> > On Thu, Jan 23, 2025 at 03:16:28PM +0100, Petr Pavlu wrote:
> >> On 1/21/25 10:57, Mike Rapoport wrote:
> >>> In order to use execmem's API for temporal remapping of the memory
> >>> allocated from ROX cache as writable, there is a need to distinguish
> >>> between the state when the module is being formed and the state when it is
> >>> deconstructed and freed so that when module_memory_free() is called from
> >>> error paths during module loading it could restore ROX mappings.
> >>>
> >>> Replace open coded checks for MODULE_STATE_UNFORMED with a helper
> >>> function module_is_formed() and add a new MODULE_STATE_GONE that will be
> >>> set when the module is deconstructed and freed.
> >>
> >> I don't fully follow why this case requires a new module state. My
> >> understanding it that the function load_module() has the necessary
> >> context that after calling layout_and_allocate(), the updated ROX
> >> mappings need to be restored. I would then expect the function to be
> >> appropriately able to unwind this operation in case of an error. It
> >> could be done by having a helper that walks the mappings and calls
> >> execmem_restore_rox(), or if you want to keep it in module_memory_free()
> >> as done in the patch #7 then a flag could be passed down to
> >> module_deallocate() -> free_mod_mem() -> module_memory_free()?
> > 
> > Initially I wanted to track ROX <-> RW transitions in struct module_memory
> > so that module_memory_free() could do the right thing depending on memory
> > state. But that meant either ugly games with const'ness in strict_rwx.c,
> > an additional helper or a new global module state. The latter seemed the
> > most elegant to me.
> > If a new global module state is really that intrusive, I can drop it in
> > favor a helper that will be called from error handling paths. E.g.
> > something like the patch below (on top of this series and with this patch
> > reverted)
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 7164cd353a78..4a02503836d7 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -1268,13 +1268,20 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
> >  	return 0;
> >  }
> >  
> > +static void module_memory_restore_rox(struct module *mod)
> > +{
> > +	for_class_mod_mem_type(type, text) {
> > +		struct module_memory *mem = &mod->mem[type];
> > +
> > +		if (mem->is_rox)
> > +			execmem_restore_rox(mem->base, mem->size);
> > +	}
> > +}
> > +
> >  static void module_memory_free(struct module *mod, enum mod_mem_type type)
> >  {
> >  	struct module_memory *mem = &mod->mem[type];
> >  
> > -	if (mod->state == MODULE_STATE_UNFORMED && mem->is_rox)
> > -		execmem_restore_rox(mem->base, mem->size);
> > -
> >  	execmem_free(mem->base);
> >  }
> >  
> > @@ -2617,6 +2624,7 @@ static int move_module(struct module *mod, struct load_info *info)
> >  
> >  	return 0;
> >  out_err:
> > +	module_memory_restore_rox(mod);
> >  	for (t--; t >= 0; t--)
> >  		module_memory_free(mod, t);
> >  	if (codetag_section_found)
> > @@ -3372,6 +3380,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >  				       mod->mem[type].size);
> >  	}
> >  
> > +	module_memory_restore_rox(mod);
> >  	module_deallocate(mod, info);
> >   free_copy:
> >  	/*
> >  
> 
> This looks better to me.
> 
> My view is that the module_state tracks major stages of a module during
> its lifecycle. It provides information to the module loader itself,
> other subsystems that need to closely interact with modules, and to the
> userspace via the initstate sysfs attribute.
> 
> Adding a new state means potentially more complexity for all these
> parts. In this case, the state was needed because of a logic that is
> local only to the module loader, or even just to the function
> load_module(). I think it is better to avoid adding a new state only for
> that.

I fully agree here.

The added complexity is already visible in the original patch.
It updates about 15 locations where mod->state is checked.
Every location should be reviewed whether the change is correct.
The changes are spread in various subsystems, like kallsyms, kdb,
tracepoint, livepatch. Many people need to understand
the meaning of the new state and decide if the change is OK.
So, it affects many people and touches 15 locations where
things my go wrong.

The alternative solution, proposed above, looks much easier to me.

Best Regards,
Petr


Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3B9C52D7C
	for <linux-um@archiver.kernel.org>; Mon, 19 Aug 2024 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ie0bvC9ROJLnfutVE8C94bre2OY3y4q//fAPg+wLI0=; b=Zlh/faybJGYzNJtscPz8itLrZ2
	gS6cQ3JyDTxIAoc4EVziEUlb9oTdiDAEKBOlrkKJckYbHhSg5VfvtsVKUMXZ5uoY2pVASKEv9qO2H
	nHQfcVLTQislifT7RtpsMuwRMWNPWsSPyBjNB+0mxNe/O6ewelqMh99juy9IcWMn5QmlctlwKy1J/
	uqI2EWhMy9jhiNWrk8TUmLhyr0M8PuUaAT+Gz1Dz0MhhC97pFFT+0HIp1dzLYy+75mTeOwQ9LO0v5
	jS4/FPwdSXmWpxqYRPOuPkX8/deiu0bVuBsicIDm64FOY3SNprxf+3TweBa2SY3PwiUISmHEoH2UY
	UIYd5liQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg84l-00000002jO3-2d4H;
	Mon, 19 Aug 2024 19:29:59 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg84h-00000002jNH-3Wsv
	for linux-um@lists.infradead.org;
	Mon, 19 Aug 2024 19:29:57 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a864574429aso16102866b.0
        for <linux-um@lists.infradead.org>; Mon, 19 Aug 2024 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724095793; x=1724700593; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ie0bvC9ROJLnfutVE8C94bre2OY3y4q//fAPg+wLI0=;
        b=gopXeRQyyXOf6nXaYZSnVudHpSOSluPdfXzLrwnkydhaEvMsGgSNg+Ps+uWXNYSb3b
         n8WKgpLCPkwLKXSNQRVZn32A6bdw2YNvnJYEurFXvZ686d1h0P9g7/BcY1pMkiRK7T/A
         66baXOKqsJCjo9nzHbXWEXP6UNp8TKktTfkpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095793; x=1724700593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ie0bvC9ROJLnfutVE8C94bre2OY3y4q//fAPg+wLI0=;
        b=BcZYMrR1WGCBx0dXyeJw8x79MGfSN3rgR8bsD/zsDrmXSmNe0s2iA7Br6GhpkbZ9sq
         cr29CvspIMZdfSq2oAcC9jUbBivIhY/CTy5J4sddHytr8EWK0dldSJysQ8RBJDt2FjFF
         xMmuVR79Zo0rwrGisxxMOLK7BB/FoiF/MJ5DYsMTRuwMCuPHfVlrpi2M7l0M3hdDdlzE
         briJFTetchGvP5sB77qqJGGKiS5zJutdzt7AwjEcIdOrLBdJEuM+SH7btKf2i5u6lafZ
         Xia34Sypqhd8RfD48mi9rxPS9jTL6ftPKecDZ6e6Y0cEpBhvG55IkT1CW6CX98ALDr04
         0k8A==
X-Forwarded-Encrypted: i=1; AJvYcCUe1NotEtc9xRNSSo5yEyWUgA3tFYWea0Pnu6XQHVUngJv9l16yB/lx49u43uQ4f7oGLfbV3rBzvw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9KfjHx/mRClyyoa1z9UFQVzOQGXlf3oKIkgxl3FQzjFjtTf7e
	35fs4BmupnpP+j2atJanuR3ogh3t9qwlqmlCd4+dRRDqR/l1kN4xA0sNrP/NXM+XZ30dcO6J0ri
	JaXmbzQ==
X-Google-Smtp-Source: AGHT+IGS1A+VRBdF58Ze0c0Hsn2NXIXnaVhMzSE/aubtGtgqmjeacT8LTGpdTski9Rcd42EUvh+Dtg==
X-Received: by 2002:a17:907:efca:b0:a7d:33f0:4d58 with SMTP id a640c23a62f3a-a83929d2e13mr861247466b.48.1724095792772;
        Mon, 19 Aug 2024 12:29:52 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393456fsm674293066b.142.2024.08.19.12.29.51
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 12:29:51 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so3564573a12.2
        for <linux-um@lists.infradead.org>; Mon, 19 Aug 2024 12:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkAsvWM3StTdGF1d48KgB1VOIPuj3mfbQMexXEwaRtNtrR+gz0GOWF/3Cu0sCs4kIYBRMHicUofA==@lists.infradead.org
X-Received: by 2002:a05:6402:42d5:b0:5a2:68a2:ae52 with SMTP id
 4fb4d7f45d1cf-5beca26d2f5mr9265659a12.0.1724095790870; Mon, 19 Aug 2024
 12:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
In-Reply-To: <20240819185253.GA2333884@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 12:29:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
Message-ID: <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Nathan Chancellor <nathan@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_122956_288911_E438FB72 
X-CRM114-Status: GOOD (  19.55  )
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

On Mon, 19 Aug 2024 at 11:53, Nathan Chancellor <nathan@kernel.org> wrote:
>
>
> Modules linked in:
> Pid: 24, comm: mount Not tainted 6.11.0-rc4-next-20240819
> RIP: 0033:0x68006f6c
> RSP: 000000006c8bfc68  EFLAGS: 00010206
> RAX: 0000000068006f6c RBX: 0000000068a0aa18 RCX: 00000000600d8b09
> RDX: 0000000000000000 RSI: 0000000068a0aa18 RDI: 0000000068805120
> RBP: 000000006c8bfc70 R08: 0000000000000001 R09: 0000000068ae0308
> R10: 000000000000000e R11: ffffffffffffffff R12: 0000000000000001
> R13: 0000000068a0aa18 R14: 0000000000000015 R15: 0000000068944a88
> Kernel panic - not syncing: Segfault with no mm
> CPU: 0 UID: 0 PID: 24 Comm: mount Not tainted 6.11.0-rc4-next-20240819 #1
> Stack:
>  600caeff 6c8bfc90 600d8b2a 68944a80
>  00000047 6c8bfda0 600cbfd9 6c8bfd50
>  68944ad0 68944a88 7f7ffff000 7f7fffffff
> Call Trace:
>  [<600caeff>] ? special_mapping_close+0x16/0x19

Hmm. No "Code:" line? Did you just edit that out, or maybe UML doesn't
print one out?

Anyway, for me that special_mapping_close() disassembles to


 <+0>:  mov    %rdi,%rsi
 <+3>:  mov    0x78(%rdi),%rdi
 <+7>:  mov    0x20(%rdi),%rax
 <+11>: test   %rax,%rax
 <+14>: je     0x600caa11 <special_mapping_close+24>
 <+16>: push   %rbp
 <+17>: mov    %rsp,%rbp
 <+20>: call   *%rax
 <+22>: pop    %rbp
 <+23>: ret
 <+24>: ret

which may just match yours, because special_mapping_close+0x16 is
obviously that +22, and it's the return point for that call.

And your %rax value does match that invalid %rip value of 0x68006f6c.

So it does look like it's jumping off to la-la-land, and the problem is the code

        const struct vm_special_mapping *sm = vma->vm_private_data;

        if (sm->close)
                sm->close(sm, vma);

where presumably 'vm_private_data' isn't a "struct vm_special_mapping *" at all.

And I think I see the problem.

When we have that 'legacy_special_mapping_vmops', then the
vm_private_data field actually points to 'pages'.

So the 'legacy_special_mapping_vmops' can *only* contain the '.fault'
handler, not the other handlers.

IOW, does something like this fix it?

  --- a/mm/mmap.c
  +++ b/mm/mmap.c
  @@ -2095,7 +2095,6 @@ static const struct vm_operations_struct
special_mapping_vmops = {
   };

   static const struct vm_operations_struct legacy_special_mapping_vmops = {
  -       .close = special_mapping_close,
          .fault = special_mapping_fault,
   };

and honestly, we should have different 'fault' functions instead of
having the same fault function and then making the function
dynamically see which vm_operations_struct it was. But that's a
separate issue.

And oh Christ, the difference between "_install_special_mapping()"
(which installs the modern style special mapping) and
"install_special_mapping()" (which installs the legacy special
mapping) is truly horrendously disgusting.

And yes, UML uses that legacy crap, which explains why it happens on
UML but not on sane architectures.

As does csky, hexagon, and nios2.

We should get rid of the legacy case entirely, and remove that insane
difference between _install_special_mapping() and
install_special_mapping().

But in the meantime, the one-liner fix *should* fix it. The four
architectures that uses the legacy crud don't care about the close
function anyway.

What a horrid thing.

                Linus


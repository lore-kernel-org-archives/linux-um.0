Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5935ED6D248
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nnTmf55sYhSNQITgy96dBzEd9LDivANRpSrXSel0gsg=; b=ucTLozBqeXO4l3BFLh6fsYgdiO
	dP/IYwrofk8+w+gMkVnYnRK2+iKEK1RBv4uZ7SFOLFEaHXimC0WjJU0FWISO9KTlSre6s3MR2lo6S
	HhLX9a7CiBUHI+7S7Fl9DCKO2+sF2eDKIDM/NNkzUr6prdaS0AofNIh4rw6EAJ0XI/vtRPl+6LV7L
	Mv1U+u83WE+MeId2Et9WSXdSMgUqUhM1tQ2BjxlGQE/gQUV3u0TFHirmGjiWLTD/O/IXHBv0rBCz9
	Zveo2MyjD1ynzFJNjEJgmRbpOvj+PDrrk+RDuUbZnz4RCVpG8RdRTCxzSkBsQMOKyyppW+skhn4t6
	sIro1WoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGRNT-0000000EGRl-0nNE;
	Wed, 27 Nov 2024 23:23:23 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGRNQ-0000000EGRI-3a7F
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 23:23:21 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-724f42c1c38so285702b3a.1
        for <linux-um@lists.infradead.org>; Wed, 27 Nov 2024 15:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732749800; x=1733354600; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nnTmf55sYhSNQITgy96dBzEd9LDivANRpSrXSel0gsg=;
        b=hmJ9nPoObNgZXag2zfDBOfNUbqaz9fwveR3l+ov9p9naX8NtpeicahLDAh7TowabG+
         VzssZJ/YvTnxobxXnbf/KYfgPekLxqEBc9tYW+6bAweFcFB6OEl0PCtHFC+V3PlAHjza
         JjTVU53LcAjXwnoTCfFZi50UQ4AY+sFnNV+0HfCsh/V70Jz+aZpQET13SHX1PCisqdbp
         x/DnDlhKL27/Z6amV1W+6yMy6CFJ0ibf00yIB1qeBobKiyKOThSY50SGcXesv7ybpA3a
         YgztfRHNweK1rF08v1OW/QrY9KtE+CkaVyeVZuUr6dyvS8D7Q/w09cHHJCpAb0SsuB+E
         vbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732749800; x=1733354600;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnTmf55sYhSNQITgy96dBzEd9LDivANRpSrXSel0gsg=;
        b=TxSmvGfXLDR8YNBBj8h1f4DJXlLZP94N9JiKtC2RqY4zjggO+ZBMVXvY2OQM73jSu2
         GntHaUpTq1tqNFbD3ZN+dhk84sZc/sv0K51q1XGodBFs8sFv3hyhX7qRzua0e2MXbCeO
         gFljm2vDiFy1ISjpAIcrss3yMNdD5HWZp2imk/CVREAPM3ZXgoVo/ylE3usqyFHK7U2L
         guiCGUxVX9AO/hBPv6pAZcywZIqQt+Lcd1ipVzVhOIaZiR4SViYdlWnf5jauWaaS4rVK
         OhlrL50HK7FlWyv8C35QumqUy5rH3g6VXCkaLv+yZaj6bUWNqAR+Tw+ZWDOaD3tQOTtX
         JXSw==
X-Gm-Message-State: AOJu0YxNkGUcGTlOJU+oal2aWshyzuJxr+T0FVutQPwlZPBxbDS/x+TN
	CTQTKtOE4lvcUCw3uUYqU+4cbl1vYdvgxnutgSnqj0B/9R6kwJwr
X-Gm-Gg: ASbGncvme3wR0A5AvKm9bxsWz/lv486WdYvuXz9wcVPR3Iqn9DKIz1C6nrO+A7MgtXR
	y4jiQr+/AT0/aLNoQXBDBiHzd4GrLTNVAQAXr684fTE6Ac1kziL5hUf71mh+YKCJ3f0Sb2AMvCP
	KC5C72mjpR614UOmHOKzmcPZZrw4XyMwvhXV99k66T/kqkPnvCp8nUBenDwS70StKU7eCGFec1C
	g2cjlnNUDn7nWH6kSOfOyReA3+eSOurPnFkMdy+7zCCxS0VEgaT4bREnsMXC/Or9g2MyQnS99dp
	HlAHVowK4JW3Tuk9yjQb1EQjdAdF9+jqLKEo
X-Google-Smtp-Source: AGHT+IF6MdpON7LaM3dk+kNb5rdQchDNEMDOjL3doth56zlxi+KeNpKhxNAmzkdi41fZ4NGIa6laaw==
X-Received: by 2002:aa7:88c3:0:b0:71e:427a:68de with SMTP id d2e1a72fcca58-7253018309dmr7322541b3a.24.1732749799703;
        Wed, 27 Nov 2024 15:23:19 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761227sm128179b3a.28.2024.11.27.15.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:23:18 -0800 (PST)
Date: Thu, 28 Nov 2024 08:23:15 +0900
Message-ID: <m2o720w9b0.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [RFC PATCH v2 09/13] x86/um/vdso: nommu: vdso memory update
In-Reply-To: <1b825acd305578af2e2ad6c01ce5ef63482da68d.camel@sipsolutions.net>
References: <cover.1731290567.git.thehajime@gmail.com>
	<a00a498ea9803ac3c6f2b933203a2675d1785208.1731290567.git.thehajime@gmail.com>
	<1b825acd305578af2e2ad6c01ce5ef63482da68d.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_152320_893433_94D556EC 
X-CRM114-Status: GOOD (  21.75  )
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


Thanks Benjamin,

On Wed, 27 Nov 2024 19:36:44 +0900,
Benjamin Berg wrote:

> > @@ -51,9 +65,15 @@ __kernel_old_time_t
> > __vdso_time(__kernel_old_time_t *t)
> > =A0{
> > =A0	long secs;
> > =A0
> > +#ifdef CONFIG_MMU
> > =A0	asm volatile("syscall"
> > =A0		: "=3Da" (secs)
> > =A0		: "0" (__NR_time), "D" (t) : "cc", "r11", "cx",
> > "memory");
> > +#else
> > +	asm("call *%1"
> > +		: "=3Da" (secs)
> > +		: "0" ((unsigned long)__NR_time), "D" (t) : "cc",
> > "r11", "cx", "memory");
> > +#endif
>=20
> Maybe introduce a macro for "syscall" vs. "call *%1"? The parameters
> should be identical in both cases.

I think it's nice to clean up this part.

> The "call" could probably even jump
> to the end of the NOP ramp directly in this case.

ah, that would be a bit of speed ups.
confirmed that it works.  I'll update it if the code readability
doesn't become worse.

> Though maybe I am missing something with the "(unsigned long)" cast?

without this, gcc says

  CC      arch/x86/um/vdso/um_vdso.o
../arch/x86/um/vdso/um_vdso.c: Assembler messages:
../arch/x86/um/vdso/um_vdso.c:50: Error: operand size mismatch for `call'

so the cast intended to silence it.

but if I changed the constraint like below, the error is gone.

-		: "0" ((unsigned long)__NR_time), "D" (t) : "cc",
+		: "a" (__NR_time), "D" (t) : "cc",

I will clean it up as well.

> > =A0	return secs;
> > =A0}
> > diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
> > index f238f7b33cdd..83c861e2a815 100644
> > --- a/arch/x86/um/vdso/vma.c
> > +++ b/arch/x86/um/vdso/vma.c
> > @@ -9,6 +9,7 @@
> > =A0#include <asm/page.h>
> > =A0#include <asm/elf.h>
> > =A0#include <linux/init.h>
> > +#include <os.h>
> > =A0
> > =A0static unsigned int __read_mostly vdso_enabled =3D 1;
> > =A0unsigned long um_vdso_addr;
> > @@ -24,7 +25,9 @@ static int __init init_vdso(void)
> > =A0
> > =A0	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
> > =A0
> > +#ifdef CONFIG_MMU
> > =A0	um_vdso_addr =3D task_size - PAGE_SIZE;
> > +#endif
> > =A0
> > =A0	vdsop =3D kmalloc(sizeof(struct page *), GFP_KERNEL);
> > =A0	if (!vdsop)
> > @@ -40,6 +43,15 @@ static int __init init_vdso(void)
> > =A0	copy_page(page_address(um_vdso), vdso_start);
> > =A0	*vdsop =3D um_vdso;
> > =A0
> > +#ifndef CONFIG_MMU
> > +	/* this is fine with NOMMU as everything is accessible */
> > +	um_vdso_addr =3D (unsigned long)page_address(um_vdso);
> > +	os_protect_memory((void *)um_vdso_addr, vdso_end -
> > vdso_start, 1, 1, 1);
>=20
> I think this should be "1, 0, 1", i.e. we shouldn't enable write
> access.

not sure if this relates to but with PROT_WRITE off I cannot put a
breakpoint with gdb on vdso area.  normal execution (without gdb)
looks fine.


-- Hajime


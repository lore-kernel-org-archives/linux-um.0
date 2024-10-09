Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04584CEE35E
	for <linux-um@archiver.kernel.org>; Wed,  9 Oct 2024 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qr2NiDkTzchL8uGJCnEfJucVtKgbESvAiwuQEhcXyhg=; b=O3RR1zcKsNI7mXmmIp979cr+Qq
	P1naIEJmTsWPTjkbHRZe5jTrXT9TZOXky5W2g+9TBfMWKOg8bMGX5nu7pf4V+tQf3Z/wU2Jmv5xXK
	f8FBwtED0dkfDTO8+0YF4et4ejQxrEWPQTNzBUqltUSfs8RCgzhseMb/wRwY4CAlGgtlZNWmxEgfl
	8l4CCU37GSe8ZjvTYWThY/ZCn8ta3rDjLGj89yOy3h63Vq0p9P71hQsybRr3IT3+r9UTgauPUIz6F
	SyA990onYZ4cFhSbcjJlgqt4VKC5dzpKTgnfWCEWbRxe1a5V2kNDTHGKX2drFVKIcQH0pHaoKHh5/
	Y79tb/nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syf67-0000000AvAt-14V3;
	Wed, 09 Oct 2024 22:23:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syf62-0000000Av7m-2tPh;
	Wed, 09 Oct 2024 22:23:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 60F165C5E8C;
	Wed,  9 Oct 2024 22:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA60C4CEE6;
	Wed,  9 Oct 2024 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728512632;
	bh=w4l9dzDzlilO4E+6HL//zAT4zhaj8ld4amfc5zECEfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wiwa3rlrYH9BC46EoCHkt+QLbJoTT1X2QA01HAqIYKjAte3oUq44GaeL+zZ4AkJ2c
	 2fmhTarWCgJZzvugjgiXFaapdrUxRw+aMHjQkxk7R7tMQ4X8TAISQfJF8mwZjkVS1k
	 P8ckfmO9JeSeyS8x4lu0kJaTjkOtHpLIIPYKJmo4HQ1/9VWZa6uO3ff20ntiwcvv+8
	 WNsOi1fvz3WyQp8/mTsIKp1bTZX1Q46ddgghD/obeQF4nyOrExSGPC7njchLh/Wo1L
	 w8uAfe7NKlqBlMlX1oAMsBsi5zUdQStu0GaxZpBZ0z6hB0R3qZA3l0SEImsa2B3CEC
	 jNcMMmsZn1/Ag==
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-835393b3c05so7604539f.2;
        Wed, 09 Oct 2024 15:23:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSkXf07UpDGyfILkfcNCCQT0LMQuBaYWNOV1sVKItVx7kbYDUDZxTjetxkb4AkXCptbeK8MUZ/sUssuxs=@lists.infradead.org, AJvYcCVszufYXjXg3byF6Kt23WQrJ8MHhAEwLeBi4aCDY3Ng+zogcjypoI02xlhAbpcjIr4lhstm3Kan5SI6pqOuT4GW@lists.infradead.org, AJvYcCWsrs19qhcpt9FMO3kpz8m3BxSYzQTOIXHPlqnj8kiepnb7riPyTozTc6EBI1kg9Y8yYMZr58xcaR0szWjm9P8=@lists.infradead.org, AJvYcCXEPQWXYx/HHTBVqvdwLJG94zMftvEBsuAUe3d0/xab3HexFlQ0EoHyZ/3HXU6qI+BVirnuV9gflJk=@lists.infradead.org
X-Gm-Message-State: AOJu0Yz25K8Az+WDG1g/GU/krA6ynUvtGNAnqODDa865g57KDCfheFqV
	8kvqsiN/bM3Lxzrso81gCenLt9K5rCticQLlyl4saEbLAYbkDexYeS7J6dS33pIUFmWerO4797d
	tnARFVZq3nYdlclgJS+vPwyl0IBM=
X-Google-Smtp-Source: AGHT+IE+0c/kMVosLTSGHy+n6QvIYJcOAn6W5BXDQkMmjF/nhxZwOJHSZ6SOjh26Vu9mUcUiW0DFRwoy/+Y0vdg6KQk=
X-Received: by 2002:a05:6e02:1fe6:b0:3a0:aac2:a0a4 with SMTP id
 e9e14a558f8ab-3a397cffa21mr40549325ab.9.1728512631542; Wed, 09 Oct 2024
 15:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241009180816.83591-1-rppt@kernel.org> <20241009180816.83591-5-rppt@kernel.org>
In-Reply-To: <20241009180816.83591-5-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 9 Oct 2024 15:23:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com>
Message-ID: <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] module: prepare to handle ROX allocations for text
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_152354_904094_9D31BE7F 
X-CRM114-Status: GOOD (  13.33  )
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

On Wed, Oct 9, 2024 at 11:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
[...]
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 88ecc5e9f523..7039f609c6ef 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -367,6 +367,8 @@ enum mod_mem_type {
>
>  struct module_memory {
>         void *base;
> +       void *rw_copy;
> +       bool is_rox;
>         unsigned int size;

Do we really need to hold the rw_copy all the time? I was
thinking we only need a temporary buffer when we want to
update anything. The buffer might be much smaller than "size".

Thanks,
Song

[...]


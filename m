Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539ABC4321E
	for <linux-um@archiver.kernel.org>; Thu, 17 Nov 2022 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fq6z6IYseiPtukmmzL0CU6liKnEGczqEhIXz1i/blzI=; b=UKW5VtrotDt3Gl
	JBTDrxxbsDEKhy53CfhLeRlBoGDM26VYyYnjC6OS2Nqi5PIjDyWINw44/9prJhZ3C1asjwlKYvVs9
	EwANlm6poJ+FxTGdxQUoBc/y6F/0dmcb7VoUN3hSD1SFxCn6I7sXyu6WC1L4VAyZI0GEWhirWXUNu
	NH8w4EZSx41w8Swd8BOz4qIuLojaDBcwH71sPVqhOOKQxWiQ+sYu21vOBf3dAblpDbpqlJScCe9hz
	611U+no2U5x4eUlRvgYgs5AUK6ABmUyv9m8f0QbkKxw22fVVowZgyYPzHsv2eE/wPgBiQBNY+0D38
	ehspRZS88wJabUNE5Ajw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovoBD-000duQ-VX; Thu, 17 Nov 2022 23:20:24 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovoBB-000dtj-8o
	for linux-um@lists.infradead.org; Thu, 17 Nov 2022 23:20:23 +0000
Received: by mail-qk1-x734.google.com with SMTP id x21so2406274qkj.0
        for <linux-um@lists.infradead.org>; Thu, 17 Nov 2022 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Zl62KafxDJ8AwrDahi1bqb4Xk/32bDlmDdXpQC/2I=;
        b=McHst7l/f7KmgETncU4ax8Cz1+X0pDSSDz+NpOo85KKRbSTGF3eq2IAlrIRy/FELSJ
         Y7C0SIlyu5mGQyhzPLIjsCXMOXUrzD5TZH+dJcbaF2LHrVuVcof8hyWOL3D9pZZx4wAD
         8LINQRolzJh6QXumNwKV51jsDIdF9sMEo4+5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0Zl62KafxDJ8AwrDahi1bqb4Xk/32bDlmDdXpQC/2I=;
        b=Ae4X4Yq6HqHx9gVBtqqE059lycShAqCPY3eN/l+XZ4QA5811rLy/r+B+S+OSU0Cu0h
         7fZ4wON1mFYT9uQQoi261XIABiSvBYqzdjyW4/7WdoihEZduWJXKO+TwPxoq7T0cdzzc
         P3KUx5cRFkwQJ4UQ2/pka1uMSPxHh95Jerye7zilpWoaMjNzZYZkejzdKpDWk0OHMqIc
         iOSwMpLsEOgCjz3zy3Z1fssu7RNsgKFrQ4lN+ddT9Msv5is+aZ5sE2h7s0j8pAxN+OKg
         7sBMqLlQR+FBY6jVgWEd3EHvzQgipHwQvEx8nIuhpLN/izCLte8LDss0qj6O+ON/jkzk
         HWRg==
X-Gm-Message-State: ANoB5pmIELtcYy3NgOmP7XI6fcb68kKQt0riSmsu6CtkhhIUgzg1t3ht
	+AXvwAt3cDPVs+q6IB4/IL+Jp26BcWS0hA==
X-Google-Smtp-Source: AA0mqf59rEhRTemMYBkq58t1BDOQPSyTTb99LMiKqb6NzTEeI2twui5hm+Srm61nMpysL6Bj91IGpg==
X-Received: by 2002:a05:620a:1134:b0:6d8:4bda:e9 with SMTP id p20-20020a05620a113400b006d84bda00e9mr3824115qkk.236.1668727219206;
        Thu, 17 Nov 2022 15:20:19 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006ec771d8f89sm1345788qkb.112.2022.11.17.15.20.17
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 15:20:17 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id u7so2259006qvn.13
        for <linux-um@lists.infradead.org>; Thu, 17 Nov 2022 15:20:17 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr4665856qvp.129.1668727216978; Thu, 17
 Nov 2022 15:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20221116102659.70287-1-david@redhat.com> <20221116102659.70287-21-david@redhat.com>
 <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com> <202211171439.CDE720EAD@keescook>
In-Reply-To: <202211171439.CDE720EAD@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Nov 2022 15:20:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjykbz-4xVTWF7vkvGJnFoTSXNVeMzfsXaLnGm3CRd8rQ@mail.gmail.com>
Message-ID: <CAHk-=wjykbz-4xVTWF7vkvGJnFoTSXNVeMzfsXaLnGm3CRd8rQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
To: Kees Cook <keescook@chromium.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, 
	Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christoph Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Oleg Nesterov <oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_152021_734497_A1F76812 
X-CRM114-Status: GOOD (  14.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Nov 17, 2022 at 2:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> Oh, er, why does get_arg_page() even need FOLL_FORCE? This is writing the
> new stack contents to the nascent brpm->vma, which was newly allocated
> with VM_STACK_FLAGS, which an arch can override, but they all appear to include
> VM_WRITE | VM_MAYWRITE.

Yeah, it does seem entirely superfluous.

It's been there since the very beginning (although in that original
commit b6a2fea39318 it was there as a '1' to the 'force' argument to
get_user_pages()).

I *think* it can be just removed. But as long as it exists, it should
most definitely not be renamed to FOLL_PTRACE.

There's a slight worry that it currently hides some other setup issue
that makes it matter, since it's been that way so long, but I can't
see what it is.

             Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

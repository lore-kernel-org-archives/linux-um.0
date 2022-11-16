Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6374CC43217
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VHPu7q7q8Z2oDDFALKHLiDuSYNs7WK36BQUIWVLQ66I=; b=m3aC3DtElUAp7X
	9mLwY40vgm0TNH5VW1ThMJ6wW+vwdd0+Dkcanzlks+LyL6ewsRi/tcDQXRhBLR6LUZw9Z8f/TfpuR
	ab5FrYlqWPRtLw3ztp4WvqFcvz6nTe2hg/zfx74Y+fZTXMLSeZVHxiO0oHsDAOcAEnJ7aXD+NAdxI
	XxRJJpDhZRpTxtqXz14WutwaUAHFm59JUfT869GKgjopha14fA3JvSmRNFNX0FL+RQdKAlnqYdaS9
	ePi2Z+PAzMYvO+HLLEBgge5tyOBfFEC1fNbzRM7X44cbphPJgtqmocZf/+gIMWQjWHtqYmh62OAif
	rn+HSmEA0Cvse+JNwaUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMy3-006sKc-F6; Wed, 16 Nov 2022 18:16:59 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMxy-006sGq-Bq
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 18:16:57 +0000
Received: by mail-qk1-x731.google.com with SMTP id g10so12213861qkl.6
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 10:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBgZn+u117R7gFQNpsnvlIYlwSeo0LUTLoxlFKr3wyI=;
        b=eH0YS14VezMu1YoYc8i9L/9V4Rda12NtBPhbyEQG9con1K8dLIyV9b4KNCmIq0wzpX
         WqxRC9GRz2SSVMeoKLZbZ25GRVxvk4TLZwapfzc9KJm3PzFnUZgrmijMI3uqPEOn38/b
         +5K39+JbiCr6klzOuT84Gyzf87KIYKFM/ltfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBgZn+u117R7gFQNpsnvlIYlwSeo0LUTLoxlFKr3wyI=;
        b=QhRpJE28xgXDW5PH4bOCuHJIVI9nu3VBqHdc5V9grZtKHR7mVxAbZ1N5iqEil0PI+M
         bUHyTuGUW2ouxDNIa4IDDcNLhvp2W0UemSLrClrJ+2CXUWvJmAbVPTZqpsuiRxGYom6O
         ZXzpcc74qNOucF2knv7RfGwaFq4Rro9/EhiOklB38nUb7Ze6IPe6FfbUCqZ5l5eD+vOK
         C8qKREvfwLGoj89BduZ3rlIKmeP0wQRjsMkphFJZJUnNkIpk1X4AwwQCoyt5qaCMqibS
         QdVwfODYiTOT5oycPUhvDcd6z5htvYVIJ8bf4P9SU1gV0+YGzgWRCa3r4y6SC9cZXJZi
         b1sg==
X-Gm-Message-State: ANoB5pmnmhG/zEy/V29H9Tmz5QwrBwCvCCjkfx+/8kwfNSjGFzO3vab2
	ZMoSAvTtM5uIalUUjV31qM83ZA5NC3SdpQ==
X-Google-Smtp-Source: AA0mqf4TgTjAkOOiZOKVNsnLRUGX+SbagU5a2FsqXbddm/UYnOicP+Ey7A1vHu2gNbWAKg0X+rhHnw==
X-Received: by 2002:ae9:ebc7:0:b0:6ed:dd9c:3c5d with SMTP id b190-20020ae9ebc7000000b006eddd9c3c5dmr21040437qkg.454.1668622612448;
        Wed, 16 Nov 2022 10:16:52 -0800 (PST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a409000b006bb78d095c5sm10559852qko.79.2022.11.16.10.16.51
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 10:16:51 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id fz10so11232888qtb.3
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 10:16:51 -0800 (PST)
X-Received: by 2002:a05:622a:1c15:b0:3a5:49fa:3983 with SMTP id
 bq21-20020a05622a1c1500b003a549fa3983mr21860304qtb.436.1668622610752; Wed, 16
 Nov 2022 10:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20221116102659.70287-1-david@redhat.com> <20221116102659.70287-21-david@redhat.com>
In-Reply-To: <20221116102659.70287-21-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Nov 2022 10:16:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
Message-ID: <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
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
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_101654_456236_ED67255C 
X-CRM114-Status: GOOD (  17.34  )
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

On Wed, Nov 16, 2022 at 2:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's make it clearer that functionality provided by FOLL_FORCE is
> really only for ptrace access.

I'm not super-happy about this one.

I do understand the "let's rename the bit so that no new user shows up".

And it's true that the main traditional use is ptrace.

But from the patch itself it becomes obvious that no, it's not *just*
ptrace. At least not yet.

It's used for get_arg_page(), which uses it to basically look up (and
install) pages in the newly created VM.

Now, I'm not entirely sure why it even uses FOLL_FORCE, - I think it
might be historical, because the target should always be the new stack
vma.

Following the history of it is a big of a mess, because there's a
number of renamings and re-organizations, but it seems to go back to
2007 and commit b6a2fea39318 ("mm: variable length argument support").

Before that commit, we kept our own array of "this is the set of pages
that I will install in the new VM". That commit basically just inserts
the pages directly into the VM instead, getting rid of the array size
limitation.

So at a minimum, I think that FOLL_FORCE would need to be removed
before any renaming to FOLL_PTRACE, because that's not some kind of
small random case.

It *might* be as simple as just removing it, but maybe there's some
reason for having it that I don't immediately see.

There _are_ also small random cases too, like get_cmdline(). Maybe
that counts as ptrace, but the execve() case most definitely does not.

                Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

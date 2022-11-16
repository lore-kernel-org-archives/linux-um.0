Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B44C433FE
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hBNs0fCA1YSVZR+Dv+5/WhJSk6WUBPQwp43JCvn8T0E=; b=pba35BWKvTU7hm
	Scsw9unVeWIIL2Wy+/3A5JNatHmRKMVmepLiI4Vm5EwyCtMr6QRgiL5ebxZNSLjOuWVbWYloe1N9r
	HU975kiLpPvtJP29iZ5SoI9I5J9bM7hjibUHMn2+Rki3HWtTrCm5ZSzQr8Lxxct9AwyjiSaGYl9M2
	lbcQxyj8WeCbNYvlcqr5SrPt0H/IKaIaC2o0lO+OJaRVuUggNRGkGONKtyLmMIR7cFaY25S8lJAN+
	apA1ayfV8WUpv2kcfdU3043hdI3iRJyLfqYJMmMgbdZiPQvQg4qszCILM23m2/4vW38Ekbd08GfFD
	oyU19wBZ3mKxzmH5WIVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNY1-007HZq-On; Wed, 16 Nov 2022 18:54:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNXy-007HXU-Ej
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 18:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668624843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrMOrTfFoolcBWY273BC4KVOqyrI8gbytsgZlItRSSY=;
	b=ggnk2mNlajTLNaTYtTEVAXXL1mzLcneUkdkTzCipHOe8bpGYR81K2i0Q1IZkJzxzD6loT0
	VKwyQr+j6YAkRE5woCv3D8UX+LCBDyk//mZqtobHn5uAEz5dmYpkCGrHnFc1bjg5+yePtM
	ZHKhMPO4da92jOYTzViClXv0S4S0ri8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-_JKUVjLsNxeWJPodHqboEg-1; Wed, 16 Nov 2022 13:54:02 -0500
X-MC-Unique: _JKUVjLsNxeWJPodHqboEg-1
Received: by mail-wr1-f72.google.com with SMTP id r4-20020adfbb04000000b00236639438e9so4062520wrg.11
        for <linux-um@lists.infradead.org>; Wed, 16 Nov 2022 10:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrMOrTfFoolcBWY273BC4KVOqyrI8gbytsgZlItRSSY=;
        b=NeOUA7aJQOAB09PFct1E3bLQLEGvWudZtRhXn55c6KGYm6RLYUOiACCH1pZxPnXSSz
         rJZRKvFnaVkv3yyYe3/xu2NCMC1DGUnBFPRZKeYXg5j5XGFJswi69eBQpz22zgULucC4
         0h9EzlpyNkqXboY3mXjeH/5NLoeiJWYGjL5dtVXrjPHlB1NOUp0V29eWynMi/YBbFd8q
         NjVTmTGgZzShMXYzeC4WQS6iZK0lka3jQvh8I/7n3Hgww14q5autyTeWhAYV5Fbdq2gH
         9O24CiY0vUYE8uofNPuJasqJFHX6gx/xJRIspVXzUXzC1TJNqO3RsMEZwWzcOEa0kzr+
         ML0Q==
X-Gm-Message-State: ANoB5pnH8FuTM7AuzHjHef+iS8Uj069Wmp84NQ8Xjh2ZUlCFsMrhEwEJ
	0K48RZ4e0365O3kUrWNxYmWJw2oQiIfrywS8oAZEO2mcd5ehxv9TPD86/7fQpC28qVs7gWi78+K
	KdPNNsnxUaYZDoGMcS2D+1Z3B
X-Received: by 2002:a05:600c:188a:b0:3cf:8e62:f769 with SMTP id x10-20020a05600c188a00b003cf8e62f769mr3135358wmp.52.1668624841281;
        Wed, 16 Nov 2022 10:54:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5DCp6F6fiXltcSvKkMYb+ZcNvwNu+I48re+Q7o+sjDMiBTT1rVi2cU7FL82kIKKDnPvsKEPw==
X-Received: by 2002:a05:600c:188a:b0:3cf:8e62:f769 with SMTP id x10-20020a05600c188a00b003cf8e62f769mr3135302wmp.52.1668624841029;
        Wed, 16 Nov 2022 10:54:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003cff309807esm3012333wmo.23.2022.11.16.10.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 10:54:00 -0800 (PST)
Message-ID: <caf52607-49cd-3073-ca4a-ddce9509e7c9@redhat.com>
Date: Wed, 16 Nov 2022 19:53:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
 Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>, Oleg Nesterov
 <oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-21-david@redhat.com>
 <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
In-Reply-To: <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_105406_580504_4FAE4B34 
X-CRM114-Status: GOOD (  29.32  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 16.11.22 19:16, Linus Torvalds wrote:
> On Wed, Nov 16, 2022 at 2:30 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's make it clearer that functionality provided by FOLL_FORCE is
>> really only for ptrace access.
> 
> I'm not super-happy about this one.
> 
> I do understand the "let's rename the bit so that no new user shows up".
> 
> And it's true that the main traditional use is ptrace.
> 
> But from the patch itself it becomes obvious that no, it's not *just*
> ptrace. At least not yet.
> 
> It's used for get_arg_page(), which uses it to basically look up (and
> install) pages in the newly created VM.
> 
> Now, I'm not entirely sure why it even uses FOLL_FORCE, - I think it
> might be historical, because the target should always be the new stack
> vma.
> 
> Following the history of it is a big of a mess, because there's a
> number of renamings and re-organizations, but it seems to go back to
> 2007 and commit b6a2fea39318 ("mm: variable length argument support").
> 

Right.

> Before that commit, we kept our own array of "this is the set of pages
> that I will install in the new VM". That commit basically just inserts
> the pages directly into the VM instead, getting rid of the array size
> limitation.
> 
> So at a minimum, I think that FOLL_FORCE would need to be removed
> before any renaming to FOLL_PTRACE, because that's not some kind of
> small random case.
> 
> It *might* be as simple as just removing it, but maybe there's some
> reason for having it that I don't immediately see.

Right, I have the same feeling. It might just be a copy-and-paste legacy 
leftover.

> 
> There _are_ also small random cases too, like get_cmdline(). Maybe
> that counts as ptrace, but the execve() case most definitely does not.

I agree. I'd suggest moving forward without this (last) patch for now 
and figuring out how to further cleanup FOLL_FORCE usage on top.

@Andrew, if you intend to put this into mm-unstable, please drop the 
last patch for now.

-- 
Thanks,

David / dhildenb


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

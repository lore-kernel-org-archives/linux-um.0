Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <ff750d43-fda1-7330-f9ec-3a03bb0e10da@linux.intel.com>
Date: Sat, 28 May 2022 18:10:48 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] x86: Optimize memchr() for x86-64
Content-Language: en-US
References: <20220528081236.3020-1-arthurchang09@gmail.com>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220528081236.3020-1-arthurchang09@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Yu-Jen Chang <arthurchang09@gmail.com>, jdike@linux.intel.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, keescook@chromium.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org, jserv@ccns.ncku.edu.tw
List-ID: <linux-um.lists.infradead.org>


On 5/28/2022 1:12 AM, Yu-Jen Chang wrote:
> *** BLURB HERE ***
> These patch series add an optimized "memchr()" for x86-64 and
> USER-MODE LINUX (UML).
>   
> There exists an assemebly implementation for x86-32. However,
> for x86-64, there isn't any optimized version. We implement word-wise
> comparison so that 8 characters can be compared at the same time on
> x86-64 CPU. The optimized “memchr()” is nearly 4x faster than the
> orginal implementation for long strings.
>
> We test the optimized “memchr()” in UML and also recompile the 5.18
> Kernel with the optimized “memchr()”. They run correctly.
>
> In this patch we add a new file "string_64.c", which only contains
> "memchr()". We can add more optimized string functions in it in the
> future.

Are there any workloads that care? From a quick grep I don't see any 
that look performance critical.

It would be good to describe what you optimized it for. For example 
optimization for small input strings is quite different than large 
strings. I don't know what is more common in the kernel.

I assume you ran it through some existing test suites for memchr (like 
glibc etc.) for correctness testing?

(bugs in optimized string functions are often subtle, it might be also 
worth trying some randomized testing comparing against a known reference)

-Andi



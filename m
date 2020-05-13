Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www62.your-server.de ([213.133.104.62])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ0jf-0008R7-40
 for linux-um@lists.infradead.org; Wed, 13 May 2020 23:24:24 +0000
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de>
 <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <CAHk-=wiivWJ70PotzCK-j7K4Y612NJBA2d+iN6Rz-bfMxCpwjQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2a03633b-419d-643f-b787-ca1520e2229b@iogearbox.net>
Date: Thu, 14 May 2020 01:24:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiivWJ70PotzCK-j7K4Y612NJBA2d+iN6Rz-bfMxCpwjQ@mail.gmail.com>
Content-Language: en-US
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org, linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bgregg@netflix.com, Christoph Hellwig <hch@lst.de>

On 5/14/20 1:03 AM, Linus Torvalds wrote:
> On Wed, May 13, 2020 at 3:36 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> It's used for both.
> 
> Daniel, BPF real;ly needs to make up its mind about that.
> 
> You *cannot* use ti for both.
> 
> Yes, it happens to work on x86 and some other architectures.
> 
> But on other architectures, the exact same pointer value can be a
> kernel pointer or a user pointer.

Right, it has the same issue as with the old probe helper. I was merely stating that
there are existing users (on x86) out there that use it this way, even though broken
generally.

>> Given this is enabled on pretty much all program types, my
>> assumption would be that usage is still more often on kernel memory than user one.
> 
> You need to pick one.
> 
> If you know it is a user pointer, use strncpy_from_user() (possibly
> with disable_pagefault() aka strncpy_from_user_nofault()).
> 
> And if you know it is a kernel pointer, use strncpy_from_unsafe() (aka
> strncpy_from_kernel_nofault()).
> 
> You really can't pick the "randomly one or the other guess what I mean " option.

My preference would be to have %s, %sK, %sU for bpf_trace_printk() where the latter two
result in an explicit strncpy_from_kernel_nofault() or strncpy_from_user_nofault()
choice while the %s is converted as per your suggestion and it would still allow for a
grace period to convert existing users to the new variants, similar with what we did on
the bpf_probe_read_kernel() and bpf_probe_read_user() helpers to get this sorted out.

Thanks,
Daniel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


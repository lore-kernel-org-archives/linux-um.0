Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www62.your-server.de ([213.133.104.62])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZB0E-00041u-MF
 for linux-um@lists.infradead.org; Thu, 14 May 2020 10:22:12 +0000
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de>
 <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
 <20200513232816.GZ23230@ZenIV.linux.org.uk>
 <866cbe54-a027-04eb-65db-c6423d16b924@iogearbox.net>
 <6ca8d8499bf644aba0b242d194df5a60@AcuMS.aculab.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2cc83197-3ecc-b8c2-742d-e953c1f7bf8c@iogearbox.net>
Date: Thu, 14 May 2020 12:21:52 +0200
MIME-Version: 1.0
In-Reply-To: <6ca8d8499bf644aba0b242d194df5a60@AcuMS.aculab.com>
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
To: David Laight <David.Laight@ACULAB.COM>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "bgregg@netflix.com" <bgregg@netflix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On 5/14/20 12:01 PM, David Laight wrote:
[...]
> If it's not a stupid question why is a BPF program allowed to get
> into a situation where it might have an invalid kernel address.
> 
> It all stinks of a hole that allows all of kernel memory to be read
> and copied to userspace.
> 
> Now you might want to something special so that BPF programs just
> abort on OOPS instead of possibly paniking the kernel.
> But that is different from a copy that expects to be passed garbage.

I suggest you read up on probe_kernel_read() and its uses in tracing in
general, looks like you haven't done that.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


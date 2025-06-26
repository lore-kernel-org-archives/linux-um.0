Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DE9C7EE2A
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7UPnXPOsKjZ5D5zwf0F2OFekl8t3GTKb3x0lbpqe5PQ=; b=PZEbOsAAf5odyuXjqI/3oppZ9r
	CnxoAorqxVx6Oc4a3Qibw6YWqJNjCqqGZOJwXTXQzKSw+SIGyQigiEGXUOPOaxj1JBOyLahDPLw0Y
	8vHVtgXWQ0tEHi4fknQXb0fEKxcin7r7cb+kjXp2FBbLIslDWggatcxxm6onw0v9fLcQlihVPtFqZ
	zgJt1uy9mFeiGBtZlyhOaBMFUcp2F9Nv5TWZnaCfHKu0dS7fDffXV+9ygfVXy+bzU0c0k+OkkAR/V
	+f3RwUwI3XNa2wRwkVbHiWjS9XXLMKSH45nLUMbMbklnWEwQcT78Oazg/cl5jLpVhuqdReD4kpVji
	xfBZ5SoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUctE-0000000AVBo-1lwC;
	Thu, 26 Jun 2025 03:03:04 +0000
Received: from out0-209.mail.aliyun.com ([140.205.0.209])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUcbk-0000000AToV-1BpP
	for linux-um@lists.infradead.org;
	Thu, 26 Jun 2025 02:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750905892; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7UPnXPOsKjZ5D5zwf0F2OFekl8t3GTKb3x0lbpqe5PQ=;
	b=lzYKmA8Rro3RCfMZRQx13tYum1AFYvM/poAfpt8pzJh+HyQpVrhu7vNs3/wiu0KrhIEMDl4TLm+TYLSyAITK60zH+H5HFABxv1QZR5CerTz2rFmc79Ci3pUUmYZu5uIqEmTIplzU2vHZn/spFHzPRBf3y0A0GUCIEdCyqpGIBEg=
Received: from 30.174.116.235(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dWuvC4m_1750905882 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Jun 2025 10:44:49 +0800
Message-ID: <0d630dec-41fe-4968-8d6a-7faae8a554a1@antgroup.com>
Date: Thu, 26 Jun 2025 10:44:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] uml-for-6.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <20250625121529.42911-3-johannes@sipsolutions.net>
 <CAHk-=wjTCAzaw4AXXpxcYc7v7ZjAeyaOOJw7FWXO+gV7v7Cp0g@mail.gmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <CAHk-=wjTCAzaw4AXXpxcYc7v7ZjAeyaOOJw7FWXO+gV7v7Cp0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_194500_854275_3EBACBB2 
X-CRM114-Status: GOOD (  12.84  )
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

On 2025/6/26 02:17, Linus Torvalds wrote:
> On Wed, 25 Jun 2025 at 05:15, Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>>  - reduce stack use with clang 19
> 
> Interesting. The patch looks fine, I'm wondering if people made a
> clang bug report about this behavior with structure assignments?
> 
> Even if most other projects likely don't have issues with stack size,
> it looks very non-optimal from a performance standpoint too to create
> a pointless temporary copy on the stack.
> 
> I assume - but didn't check - that gcc didn't do the same stupid thing
> for that code?

The behavior of gcc and clang differs. Clang's behavior appears to be
related to the volatile qualifier in arch_spinlock_t:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/spinlock_types_up.h?id=b555cb66583e99158cfef8e91c025252cefae55b#n18

It can be reproduced with this code snippet:

```c
struct foo {
	char a;
	volatile char b;
	char c[512];
};

char bar(void);
void baz(struct foo *p);

void baz(struct foo *p)
{
	*p = (struct foo) { .a = bar() };
}
```

$ clang-19 --version
Ubuntu clang version 19.1.7 (++20250114103320+cd708029e0b2-1~exp1~20250114103432.75)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-19/bin
$ clang-19 -O2 -c test.c
$ objdump -dr ./test.o

./test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <baz>:
   0:	41 56                	push   %r14
   2:	53                   	push   %rbx
   3:	48 81 ec 18 02 00 00 	sub    $0x218,%rsp
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	4c 8d 74 24 10       	lea    0x10(%rsp),%r14
  12:	ba 01 02 00 00       	mov    $0x201,%edx
  17:	4c 89 f7             	mov    %r14,%rdi
  1a:	31 f6                	xor    %esi,%esi
  1c:	e8 00 00 00 00       	call   21 <baz+0x21>
			1d: R_X86_64_PLT32	memset-0x4
  21:	e8 00 00 00 00       	call   26 <baz+0x26>
			22: R_X86_64_PLT32	bar-0x4
  26:	88 44 24 0f          	mov    %al,0xf(%rsp)
  2a:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
  2f:	88 03                	mov    %al,(%rbx)
  31:	48 ff c3             	inc    %rbx
  34:	ba 01 02 00 00       	mov    $0x201,%edx
  39:	48 89 df             	mov    %rbx,%rdi
  3c:	4c 89 f6             	mov    %r14,%rsi
  3f:	e8 00 00 00 00       	call   44 <baz+0x44>
			40: R_X86_64_PLT32	memcpy-0x4
  44:	48 81 c4 18 02 00 00 	add    $0x218,%rsp
  4b:	5b                   	pop    %rbx
  4c:	41 5e                	pop    %r14
  4e:	c3                   	ret    


$ clang --version
Ubuntu clang version 14.0.0-1ubuntu1.1
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
$ clang -O2 -c test.c
$ objdump -dr ./test.o

./test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <baz>:
   0:	41 56                	push   %r14
   2:	53                   	push   %rbx
   3:	48 81 ec 18 02 00 00 	sub    $0x218,%rsp
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	4c 8d 74 24 10       	lea    0x10(%rsp),%r14
  12:	ba 01 02 00 00       	mov    $0x201,%edx
  17:	4c 89 f7             	mov    %r14,%rdi
  1a:	31 f6                	xor    %esi,%esi
  1c:	e8 00 00 00 00       	call   21 <baz+0x21>
			1d: R_X86_64_PLT32	memset-0x4
  21:	e8 00 00 00 00       	call   26 <baz+0x26>
			22: R_X86_64_PLT32	bar-0x4
  26:	88 44 24 0f          	mov    %al,0xf(%rsp)
  2a:	8a 44 24 0f          	mov    0xf(%rsp),%al
  2e:	88 03                	mov    %al,(%rbx)
  30:	48 83 c3 01          	add    $0x1,%rbx
  34:	ba 01 02 00 00       	mov    $0x201,%edx
  39:	48 89 df             	mov    %rbx,%rdi
  3c:	4c 89 f6             	mov    %r14,%rsi
  3f:	e8 00 00 00 00       	call   44 <baz+0x44>
			40: R_X86_64_PLT32	memcpy-0x4
  44:	48 81 c4 18 02 00 00 	add    $0x218,%rsp
  4b:	5b                   	pop    %rbx
  4c:	41 5e                	pop    %r14
  4e:	c3                   	ret    


$ gcc --version
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
$ gcc -O2 -c test.c
$ objdump -dr ./test.o

./test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <baz>:
   0:	f3 0f 1e fa          	endbr64 
   4:	53                   	push   %rbx
   5:	48 89 fb             	mov    %rdi,%rbx
   8:	e8 00 00 00 00       	call   d <baz+0xd>
			9: R_X86_64_PLT32	bar-0x4
   d:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  11:	48 89 d9             	mov    %rbx,%rcx
  14:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  1b:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
  1f:	41 89 c0             	mov    %eax,%r8d
  22:	31 c0                	xor    %eax,%eax
  24:	48 c7 83 fa 01 00 00 	movq   $0x0,0x1fa(%rbx)
  2b:	00 00 00 00 
  2f:	48 29 f9             	sub    %rdi,%rcx
  32:	81 c1 02 02 00 00    	add    $0x202,%ecx
  38:	c1 e9 03             	shr    $0x3,%ecx
  3b:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  3e:	44 88 03             	mov    %r8b,(%rbx)
  41:	5b                   	pop    %rbx
  42:	c3                   	ret    


After 's/volatile char b;/char b;/', clang-19 produces:

./test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <baz>:
   0:	53                   	push   %rbx
   1:	48 89 fb             	mov    %rdi,%rbx
   4:	e8 00 00 00 00       	call   9 <baz+0x9>
			5: R_X86_64_PLT32	bar-0x4
   9:	88 03                	mov    %al,(%rbx)
   b:	48 ff c3             	inc    %rbx
   e:	ba 01 02 00 00       	mov    $0x201,%edx
  13:	48 89 df             	mov    %rbx,%rdi
  16:	31 f6                	xor    %esi,%esi
  18:	5b                   	pop    %rbx
  19:	e9 00 00 00 00       	jmp    1e <baz+0x1e>
			1a: R_X86_64_PLT32	memset-0x4

Regards,
Tiwei


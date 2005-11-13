Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbRKg-0001UE-Ay for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 15:32:22 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EbRKf-00077g-QO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 15:32:22 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<20051113193256.GA25736@ccure.user-mode-linux.org>
	<200511132020.01596.blaisorblade@yahoo.it>
In-Reply-To: <200511132020.01596.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511131732.11279.rob@landley.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 13 Nov 2005 17:32:10 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

On Sunday 13 November 2005 13:20, Blaisorblade wrote:
> On Sunday 13 November 2005 20:32, Jeff Dike wrote:
> > On Sat, Nov 12, 2005 at 07:36:41PM -0600, Rob Landley wrote:
> > > Stub registers -
> > >         0 - 9090909090909090
> > >         1 - 9090909090909090
> > >         2 - 9090909090909090
> > >         3 - 9090909090909090
> > >         4 - 9090909090909090
> > >         5 - 9090909090909090
> > >         6 - 9090909090909090
> > >         7 - 9090909090909090
> > >         8 - 9090909090909090
> > >         9 - 9090909090909090
> > >         10 - 0
> > >         11 - 9090909090909090
> > >         12 - 9090909090909090
> > >         13 - 9090909090909090
> > >         14 - 9090909090909090
> > >         15 - ffffffffffffffff
> > >         16 - 9090909090909090
> > >         17 - 33
> > >         18 - 292
> > >         19 - 9090909090909090
> > >         20 - 2b
> >
> > I remain baffled by this.  There is nothing valid there.  At the very
> > least RSP and RIP should be reasonable, and they're not.
>
> Jeff, given the current state, I think that we need a look at the
> disassembly - or better:
> *) build a 2.6.15-rc1 binary with Rob's config.
> *) test that it works
> *) send him and see if it works for him
> *) finally, conclude GCC is misassembling stuff and take measures for this
> case.
>
> Meanwhile, Rob, can you provide the disassembly? We need to look at
> disassembled arch/um/sys-x86_64/stub_segv.c arch/um/kernel/skas/clone.c,
> i.e. stub_segv_handler() and stub_clone_handler().


00000000600c5150 <stub_segv_handler>:
    600c5150:   48 89 d1                mov    %rdx,%rcx
    600c5153:   48 ba 00 f0 ff bf 7f    mov    $0x7fbffff000,%rdx
    600c515a:   00 00 00
    600c515d:   48 8b 81 d8 00 00 00    mov    0xd8(%rcx),%rax
    600c5164:   48 89 42 08             mov    %rax,0x8(%rdx)
    600c5168:   8b 81 c0 00 00 00       mov    0xc0(%rcx),%eax
    600c516e:   89 02                   mov    %eax,(%rdx)
    600c5170:   8b 81 c8 00 00 00       mov    0xc8(%rcx),%eax
    600c5176:   89 42 10                mov    %eax,0x10(%rdx)
    600c5179:   48 c7 c0 27 00 00 00    mov    $0x27,%rax
    600c5180:   0f 05                   syscall
    600c5182:   48 89 c7                mov    %rax,%rdi
    600c5185:   48 c7 c0 3e 00 00 00    mov    $0x3e,%rax
    600c518c:   48 c7 c6 0a 00 00 00    mov    $0xa,%rsi
    600c5193:   0f 05                   syscall
    600c5195:   48 89 cc                mov    %rcx,%rsp
    600c5198:   48 c7 c0 0f 00 00 00    mov    $0xf,%rax
    600c519f:   0f 05                   syscall
    600c51a1:   c3                      retq

00000000600c5000 <stub_clone_handler>:
    600c5000:   41 57                   push   %r15
    600c5002:   41 56                   push   %r14
    600c5004:   41 55                   push   %r13
    600c5006:   41 54                   push   %r12
    600c5008:   41 bc 38 00 00 00       mov    $0x38,%r12d
    600c500e:   55                      push   %rbp
    600c500f:   48 bd 00 f0 ff bf 7f    mov    $0x7fbffff000,%rbp
    600c5016:   00 00 00
    600c5019:   53                      push   %rbx
    600c501a:   bb 11 84 00 00          mov    $0x8411,%ebx
    600c501f:   48 83 ec 08             sub    $0x8,%rsp
    600c5023:   e8 70 83 f4 ff          callq  6000d398 <getpagesize@plt>
    600c5028:   48 89 df                mov    %rbx,%rdi
    600c502b:   89 c6                   mov    %eax,%esi
    600c502d:   41 89 c0                mov    %eax,%r8d
    600c5030:   48 b8 f8 ef ff bf 7f    mov    $0x7fbfffeff8,%rax
    600c5037:   00 00 00
    600c503a:   c1 ee 1f                shr    $0x1f,%esi
    600c503d:   42 8d 34 06             lea    (%rsi,%r8,1),%esi
    600c5041:   d1 fe                   sar    %esi
    600c5043:   48 63 f6                movslq %esi,%rsi
    600c5046:   48 01 c6                add    %rax,%rsi
    600c5049:   4c 89 e0                mov    %r12,%rax
    600c504c:   0f 05                   syscall
    600c504e:   48 85 c0                test   %rax,%rax
    600c5051:   48 89 c3                mov    %rax,%rbx
    600c5054:   75 78                   jne    600c50ce <stub_clone_handler+0xce>
    600c5056:   b8 65 00 00 00          mov    $0x65,%eax
    600c505b:   48 89 df                mov    %rbx,%rdi
    600c505e:   48 89 de                mov    %rbx,%rsi
    600c5061:   48 89 da                mov    %rbx,%rdx
    600c5064:   49 89 da                mov    %rbx,%r10
    600c5067:   0f 05                   syscall
    600c5069:   48 85 c0                test   %rax,%rax
    600c506c:   48 89 c3                mov    %rax,%rbx
    600c506f:   75 5d                   jne    600c50ce <stub_clone_handler+0xce>
    600c5071:   b8 26 00 00 00          mov    $0x26,%eax
    600c5076:   bf 01 00 00 00          mov    $0x1,%edi
    600c507b:   48 be 10 f0 ff bf 7f    mov    $0x7fbffff010,%rsi
    600c5082:   00 00 00
    600c5085:   48 89 da                mov    %rbx,%rdx
    600c5088:   0f 05                   syscall
    600c508a:   48 85 c0                test   %rax,%rax
    600c508d:   48 89 c3                mov    %rax,%rbx
    600c5090:   75 3c                   jne    600c50ce <stub_clone_handler+0xce>
    600c5092:   a1 08 f0 ff bf 7f 00    mov    0x7fbffff008,%eax
    600c5099:   00 00

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

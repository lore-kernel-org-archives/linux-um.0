Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTQEA-0008VQ-9J
 for linux-um@lists.infradead.org; Thu, 14 Jun 2018 11:15:44 +0000
Received: by mail-wm0-x231.google.com with SMTP id v16-v6so9866436wmh.5
 for <linux-um@lists.infradead.org>; Thu, 14 Jun 2018 04:15:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d5c8646bf909902b1f4a0f593ab3832ed399f9c1.camel@researchut.com>
References: <eabf7e000bc0227fa6a7a74a23512cc11b84206a.camel@researchut.com>
 <d5c8646bf909902b1f4a0f593ab3832ed399f9c1.camel@researchut.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 14 Jun 2018 13:15:29 +0200
Message-ID: <CAFLxGvw8_HJGLHuaPxT0wxr6fCa3w5GkTjfrkUyVY+ZG0NoE6g@mail.gmail.com>
Subject: Re: UML fails to build on arch i386
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: rrs@researchut.com
Cc: linux-um@lists.infradead.org

On Thu, Jun 14, 2018 at 10:58 AM, Ritesh Raj Sarraf <rrs@researchut.com> wrote:
> On Thu, 2018-06-14 at 11:01 +0545, Ritesh Raj Sarraf wrote:
>>   CC      arch/um/kernel/skas/clone.o
>> In file included from ./arch/x86/um/shared/sysdep/ptrace.h:42:0,
>>                  from ./arch/um/include/shared/as-layout.h:38,
>>                  from arch/um/kernel/skas/clone.c:11:
>> ./arch/x86/um/shared/sysdep/ptrace_32.h:16:23:
>>                        ^
>
> This log missed the main error line:
>
>   CC      arch/um/kernel/maccess.o
>   CC      arch/um/kernel/kmsg_dump.o
>   CC      arch/um/kernel/skas/clone.o
> In file included from ./arch/x86/um/shared/sysdep/ptrace.h:42:0,
>                  from ./arch/um/include/shared/as-layout.h:38,
>                  from arch/um/kernel/skas/clone.c:11:
> ./arch/x86/um/shared/sysdep/ptrace_32.h:16:23: error: expected identifier before numeric constant
>  #define PTRACE_SYSEMU 31

Hmm, can you please check how PTRACE_SYSEMU is defined in your UAPI?

The code is pretty boring:
#ifndef PTRACE_SYSEMU
#define PTRACE_SYSEMU 31
#endif

My best guess is that PTRACE_SYSEMU is not a define but something else and then
#define fails in an interesting way.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


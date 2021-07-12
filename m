Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from m43-7.mailgun.net ([69.72.43.7])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m30WS-0089H4-SL
 for linux-um@lists.infradead.org; Mon, 12 Jul 2021 18:19:18 +0000
MIME-Version: 1.0
Date: Mon, 12 Jul 2021 12:19:00 -0600
From: subashab@codeaurora.org
Subject: Re: UML kernel panic on initialization
In-Reply-To: <CABqSeAQpb+wEM03knfmDHwtpM6vdfrpuaTwDHA35KY0PHa92cw@mail.gmail.com>
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
 <CABqSeAQpb+wEM03knfmDHwtpM6vdfrpuaTwDHA35KY0PHa92cw@mail.gmail.com>
Message-ID: <3343f1643f7f2c6f85e1c446d30c453d@codeaurora.org>
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
To: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>, stranche@codeaurora.org

On 2021-07-11 14:27, YiFei Zhu wrote:
> On Sat, Jul 10, 2021 at 4:00 PM <subashab@codeaurora.org> wrote:
>> Run /sbin/init as init process
>> init[1]: segfault at 0 ip 0000000040000af0 sp 0000007fbfb0be40 error 0
>> in ld-2.13.so[40000000+20000]
> 
> I haven't tried to reproduce this, but it looks like it failed in the
> dynamic loader. Do you know what instruction it is failing at? It
> should be at offset 1af0 in objdump -d `ld-2.13.so` assuming the first
> instruction in objdump is 1000.
> 
> Could you also check if this instruction that is segfaulting is the
> entry point address? If so, it could be that there's some sort of
> failure in mapping the VMA, so if you could check the /proc/[pid]/maps
> of the userspace traced process that would be great. You can identify
> the traced process in that it has a different VSZ than the other UML
> threads.
> 

The start of instructions is at af0 for me -

Disassembly of section .text:

0000000000000af0 <_dl_rtld_di_serinfo-0x7b10>:
      af0:       48 89 e7                mov    %rsp,%rdi

The offset at af0 from start is -

     15e0:       48 8d 35 79 97 01 00    lea    0x19779(%rip),%rsi        
# 1ad60 <calloc+0x56e0>

Here is the output of the /proc/[pid]/maps -

60000000-60719000 rwxp 00000000 103:00 12718929                          
<full_path_to_linux_binary>
60719000-6077b000 rwxp 00000000 00:00 0                                  
[heap]
6077b000-80000000 rwxs 0077b000 00:18 8                                  
/dev/shm/#8 (deleted)
80800000-80801000 rwxs 011f5000 00:18 8                                  
/dev/shm/#8 (deleted)
7ffff71d3000-7ffff71de000 r-xp 00000000 fd:00 131326                     
/lib/x86_64-linux-gnu/libnss_files-2.23.so
7ffff71de000-7ffff73dd000 ---p 0000b000 fd:00 131326                     
/lib/x86_64-linux-gnu/libnss_files-2.23.so
7ffff73dd000-7ffff73de000 r-xp 0000a000 fd:00 131326                     
/lib/x86_64-linux-gnu/libnss_files-2.23.so
7ffff73de000-7ffff73df000 rwxp 0000b000 fd:00 131326                     
/lib/x86_64-linux-gnu/libnss_files-2.23.so
7ffff73df000-7ffff73e5000 rwxp 00000000 00:00 0
7ffff73e5000-7ffff75a5000 r-xp 00000000 fd:00 131648                     
/lib/x86_64-linux-gnu/libc-2.23.so
7ffff75a5000-7ffff77a5000 ---p 001c0000 fd:00 131648                     
/lib/x86_64-linux-gnu/libc-2.23.so
7ffff77a5000-7ffff77a9000 r-xp 001c0000 fd:00 131648                     
/lib/x86_64-linux-gnu/libc-2.23.so
7ffff77a9000-7ffff77ab000 rwxp 001c4000 fd:00 131648                     
/lib/x86_64-linux-gnu/libc-2.23.so
7ffff77ab000-7ffff77af000 rwxp 00000000 00:00 0
7ffff77af000-7ffff77c7000 r-xp 00000000 fd:00 131033                     
/lib/x86_64-linux-gnu/libpthread-2.23.so
7ffff77c7000-7ffff79c6000 ---p 00018000 fd:00 131033                     
/lib/x86_64-linux-gnu/libpthread-2.23.so
7ffff79c6000-7ffff79c7000 r-xp 00017000 fd:00 131033                     
/lib/x86_64-linux-gnu/libpthread-2.23.so
7ffff79c7000-7ffff79c8000 rwxp 00018000 fd:00 131033                     
/lib/x86_64-linux-gnu/libpthread-2.23.so
7ffff79c8000-7ffff79cc000 rwxp 00000000 00:00 0
7ffff79cc000-7ffff79d3000 r-xp 00000000 fd:00 130891                     
/lib/x86_64-linux-gnu/librt-2.23.so
7ffff79d3000-7ffff7bd2000 ---p 00007000 fd:00 130891                     
/lib/x86_64-linux-gnu/librt-2.23.so
7ffff7bd2000-7ffff7bd3000 r-xp 00006000 fd:00 130891                     
/lib/x86_64-linux-gnu/librt-2.23.so
7ffff7bd3000-7ffff7bd4000 rwxp 00007000 fd:00 130891                     
/lib/x86_64-linux-gnu/librt-2.23.so
7ffff7bd4000-7ffff7bd6000 r-xp 00000000 fd:00 131650                     
/lib/x86_64-linux-gnu/libutil-2.23.so
7ffff7bd6000-7ffff7dd5000 ---p 00002000 fd:00 131650                     
/lib/x86_64-linux-gnu/libutil-2.23.so
7ffff7dd5000-7ffff7dd6000 r-xp 00001000 fd:00 131650                     
/lib/x86_64-linux-gnu/libutil-2.23.so
7ffff7dd6000-7ffff7dd7000 rwxp 00002000 fd:00 131650                     
/lib/x86_64-linux-gnu/libutil-2.23.so
7ffff7dd7000-7ffff7dfd000 r-xp 00000000 fd:00 131032                     
/lib/x86_64-linux-gnu/ld-2.23.so
7ffff7fd6000-7ffff7fdb000 rwxp 00000000 00:00 0
7ffff7ff7000-7ffff7ffa000 r--p 00000000 00:00 0                          
[vvar]
7ffff7ffa000-7ffff7ffc000 r-xp 00000000 00:00 0                          
[vdso]
7ffff7ffc000-7ffff7ffd000 r-xp 00025000 fd:00 131032                     
/lib/x86_64-linux-gnu/ld-2.23.so
7ffff7ffd000-7ffff7ffe000 rwxp 00026000 fd:00 131032                     
/lib/x86_64-linux-gnu/ld-2.23.so
7ffff7ffe000-7ffff7fff000 rwxp 00000000 00:00 0
7ffffffde000-7ffffffff000 rwxp 00000000 00:00 0                          
[stack]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  
[vsyscall]

I don't know how to get VSZ from the maps output, so I used ps instead. 
The value is 536932.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


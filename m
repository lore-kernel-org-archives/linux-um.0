Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: um: PTRACE_SETREGSET failure with XSTATE on Kabylake CPU
References: <1497923806.7300.2.camel@m3y3r.de>
 <98803c66-4a36-a95f-5a1b-51a40de7a3e6@nod.at>
 <1497948550.7300.5.camel@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <25066617-df15-6d21-713c-1ede1e953448@nod.at>
Date: Tue, 20 Jun 2017 11:05:53 +0200
MIME-Version: 1.0
In-Reply-To: <1497948550.7300.5.camel@m3y3r.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>, elicooper@gmx.com, linux-kernel@vger.kernel.org, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, Yu-cheng Yu <yu-cheng.yu@intel.com>, linux-x86_64@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

[adding x86 folks]

Am 20.06.2017 um 10:49 schrieb Thomas Meyer:
> Am Dienstag, den 20.06.2017, 08:58 +0200 schrieb Richard Weinberger:
>> Thomas,
>>
>> Am 20.06.2017 um 03:56 schrieb Thomas Meyer:
>>> Hi,
>>>
>>> I finally did figure out where in the host kernel the ptrace
>>> syscall
>>> fails with -EFAULT.
>>
>> Nice! Thanks a lot for digging into this. I still had no chance to
>> setup
>> Ipv6 to connect to your host and figure myself. ;-\
>>
>>> In arch/x86/kernel/fpu/regset.c:130:
>>>
>>> 114 int xstateregs_set(struct task_struct *target, const struct
>>> user_regset *regset,
>>> 115                   unsigned int pos, unsigned int count,
>>> 116                   const void *kbuf, const void __user *ubuf)
>>> 117 {
>>> 118         struct fpu *fpu = &target->thread.fpu;
>>> 119         struct xregs_state *xsave;
>>> 120         int ret;
>>> 121 
>>> 122         if (!boot_cpu_has(X86_FEATURE_XSAVE))
>>> 123                 return -ENODEV;
>>> 124 
>>> 125         pr_info("in xstateregs_set");
>>> 126 
>>> 127         /*
>>> 128          * A whole standard-format XSAVE buffer is needed:
>>> 129          */
>>> 130         if ((pos != 0) || (count < fpu_user_xstate_size)) {
>>> 131                 pr_info("EFAULT from xstateregs_set");
>>> 132->               pr_info("pos = %i, count = %i,
>>> fpu_user_xstate_size= %i\n", pos, count, fpu_user_xstate_size);
>>> 133                 return -EFAULT;
>>> 134         }
>>>
>>> Sadly I had to fallback to debugging by printk because kgdb/qemu
>>> gdbstub, all didn't work for some unknown reason :-(
>>
>> As always. printk is best debugger ever. ;-)
>>
>>> output is:
>>> [   69.598349] EFAULT from xstateregs_set
>>> [   69.598350] pos = 0, count = 832, fpu_user_xstate_size= 1088
>>>
>>> calling code is in arch/x86/um/os-Linux/registers.c:
>>>
>>>  49 int restore_fp_registers(int pid, unsigned long *fp_regs)
>>>  50 {
>>>  51         struct iovec iov;
>>>  52 
>>>  53         if (have_xstate_support) {
>>>  54                 iov.iov_base = fp_regs;
>>>  55                 iov.iov_len = sizeof(struct _xstate);
>>>  56                 if (ptrace(PTRACE_SETREGSET, pid,
>>> NT_X86_XSTATE, &iov) < 0)
>>>  57  ->                     return -errno;
>>>  58                 return 0;
>>>  59         } else {
>>>  60                 return restore_i387_registers(pid, fp_regs);
>>>  61         }
>>>  62 }
>>>
>>> it looks like _xstate is too short for above operation, I wonder
>>> why
>>> PTRACE_GETREGSET works without a warning of too short size.
>>
>> Does PTRACE_GETREGSET return a size?
> 
> Yes, it returns 832. the size of struct _xstate.
> 
>> Maybe we have to take this into account.
>> It could be that your host CPU has a smaller set.
>> Also check whether PTRACE_SETREGSET always fails.
> 
> In UML the first userspace ptrace always fails, so init get's killed.
> 
> The check "count < fpu_user_xstate_size" was introduced by commit:
> 
> commit 91c3dba7dbc199191272f4a9863f86ea3bfd679f
> Author: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Date:   Fri Jun 17 13:07:17 2016 -0700
> 
>     x86/fpu/xstate: Fix PTRACE frames for XSAVES
>     
>     XSAVES uses compacted format and is a kernel instruction. The kernel
>     should use standard-format, non-supervisor state data for PTRACE.
> 
> So to summarize:
> 
> - PTRACE_GETREGSET with NT_X86_XSTATE gets 832 and return 832, with no
> error.
> 
> - PTRACE_SETREGSET get 832 (sizeof struct _xstate) but wants at least
> 1088, otherwise it will fail with -EFAULT (why not -EINVAL?)
> 
> Ideas?
> 
>>
>> Thanks,
>> //richard


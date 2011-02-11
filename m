Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4D540969.9090507@panasas.com>
References: <4D52E4E1.7070705@panasas.com>
	<4D540969.9090507@panasas.com>
Date: Fri, 11 Feb 2011 13:38:17 +0100
Message-ID: <AANLkTine1w2h29OPES1RHTs-otB_ohhMDMbbRoXFK+BB@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: Regression with calibrate_xor_blocks, probably UML related
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, NeilBrown <neilb@suse.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Feb 10, 2011 at 4:51 PM, Boaz Harrosh <bharrosh@panasas.com> wr=
ote:
> On 02/09/2011 09:02 PM, Boaz Harrosh wrote:
>> I have a new module that uses the async_tx.h lib.
>>
>> On an exact same module code based on 3.6.37 I see the:
>> =A0 =A0 =A0 xor: measuring software checksum speed
>> =A0 =A0 =A0 =A0 =A08regs =A0 =A0 : 11312.000 MB/sec
>> =A0 =A0 =A0 =A0 =A08regs_prefetch: =A09792.800 MB/sec
>> =A0 =A0 =A0 =A0 =A032regs =A0 =A0: 11220.400 MB/sec
>> =A0 =A0 =A0 =A0 =A032regs_prefetch: =A09750.800 MB/sec
>> =A0 =A0 =A0 xor: using function: 8regs (11312.000 MB/sec)
>>
>> And all is well. But on code based on 2.6.38-rc4 I get hard stuck
>> right after:
>> =A0 =A0 =A0 xor: measuring software checksum speed
>>
>
> OK this is not dependent on Kernel version it is the same for both
> .38-rc4 and .37. I was just lucky with .37 more.
>
> And the same things happen with raid456 module. I do
> []$ modprobe raid456; modprobe --remove raid456
> A few times it loads, printing the above checks, Then At one
> time it freezes. Sometimes at first attempt sometimes at 4-7
> attempts. I never went 10 times strait.
>
> When it freezes (hard) I can see in my host that the UML is
> at 100% CPU.
>
> BTW: when I manage to pass the tests I get the above numbers
> But when I load directly on the host I get:
>
> =A0xor: automatically using best checksumming function: generic_sse
> =A0 generic_sse: =A07596.000 MB/sec
> =A0xor: using function: generic_sse (7596.000 MB/sec)
> =A0raid6: int64x1 =A0 1660 MB/s
> =A0raid6: int64x2 =A0 1832 MB/s
> =A0raid6: int64x4 =A0 1566 MB/s
> =A0raid6: int64x8 =A0 1175 MB/s
> =A0raid6: sse2x1 =A0 =A03699 MB/s
> =A0raid6: sse2x2 =A0 =A04398 MB/s
> =A0raid6: sse2x4 =A0 =A05863 MB/s
> =A0raid6: using algorithm sse2x4 (5863 MB/s)
>
> and on the UML:
>
> =A0raid6: int64x1 =A0 2019 MB/s
> =A0raid6: int64x2 =A0 2208 MB/s
> =A0raid6: int64x4 =A0 1892 MB/s
> =A0raid6: int64x8 =A0 1528 MB/s
> =A0raid6: using algorithm int64x2 (2208 MB/s)
> =A0xor: measuring software checksum speed
> =A0 8regs =A0 =A0 : 11308.000 MB/sec
> =A0 8regs_prefetch: =A09795.600 MB/sec
> =A0 32regs =A0 =A0: 11236.000 MB/sec
> =A0 32regs_prefetch: =A09752.400 MB/sec
> =A0xor: using function: 8regs (11308.000 MB/sec)
>
> So the raid6 sse is better, but comparing it64xX the UML is faster th=
an host
> But raid5? that's 33% better results. Does that say that UML's clock =
has
> a bug?
>
> Any way I'm trying to debug that xor.ko loading problem see what
> comes up. Any help is welcome

Hmmm, can you bisect it?
Can you post you config then I can also try my best...

> Thanks
> Boaz
>
>> the UML is completely frozen. When I kill the uml from the host
>> I can sometimes get this trace.
>>
>
>
>
>
>
>> 750c7498: =A0[<6005f936>] bad_page+0xd8/0xf3
>> 750c74c8: =A0[<60060c93>] get_page_from_freelist+0x333/0x47b
>> 750c7508: =A0[<60131243>] put_dec+0x20/0x3c
>> 750c75a0: =A0[<6001a0ac>] change_pre_exec+0x0/0x24
>> 750c75b8: =A0[<60060ef1>] __alloc_pages_nodemask+0x116/0x65b
>> 750c7668: =A0[<60132e25>] sprintf+0xa1/0xa3
>> 750c76a0: =A0[<6001a0ac>] change_pre_exec+0x0/0x24
>> 750c76b8: =A0[<60061446>] __get_free_pages+0x10/0x43
>> 750c76c8: =A0[<60012875>] alloc_stack+0x1b/0x1d
>> 750c76d8: =A0[<6001fe27>] run_helper+0x26/0x1b5
>> 750c76e8: =A0[<60021553>] set_signals+0x1c/0x2e
>> 750c7708: =A0[<6007efac>] __kmalloc+0x9e/0xc4
>> 750c7748: =A0[<6001a544>] change+0x124/0x189
>> 750c77e8: =A0[<601b77db>] _raw_spin_unlock+0x9/0xb
>> 750c7818: =A0[<6001a5a9>] close_addr+0x0/0x1c
>> 750c7828: =A0[<6001a5c3>] close_addr+0x1a/0x1c
>> 750c7838: =A0[<6001926a>] iter_addresses+0x5f/0x76
>> 750c7858: =A0[<6007e8e8>] kfree+0x92/0x9b
>> 750c7898: =A0[<60022d01>] tuntap_close+0x24/0x38
>> 750c78b8: =A0[<600194e4>] close_devices+0x4a/0x7f
>> 750c78d8: =A0[<600121bf>] do_uml_exitcalls+0x12/0x23
>> 750c78f8: =A0[<60012cd2>] uml_cleanup+0x1a/0x87
>> 750c7928: =A0[<6002039b>] last_ditch_exit+0x9/0x16
>> 750c79e8: =A0[<78817031>] xor_8regs_2+0x31/0x58 [xor]
>> 750c7a18: =A0[<7881b000>] calibrate_xor_blocks+0x0/0xdf [xor]
>> 750c7aa8: =A0[<601b77ce>] _raw_spin_unlock_irqrestore+0x18/0x1c
>> 750c7ac8: =A0[<60029d8d>] try_to_wake_up+0x86/0x98
>> 750c7d78: =A0[<601b548d>] printk+0xa0/0xa3
>> 750c7e08: =A0[<78817633>] do_xor_speed+0x54/0xaf [xor]
>> 750c7e20: =A0[<7881b000>] calibrate_xor_blocks+0x0/0xdf [xor]
>> 750c7e58: =A0[<7881b057>] calibrate_xor_blocks+0x57/0xdf [xor]
>> 750c7e68: =A0[<7881b000>] calibrate_xor_blocks+0x0/0xdf [xor]
>> 750c7e78: =A0[<6001105a>] do_one_initcall+0x76/0x121
>> 750c7eb8: =A0[<600563fd>] sys_init_module+0x78/0x1a6
>> 750c7ee8: =A0[<60014d60>] handle_syscall+0x58/0x70
>> 750c7f08: =A0[<60024163>] userspace+0x2dd/0x38a
>> 750c7fc8: =A0[<600126af>] fork_handler+0x62/0x69
>>
>> (gdb) list *(xor_8regs_2+0x31)
>> 0x55 is in xor_8regs_2 (/usr0/export/dev/bharrosh/git/pub/scsi-misc/=
include/asm-generic/xor.h:29).
>> 24 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[0] ^=3D p2[0];
>> 25 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[1] ^=3D p2[1];
>> 26 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[2] ^=3D p2[2];
>> 27 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[3] ^=3D p2[3];
>> 28 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[4] ^=3D p2[4];
>> 29 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[5] ^=3D p2[5];
>> 30 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[6] ^=3D p2[6];
>> 31 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1[7] ^=3D p2[7];
>> 32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1 +=3D 8;
>> 33 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p2 +=3D 8;
>> (gdb) list *(calibrate_xor_blocks+0x0)
>> 0xd52 is in calibrate_xor_blocks (/usr0/export/dev/bharrosh/git/pub/=
scsi-misc/crypto/xor.c:101).
>> 96 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed / 1000, speed % 100=
0);
>> 97 =A0 =A0 =A0}
>> 98
>> 99 =A0 =A0 =A0static int __init
>> 100 =A0 =A0 calibrate_xor_blocks(void)
>> 101 =A0 =A0 {
>> 102 =A0 =A0 =A0 =A0 =A0 =A0 void *b1, *b2;
>> 103 =A0 =A0 =A0 =A0 =A0 =A0 struct xor_block_template *f, *fastest;
>> 104
>> 105 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> (gdb) list *(do_xor_speed+0x54)
>> 0x657 is in do_xor_speed (/usr0/export/dev/bharrosh/git/pub/scsi-mis=
c/crypto/xor.c:84).
>> 79 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0now =3D jiffies;
>> 80 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count =3D 0;
>> 81 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (jiffies =3D=3D =
now) {
>> 82 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mb(); =
/* prevent loop optimzation */
>> 83 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmpl->=
do_2(BENCH_SIZE, b1, b2);
>> 84 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mb();
>> 85 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count+=
+;
>> 86 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mb();
>> 87 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> 88 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (count > max)
>> (gdb) list *(calibrate_xor_blocks+0x57)
>> 0xda9 is in calibrate_xor_blocks (/usr0/export/dev/bharrosh/git/pub/=
scsi-misc/crypto/xor.c:137).
>> 132 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "checksu=
mming function: %s\n",
>> 133 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fastest-=
>name);
>> 134 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xor_speed(fastest);
>> 135 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> 136 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "xor: m=
easuring software checksum speed\n");
>> 137 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XOR_TRY_TEMPLATES;
>> 138 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fastest =3D template_lis=
t;
>> 139 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (f =3D fastest; f; f=
 =3D f->next)
>> 140 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (f->s=
peed > fastest->speed)
>> 141 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 fastest =3D f;
>> (gdb) q
>>
>> So it looks like the code in UML links the include/asm-generic/xor.h=
 and that it gets
>> stuck. Any thing changed in this area in last merge window?
>>
>> Before I start the very difficult bisect?
>>
>> Thanks for any tips
>> Boaz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fsde=
vel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


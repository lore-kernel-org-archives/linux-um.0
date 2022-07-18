Return-Path: <monstr@monstr.eu>
Message-ID: <9cc11fd0-28c7-fd0d-fe55-cce0bb5e92a7@monstr.eu>
Date: Mon, 18 Jul 2022 11:04:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] MicroBlaze: cpuinfo: Fix a warning for
 CONFIG_CPUMASK_OFFSTACK
Content-Language: en-US
References: <20220712075255.1345991-1-chenhuacai@loongson.cn>
 <20220712075255.1345991-4-chenhuacai@loongson.cn>
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20220712075255.1345991-4-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, stable@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>



On 7/12/22 09:52, Huacai Chen wrote:
> When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selected,
> cpu_max_bits_warn() generates a runtime warning similar as below while
> we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limit)
> instead of NR_CPUS to iterate CPUs.
> 
> [    3.052463] ------------[ cut here ]------------
> [    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 show_cpuinfo+0x5e8/0x5f0
> [    3.070072] Modules linked in: efivarfs autofs4
> [    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #1052
> [    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf846c 9000000100154000
> [    3.109127]         9000000100157a50 0000000000000000 9000000100157a58 9000000000ef7430
> [    3.118774]         90000001001578e8 0000000000000040 0000000000000020 ffffffffffffffff
> [    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021de80 900000000101c890
> [    3.138056]         0000000000000000 0000000000000000 0000000000000000 0000000000aaaaaa
> [    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab4000 0000000000000000
> [    3.157364]         900000000101c998 0000000000000004 9000000000ef7430 0000000000000000
> [    3.167012]         0000000000000009 000000000000006c 0000000000000000 0000000000000000
> [    3.176641]         9000000000d3de08 9000000001639390 90000000002086d8 00007ffff0080286
> [    3.186260]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1c
> [    3.195868]         ...
> [    3.199917] Call Trace:
> [    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
> [    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
> [    3.217625] [<900000000023d268>] __warn+0xd0/0x100
> [    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
> [    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
> [    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
> [    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
> [    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
> [    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
> [    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
> [    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
> [    3.281824] ---[ end trace 8b484262b4b8c24c ]---
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/microblaze/kernel/cpu/mb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/cpu/mb.c b/arch/microblaze/kernel/cpu/mb.c
> index 9581d194d9e4..689de7f75614 100644
> --- a/arch/microblaze/kernel/cpu/mb.c
> +++ b/arch/microblaze/kernel/cpu/mb.c
> @@ -137,7 +137,7 @@ static void *c_start(struct seq_file *m, loff_t *pos)
>   {
>   	int i = *pos;
>   
> -	return i < NR_CPUS ? (void *) (i + 1) : NULL;
> +	return i < nr_cpu_ids ? (void *) (i + 1) : NULL;
>   }
>   
>   static void *c_next(struct seq_file *m, void *v, loff_t *pos)

As was said in m68k thread commit message should be fixed. MB upstream in not 
SMP. We have SMP configuration in soc vendor tree but upstream we can't enable 
DEBUG_PER_CPU_MAPS which depends on SMP. But definitely worth to fix it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



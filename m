Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 09 May 2017 19:25:08 +0200
Message-ID: <20170509192508.Horde.q9LPitc8upyg8NEM65B6nWV@webmail.your-server.de>
From: Thomas Meyer <thomas@m3y3r.de>
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
	<0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
	<D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
	<66f46b90-6312-449f-2c52-d12fc53f18f6@nod.at>
	<20170509101536.Horde.EnvMo4uaHVafhqi80MdUNWc@webmail.your-server.de>
	<0c36ac98-761a-bf07-a6ef-13f0f7b7b561@nod.at>
In-Reply-To: <0c36ac98-761a-bf07-a6ef-13f0f7b7b561@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [uml-devel] [uml-user] UML on WSL
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


Zitat von Richard Weinberger <richard@nod.at>:

> Thomas,
>
> Am 09.05.2017 um 10:15 schrieb Thomas Meyer:
>> attached patch work correctly under Linux. But no change under WSL.  
>> As stated in the relevant GH issue, there seems to be far more road  
>> blockers to make UML work under WSL.
>>
>> With you patch I get under WSL:
>>
>> thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/VmShare$ ./linux
>> Core dump limits :
>>         soft - NONE
>>         hard - NONE
>> Checking that ptrace can change system call numbers...check_ptrace  
>> : failed to modify system call: Invalid Argument
>
> Okay, now it fails later.
> UML needs to cancel  syscalls on the host side, it does so by  
> turning them into a getpid() which has no side
> effects and, on non-ancient systems, by using PTRACE_SYSEMU.
> Let's figure whether they support PTRACE_SYSEMU, can you test the  
> attached patch?

okay, it now proceeds even more:

thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/VmShare$ ./linux mem=128m
Core dump limits :
         soft - NONE
         hard - NONE
Checking syscall emulation patch for ptrace...missing
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Adding 3665920 bytes to physical memory to account for exec-shield gap
kmsg_dump:
<3>[    2.050000] Slab cache with size 1056 has lost its name
<3>[    2.050000] Slab cache with size 160 has lost its name
<3>[    2.050000] Slab cache with size 1440 has lost its name
<3>[    2.050000] Slab cache with size 168 has lost its name
<3>[    2.050000] Slab cache with size 432 has lost its name
<3>[    2.050000] Slab cache with size 984 has lost its name
<3>[    2.050000] Slab cache with size 320 has lost its name
<3>[    2.050000] Slab cache with size 72 has lost its name
<3>[    2.050000] Slab cache with size 72 has lost its name
<3>[    2.050000] Slab cache with size 112 has lost its name
<3>[    2.050000] Slab cache with size 296 has lost its name
<3>[    2.050000] Slab cache with size 104 has lost its name
<3>[    2.050000] Slab cache with size 56 has lost its name
<3>[    2.050000] Slab cache with size 184 has lost its name
<3>[    2.050000] Slab cache with size 1464 has lost its name
<3>[    2.050000] Slab cache with size 776 has lost its name
<3>[    2.050000] Slab cache with size 1408 has lost its name
<3>[    2.050000] Slab cache with size 2216 has lost its name
<3>[    2.050000] Slab cache with size 6000 has lost its name
<3>[    2.050000] Slab cache with size 80 has lost its name
<3>[    2.050000] Slab cache with size 176 has lost its name
<3>[    2.050000] Slab cache with size 40 has lost its name
<3>[    2.050000] Slab cache with size 88 has lost its name
<3>[    2.050000] Slab cache with size 48 has lost its name
<3>[    2.050000] Slab cache with size 576 has lost its name
<3>[    2.050000] Slab cache with size 616 has lost its name
<3>[    2.050000] Slab cache with size 8192 has lost its name
<3>[    2.050000] Slab cache with size 4096 has lost its name
<3>[    2.050000] Slab cache with size 2048 has lost its name
<3>[    2.050000] Slab cache with size 1024 has lost its name
<3>[    2.050000] Slab cache with size 512 has lost its name
<3>[    2.050000] Slab cache with size 256 has lost its name
<3>[    2.050000] Slab cache with size 192 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 96 has lost its name
<3>[    2.050000] Slab cache with size 64 has lost its name
<3>[    2.050000] Slab cache with size 32 has lost its name
<3>[    2.050000] Slab cache with size 16 has lost its name
<3>[    2.050000] Slab cache with size 8 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 200 has lost its name
<7>[    2.050000] SELinux:  Registering netfilter hooks
<6>[    2.050000] cryptomgr_test (23) used greatest stack depth: 6216  
bytes left
<6>[    2.050000] jitterentropy: Initialization failed with host not  
compliant with requirements: 2
<6>[    2.050000] io scheduler noop registered
<6>[    2.050000] io scheduler deadline registered (default)
<3>[    2.050000] Slab cache with size 1416 has lost its name
<3>[    2.050000] Slab cache with size 1304 has lost its name
<3>[    2.050000] Slab cache with size 464 has lost its name
<3>[    2.050000] Slab cache with size 1344 has lost its name
<3>[    2.050000] Slab cache with size 1784 has lost its name
<3>[    2.050000] Slab cache with size 800 has lost its name
<3>[    2.050000] Slab cache with size 1032 has lost its name
<3>[    2.050000] Slab cache with size 1288 has lost its name
<3>[    2.050000] Slab cache with size 32 has lost its name
<3>[    2.050000] Slab cache with size 1040 has lost its name
<3>[    2.050000] Slab cache with size 48 has lost its name
<3>[    2.050000] Slab cache with size 112 has lost its name
<3>[    2.050000] Slab cache with size 16 has lost its name
<3>[    2.050000] Slab cache with size 32 has lost its name
<3>[    2.050000] Slab cache with size 2152 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 168 has lost its name
<3>[    2.050000] Slab cache with size 64 has lost its name
<3>[    2.050000] Slab cache with size 40 has lost its name
<3>[    2.050000] Slab cache with size 56 has lost its name
<3>[    2.050000] Slab cache with size 24 has lost its name
<3>[    2.050000] Slab cache with size 96 has lost its name
<3>[    2.050000] Slab cache with size 768 has lost its name
<3>[    2.050000] Slab cache with size 440 has lost its name
<3>[    2.050000] Slab cache with size 144 has lost its name
<3>[    2.050000] Slab cache with size 696 has lost its name
<3>[    2.050000] Slab cache with size 280 has lost its name
<3>[    2.050000] Slab cache with size 1824 has lost its name
<3>[    2.050000] Slab cache with size 296 has lost its name
<3>[    2.050000] Slab cache with size 280 has lost its name
<3>[    2.050000] Slab cache with size 352 has lost its name
<3>[    2.050000] Slab cache with size 2704 has lost its name
<3>[    2.050000] Slab cache with size 416 has lost its name
<3>[    2.050000] Slab cache with size 152 has lost its name
<3>[    2.050000] Slab cache with size 2112 has lost its name
<3>[    2.050000] Slab cache with size 216 has lost its name
<3>[    2.050000] Slab cache with size 1032 has lost its name
<3>[    2.050000] Slab cache with size 272 has lost its name
<3>[    2.050000] Slab cache with size 120 has lost its name
<3>[    2.050000] Slab cache with size 6056 has lost its name
<3>[    2.050000] Slab cache with size 1208 has lost its name
<3>[    2.050000] Slab cache with size 136 has lost its name
<3>[    2.050000] Slab cache with size 328 has lost its name
<3>[    2.050000] Slab cache with size 1056 has lost its name
<3>[    2.050000] Slab cache with size 160 has lost its name
<3>[    2.050000] Slab cache with size 1440 has lost its name
<3>[    2.050000] Slab cache with size 168 has lost its name
<3>[    2.050000] Slab cache with size 432 has lost its name
<3>[    2.050000] Slab cache with size 984 has lost its name
<3>[    2.050000] Slab cache with size 320 has lost its name
<3>[    2.050000] Slab cache with size 72 has lost its name
<3>[    2.050000] Slab cache with size 72 has lost its name
<3>[    2.050000] Slab cache with size 112 has lost its name
<3>[    2.050000] Slab cache with size 296 has lost its name
<3>[    2.050000] Slab cache with size 104 has lost its name
<3>[    2.050000] Slab cache with size 56 has lost its name
<3>[    2.050000] Slab cache with size 184 has lost its name
<3>[    2.050000] Slab cache with size 1464 has lost its name
<3>[    2.050000] Slab cache with size 776 has lost its name
<3>[    2.050000] Slab cache with size 1408 has lost its name
<3>[    2.050000] Slab cache with size 2216 has lost its name
<3>[    2.050000] Slab cache with size 6000 has lost its name
<3>[    2.050000] Slab cache with size 80 has lost its name
<3>[    2.050000] Slab cache with size 176 has lost its name
<3>[    2.050000] Slab cache with size 40 has lost its name
<3>[    2.050000] Slab cache with size 88 has lost its name
<3>[    2.050000] Slab cache with size 48 has lost its name
<3>[    2.050000] Slab cache with size 576 has lost its name
<3>[    2.050000] Slab cache with size 616 has lost its name
<3>[    2.050000] Slab cache with size 8192 has lost its name
<3>[    2.050000] Slab cache with size 4096 has lost its name
<3>[    2.050000] Slab cache with size 2048 has lost its name
<3>[    2.050000] Slab cache with size 1024 has lost its name
<3>[    2.050000] Slab cache with size 512 has lost its name
<3>[    2.050000] Slab cache with size 256 has lost its name
<3>[    2.050000] Slab cache with size 192 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 96 has lost its name
<3>[    2.050000] Slab cache with size 64 has lost its name
<3>[    2.050000] Slab cache with size 32 has lost its name
<3>[    2.050000] Slab cache with size 16 has lost its name
<3>[    2.050000] Slab cache with size 8 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 200 has lost its name
<3>[    2.050000] Slab cache with size 240 has lost its name
<3>[    2.050000] Slab cache with size 1416 has lost its name
<3>[    2.050000] Slab cache with size 1304 has lost its name
<3>[    2.050000] Slab cache with size 464 has lost its name
<3>[    2.050000] Slab cache with size 1344 has lost its name
<3>[    2.050000] Slab cache with size 1784 has lost its name
<3>[    2.050000] Slab cache with size 800 has lost its name
<3>[    2.050000] Slab cache with size 1032 has lost its name
<3>[    2.050000] Slab cache with size 1288 has lost its name
<3>[    2.050000] Slab cache with size 32 has lost its name
<3>[    2.050000] Slab cache with size 1040 has lost its name
<3>[    2.050000] Slab cache with size 48 has lost its name
<3>[    2.050000] Slab cache with size 112 has lost its name
<3>[    2.050000] Slab cache with size 16 has lost its name
<3>[    2.050000] Slab cache with size 32 has lost its name
<3>[    2.050000] Slab cache with size 2152 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 168 has lost its name
<3>[    2.050000] Slab cache with size 64 has lost its name
<3>[    2.050000] Slab cache with size 40 has lost its name
<3>[    2.050000] Slab cache with size 56 has lost its name
<3>[    2.050000] Slab cache with size 24 has lost its name
<3>[    2.050000] Slab cache with size 96 has lost its name
<3>[    2.050000] Slab cache with size 768 has lost its name
<3>[    2.050000] Slab cache with size 440 has lost its name
<3>[    2.050000] Slab cache with size 144 has lost its name
<3>[    2.050000] Slab cache with size 696 has lost its name
<3>[    2.050000] Slab cache with size 280 has lost its name
<3>[    2.050000] Slab cache with size 1824 has lost its name
<3>[    2.050000] Slab cache with size 296 has lost its name
<3>[    2.050000] Slab cache with size 280 has lost its name
<3>[    2.050000] Slab cache with size 352 has lost its name
<3>[    2.050000] Slab cache with size 2704 has lost its name
<3>[    2.050000] Slab cache with size 416 has lost its name
<3>[    2.050000] Slab cache with size 152 has lost its name
<3>[    2.050000] Slab cache with size 2112 has lost its name
<3>[    2.050000] Slab cache with size 216 has lost its name
<3>[    2.050000] Slab cache with size 1032 has lost its name
<3>[    2.050000] Slab cache with size 272 has lost its name
<3>[    2.050000] Slab cache with size 120 has lost its name
<3>[    2.050000] Slab cache with size 6056 has lost its name
<3>[    2.050000] Slab cache with size 1208 has lost its name
<3>[    2.050000] Slab cache with size 136 has lost its name
<3>[    2.050000] Slab cache with size 328 has lost its name
<3>[    2.050000] Slab cache with size 1056 has lost its name
<3>[    2.050000] Slab cache with size 160 has lost its name
<3>[    2.050000] Slab cache with size 1440 has lost its name
<3>[    2.050000] Slab cache with size 168 has lost its name
<3>[    2.050000] Slab cache with size 432 has lost its name
<3>[    2.050000] Slab cache with size 984 has lost its name
<3>[    2.050000] Slab cache with size 320 has lost its name
<3>[    2.050000] Slab cache with size 72 has lost its name
<3>[    2.050000] Slab cache with size 72 has lost its name
<3>[    2.050000] Slab cache with size 112 has lost its name
<3>[    2.050000] Slab cache with size 296 has lost its name
<3>[    2.050000] Slab cache with size 104 has lost its name
<3>[    2.050000] Slab cache with size 56 has lost its name
<3>[    2.050000] Slab cache with size 184 has lost its name
<3>[    2.050000] Slab cache with size 1464 has lost its name
<3>[    2.050000] Slab cache with size 776 has lost its name
<3>[    2.050000] Slab cache with size 1408 has lost its name
<3>[    2.050000] Slab cache with size 2216 has lost its name
<3>[    2.050000] Slab cache with size 6000 has lost its name
<3>[    2.050000] Slab cache with size 80 has lost its name
<3>[    2.050000] Slab cache with size 176 has lost its name
<3>[    2.050000] Slab cache with size 40 has lost its name
<3>[    2.050000] Slab cache with size 88 has lost its name
<3>[    2.050000] Slab cache with size 48 has lost its name
<3>[    2.050000] Slab cache with size 576 has lost its name
<3>[    2.050000] Slab cache with size 616 has lost its name
<3>[    2.050000] Slab cache with size 8192 has lost its name
<3>[    2.050000] Slab cache with size 4096 has lost its name
<3>[    2.050000] Slab cache with size 2048 has lost its name
<3>[    2.050000] Slab cache with size 1024 has lost its name
<3>[    2.050000] Slab cache with size 512 has lost its name
<3>[    2.050000] Slab cache with size 256 has lost its name
<3>[    2.050000] Slab cache with size 192 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 96 has lost its name
<3>[    2.050000] Slab cache with size 64 has lost its name
<3>[    2.050000] Slab cache with size 32 has lost its name
<3>[    2.050000] Slab cache with size 16 has lost its name
<3>[    2.050000] Slab cache with size 8 has lost its name
<3>[    2.050000] Slab cache with size 128 has lost its name
<3>[    2.050000] Slab cache with size 200 has lost its name
<6>[    2.050000] io scheduler cfq registered
<6>[    2.050000] io scheduler mq-deadline registered
<4>[    2.050000]
<4>[    2.050000] Modules linked in:
<6>[    2.050000] Pid: 1, comm: swapper Not tainted  
4.11.0-00007-g594e0e4-dirty
<6>[    2.050000] RIP: 0033:[<00007f2e5b961eae>]
<6>[    2.050000] RSP: 0000000067c87c38  EFLAGS: 00010202
<6>[    2.050000] RAX: 0000000068842000 RBX: 0000000067dabae0 RCX:  
0000000000000001
<6>[    2.050000] RDX: 0000000000008000 RSI: 000000006884a000 RDI:  
0000000068842020
<6>[    2.050000] RBP: 0000000067c87c70 R08: 0000000067dabae7 R09:  
0000000067f73000
<6>[    2.050000] R10: 0000000000000000 R11: 0000000000000000 R12:  
0000000060040ae0
<6>[    2.050000] R13: 0000000000000000 R14: 00000000604e7e90 R15:  
0000000060886700
<0>[    2.050000] Kernel panic - not syncing: Segfault with no mm
<4>[    2.050000] CPU: 0 PID: 1 Comm: swapper Not tainted  
4.11.0-00007-g594e0e4-dirty #5
<6>[    2.050000] Stack:
<4>[    2.050000]  604e65b1 200000001 678085d8 67e35000
<4>[    2.050000]  678085c0 604e38b0 678085c0 67c87cf0
<4>[    2.050000]  604e3f02 00400000 678085c0 00000200
<6>[    2.050000] Call Trace:
<6>[    2.050000]  [<604e65b1>] ? check_partition+0x181/0x2c0
<6>[    2.050000]  [<604e38b0>] ? add_partition+0x0/0x5b0
<6>[    2.050000]  [<604e3f02>] rescan_partitions+0xa2/0x470
<6>[    2.050000]  [<604e1bd0>] ? get_gendisk+0x0/0x110
<6>[    2.050000]  [<60228842>] __blkdev_get+0x262/0x610
<6>[    2.050000]  [<601fe3cb>] ? unlock_new_inode+0x8b/0x90
<6>[    2.050000]  [<6027dba0>] ? sysfs_create_link+0x0/0x50
<6>[    2.050000]  [<6022907d>] blkdev_get+0x48d/0x5d0
<6>[    2.050000]  [<60513758>] ? refcount_dec_and_test+0x18/0x20
<6>[    2.050000]  [<604f6d1d>] ? kobject_put+0x5d/0x260
<6>[    2.050000]  [<6027dba0>] ? sysfs_create_link+0x0/0x50
<6>[    2.050000]  [<604e22a1>] device_add_disk+0x3b1/0x610
<6>[    2.050000]  [<604e2925>] ? alloc_disk+0x15/0x20
<6>[    2.050000]  [<604e1ef0>] ? device_add_disk+0x0/0x610
<6>[    2.050000]  [<60030d82>] 0x60030d82
<6>[    2.050000]  [<60030cb0>] ? 0x60030cb0
<6>[    2.050000]  [<60041520>] ? do_one_initcall+0x0/0x1a0
<6>[    2.050000]  [<600415da>] do_one_initcall+0xba/0x1a0
<6>[    2.050000]  [<600928f2>] ? parse_args+0x402/0x6f0
<6>[    2.050000]  [<60041520>] ? do_one_initcall+0x0/0x1a0
<6>[    2.050000]  [<60001fe3>] 0x60001fe3
<6>[    2.050000]  [<6015c8e6>] ? printk+0x0/0x94
<6>[    2.050000]  [<60835037>] kernel_init+0x27/0x150
<6>[    2.050000]  [<60043221>] new_thread_handler+0x81/0xb0
<6>[    2.050000]
Abgebrochen (Speicherabzug geschrieben)

>
> Also please test segv1.c, it tests whether WSL allows us to handle  
> page faults in userspace.
> It should output this:
> SIGSEGV at 0xdeadbeef, fixing up
> x=3, &x=0xdeadbeef
>
> IOW we write to 0xdeadbeef, catch the fault and fix it.

I get this:
thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/VmShare$ ./segtest
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
SIGSEGV at 0x0, fixing up
[...]

>
> Thanks,
> //richard




------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


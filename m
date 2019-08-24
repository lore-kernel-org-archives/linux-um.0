Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i1Kk0-0000zG-ME
 for linux-um@lists.infradead.org; Sat, 24 Aug 2019 01:21:18 +0000
Received: by mail-wm1-x342.google.com with SMTP id 10so10362507wmp.3
 for <linux-um@lists.infradead.org>; Fri, 23 Aug 2019 18:21:14 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
 by smtp.gmail.com with ESMTPSA id j16sm4497600wrp.62.2019.08.23.18.21.11
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 18:21:11 -0700 (PDT)
From: Vladimir Panteleev <thecybershadow@gmail.com>
Subject: Segmentation fault in blk-mq with loop device
Message-ID: <1e2a705a-79eb-ce96-1a23-d5b981fff5d8@gmail.com>
Date: Sat, 24 Aug 2019 01:21:10 +0000
MIME-Version: 1.0
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
To: linux-um@lists.infradead.org

Hi,

I'm trying to get the btrfs-progs test suite running under UML.

In a test in which it mounts a loop device, UML is segfaulting for me:

Modules linked in:
Pid: 20, comm: kworker/0:1H Not tainted 5.3.0-rc3
RIP: 0033:[<00000000602b074e>]
RSP: 00000000de6f3e18  EFLAGS: 00010246
RAX: 00000000602b074b RBX: 00000000de6a4600 RCX: 0000000000002000
RDX: 0000000000000001 RSI: 00000000de6a4600 RDI: 0000000000000000
RBP: 00000000de6f3e70 R08: 0000000000000000 R09: 0000000000000001
R10: fefefefefefefeff R11: 00000000de000030 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 20 Comm: kworker/0:1H Not tainted 5.3.0-rc3 #1
Workqueue: kblockd blk_mq_requeue_work
Stack:
  602b4e20 de69b4d0 00000000 de69b4d0
  00000000 de6f3e70 de6a1540 de6f3e80
  de69b4d0 602b4d40 00000000 de6f3eb0
Call Trace:
  [<602b4e20>] ? blk_mq_sched_insert_request+0xe0/0x107
  [<602b4d40>] ? blk_mq_sched_insert_request+0x0/0x107
  [<602b0e68>] blk_mq_requeue_work+0xd5/0x138
  [<6004d7d2>] process_one_work+0x1eb/0x34f
  [<603f8b40>] ? __schedule+0x0/0x358
  [<6004f5e9>] ? wq_worker_running+0x10/0x32
  [<6004b30a>] ? move_linked_works+0x0/0x4f
  [<6004eac3>] worker_thread+0x338/0x47b
  [<6004b4ad>] ? set_pf_worker+0x0/0x62
  [<60052c42>] ? __kthread_parkme+0x4f/0x97
  [<6003a4e6>] ? do_exit+0x0/0x902
  [<6004e78b>] ? worker_thread+0x0/0x47b
  [<60053168>] kthread+0x1a4/0x1ac
  [<6001ced9>] new_thread_handler+0x81/0xb2

Running under gdb provides a slightly different stack trace:

#0  blk_mq_dispatch_rq_list (q=<optimized out>, list=0xddef3d80, 
got_budget=false) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/block/blk-mq.c:1219
#1  0x00000000602b4c9c in blk_mq_sched_dispatch_requests 
(hctx=0xdde9ee00) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/block/blk-mq-sched.c:222
#2  0x00000000602af159 in __blk_mq_run_hw_queue (hctx=0xdde9ee00) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/block/blk-mq.c:1387
#3  0x00000000602af1b4 in __blk_mq_delay_run_hw_queue (hctx=0xdde9ee00, 
async=<optimized out>, msecs=<optimized out>) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/block/blk-mq.c:1455
#4  0x00000000602af30c in blk_mq_run_hw_queue (hctx=0xdde9ee00, 
async=<optimized out>) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/block/blk-mq.c:1492
#5  0x00000000602af356 in blk_mq_run_hw_queues (q=0xdde9b4d0, 
async=false) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/block/blk-mq.c:1509
#6  0x00000000602b0ec0 in blk_mq_requeue_work (work=<optimized out>) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/block/blk-mq.c:762
#7  0x000000006004d7d2 in process_one_work (worker=0xdddc1240, 
work=0xdde9b960) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/kernel/workqueue.c:2269
#8  0x000000006004eac3 in worker_thread (__worker=0xdddc1240) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/kernel/workqueue.c:2415
#9  0x0000000060053168 in kthread (_create=0xddeaad00) at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/kernel/kthread.c:255
#10 0x000000006001ced9 in new_thread_handler () at 
/tmp/btrfs-ci-work/src/linux-33920f1ec5bf47c5c0a1d2113989bdd9dfb3fae9/arch/um/kernel/process.c:133
#11 0x0000000000000000 in ?? ()

Here is how I build the kernel:

https://github.com/CyberShadow/btrfs-ci/blob/641f385b4ff126828556850e8aafb3839a77d1d5/src/build-kernel.sh

Any idea what causes it? Is it a kernel bug, a problem with the kernel 
configuration?

Thanks!

-- 
Best regards,
  Vladimir

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


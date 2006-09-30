Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GThk1-0006xs-0z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 09:31:05 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GThk0-0006W3-8L
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 09:31:04 -0700
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
	by gwu.lbox.cz (Sendmail) with ESMTP id k8UGUu1D022717
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 30 Sep 2006 18:30:56 +0200
Message-ID: <451E9BAB.5030009@linuxbox.cz>
Date: Sat, 30 Sep 2006 19:30:35 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
Subject: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest,
	problems with noprocmm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hello everybody,
I've been trying to get x86_64 guest UMLs working on SMP x86_64 host 
machine for quite long time, during today and yesterday I've also 
checked 2.6.18 (+ both skas & skas-fremap v9pre9), but it's still not 
working as good as 32bit/32bit was working for me for last few years ;). 
Soo, do You somebody know what could I be doing wrong?
Running full SKAS kernel segfaults with following error:
Kernel panic - not syncing: map_stub_pages : /proc/mm map for code 
failed, err = 22
(full trace listing below)
I've noticed on some other discussions that SKAS mode is still not fully 
working on x86_64, so I'd like to ask, what are remaining issues, and 
maybe could I somehow try helping in fixing them? I wonder why /proc/mm 
is used, what's /proc/mm64? shouldn't it be used instead?
Running noprocmm or skas0 mode is a bit better, guest system seems to be 
working quite OK (at least with 2.6.18, older kernels had some 
networking issues), but when I try to shutdown guest, it hangs at last 
stage, remaining uml process cycling:
--- SIGVTALRM (Virtual timer expired) @ 0 (0) ---
rt_sigprocmask(SIG_UNBLOCK, [USR1], [USR1 ALRM VTALRM WINCH IO], 8) = 0
gettimeofday({1159632583, 625562}, NULL) = 0
gettimeofday({1159632583, 625582}, NULL) = 0
gettimeofday({1159632583, 625603}, NULL) = 0
rt_sigreturn(0x1)                       = 2266636588
forever, consuming all CPU time and waiting to be shot by 9mm signal..
Any ideas?
thanks in advance
NiK.

and promised SKAS mode segfault trace:
[42949373.810000] Kernel panic - not syncing: map_stub_pages : /proc/mm 
map for code failed, err = 22
[42949373.810000]
[42949373.810000]
[42949373.810000] Modules linked in:
[42949373.810000] Pid: 1, comm: swapper Not tainted 2.6.18lb2.00_01_PRE01
[42949373.810000] RIP: 0033:[<00000000601ceb99>]
[42949373.810000] RSP: 00002b07c6a7afd0  EFLAGS: 00000246
[42949373.810000] RAX: 0000000000000000 RBX: 0000000000002969 RCX: 
ffffffffffffffff
[42949373.810000] RDX: 0000000000000000 RSI: 0000000000000013 RDI: 
0000000000002969
[42949373.810000] RBP: 0000000000002966 R08: 0000000000000001 R09: 
0000000000000000
[42949373.810000] R10: 0000000000000000 R11: 0000000000000246 R12: 
00002b07c6a7a000
[42949373.810000] R13: 00007fffe402d328 R14: 00007fffe402d7b8 R15: 
00007fffe402d7e8
[42949373.810000] Call Trace:
[42949373.810000] 60ecb968:  [<60018d0a>] panic_exit+0x2a/0x50
[42949373.810000] 60ecb978:  [<6005dba0>] notifier_call_chain+0x20/0x40
[42949373.810000] 60ecb998:  [<60049bdf>] panic+0xcf/0x170
[42949373.810000] 60ecb9e0:  [<60014f40>] copy_to_user_proc+0x0/0x30
[42949373.810000] 60ecb9f8:  [<600838e6>] prep_new_page+0x126/0x200
[42949373.810000] 60ecba18:  [<601fa139>] __syscall_error_1+0x6/0x1d
[42949373.810000] 60ecba28:  [<60038ba5>] file_io+0x35/0x110
[42949373.810000] 60ecba38:  [<60014f40>] copy_to_user_proc+0x0/0x30
[42949373.810000] 60ecba78:  [<6003f83a>] map_stub_pages+0x13a/0x280
[42949373.810000] 60ecbac8:  [<60084079>] __alloc_pages+0x59/0x2e0
[42949373.810000] 60ecbb78:  [<6001c5d1>] new_mm+0x61/0x80
[42949373.810000] 60ecbb98:  [<6001bfd7>] init_new_context_skas+0x117/0x1e0
[42949373.810000] 60ecbba8:  [<60013b67>] pgd_alloc+0x67/0x70
[42949373.810000] 60ecbbe8:  [<600ad808>] do_execve+0x278/0x290
[42949373.810000] 60ecbc10:  [<600121b0>] init+0x0/0x170
[42949373.810000] 60ecbc38:  [<60012a74>] execve1+0x24/0x80
[42949373.810000] 60ecbc68:  [<60012ada>] um_execve+0xa/0x50
[42949373.810000] 60ecbc78:  [<600b53f9>] dupfd+0x79/0xb0
[42949373.810000] 60ecbc88:  [<60012179>] run_init_process+0x49/0x80
[42949373.810000] 60ecbc98:  [<600121b0>] init+0x0/0x170
[42949373.810000] 60ecbcb8:  [<6001227f>] init+0xcf/0x170
[42949373.810000] 60ecbcd8:  [<6003aeee>] run_kernel_thread+0x4e/0x60
[42949373.810000] 60ecbcf8:  [<600121b0>] init+0x0/0x170
[42949373.810000] 60ecbd08:  [<600121b0>] init+0x0/0x170
[42949373.810000] 60ecbd38:  [<6003aecb>] run_kernel_thread+0x2b/0x60
[42949373.810000] 60ecbd88:  [<60044e52>] schedule_tail+0x32/0x1b0
[42949373.810000] 60ecbdd8:  [<6001c2ed>] new_thread_handler+0xdd/0x140
[42949373.810000] 60ecbe38:  [<601ce6b0>] __restore_rt+0x0/0x10
[42949373.810000] 60ecbee8:  [<601ceb99>] __kill+0x9/0x20


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

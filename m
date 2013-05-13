Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ubmvn-0004VC-N1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 May 2013 07:12:23 +0000
Received: from mail-wg0-f47.google.com ([74.125.82.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ubmvm-00026J-6n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 May 2013 07:12:23 +0000
Received: by mail-wg0-f47.google.com with SMTP id e11so6084936wgh.14
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 13 May 2013 00:12:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51901400.4060302@gmx.de>
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
	<CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
	<CAFLxGvwEiE0dfw9Vju_Xg6mXkF_NH_OU_t7puPceYN42dphTLA@mail.gmail.com>
	<518FE33B.60701@gmx.de>
	<CAFLxGvyiKbbkPAG0h42y1fb=Z6YuboJPdyb+2Xk9Z2YYt7oryg@mail.gmail.com>
	<518FF354.7020408@gmx.de>
	<CAFLxGvxYjpt6X9MQF3Huh-Sqzm3CBMJAfGb_Qjpqu00iUzj=qg@mail.gmail.com>
	<518FFBA3.6000800@gmx.de>
	<CAFLxGvx+8wpBeF_TqOk3JKBEoADAS-NeatpJMuSVvaDhZNqE0g@mail.gmail.com>
	<CAFLxGvzSEY8iciEONkxNGeO6Lt5v4VcB2sF1XPcqLA=n8PUaAQ@mail.gmail.com>
	<51901400.4060302@gmx.de>
Date: Mon, 13 May 2013 09:12:15 +0200
Message-ID: <CAFLxGvx-saWcJ+JCubUBAVT70OSMZDYNETqiNijJgXeqCPwwUA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, May 13, 2013 at 12:13 AM, Toralf F=F6rster <toralf.foerster@gmx.de>=
 wrote:
> On 05/12/2013 11:28 PM, richard -rw- weinberger wrote:
>> Toralf, please test the attached patch.
>
> This happens here after applying the strnlen + stub4 patch on top of 3.10=
-rc1

This looks like another issue.
Are you testing process_vm_writev() with trinity?
Looks like it managed to overwrite the stub page of a process, which
is not good.

>
> 2013-05-12T23:49:11.000+02:00 trinity sshd[1034]: pam_unix(sshd:session):=
 session opened for user root by (uid=3D0)
> 2013-05-12T23:50:01.000+02:00 trinity cron[1048]: (root) CMD (test -x /us=
r/sbin/run-crons && /usr/sbin/run-crons)
> 2013-05-12T23:50:58.943+02:00 trinity kernel: Stub registers -
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   0 - 100000
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   1 - 2000
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   2 - 0
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   3 - 0
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   4 - 0
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   5 - 0
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   6 - 0
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   7 - 7b
> 2013-05-12T23:50:58.943+02:00 trinity kernel:   8 - 7b
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   9 - 0
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   10 - 33
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   11 - ffffffff
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   12 - 1000c3
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   13 - 73
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   14 - 10206
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   15 - 101028
> 2013-05-12T23:50:58.947+02:00 trinity kernel:   16 - 7b
> 2013-05-12T23:50:58.947+02:00 trinity kernel: wait_stub_done : failed to =
wait for SIGTRAP, pid =3D 21982, n =3D 21982, errno =3D 0, status =3D 0xb7f
> 2013-05-12T23:54:30.012+02:00 trinity kernel: INFO: task trinity-child1:1=
079 blocked for more than 120 seconds.
> 2013-05-12T23:54:30.012+02:00 trinity kernel: "echo 0 > /proc/sys/kernel/=
hung_task_timeout_secs" disables this message.
> 2013-05-12T23:54:30.012+02:00 trinity kernel: trinity-child1  D 40001282 =
    0  1079   1025 0x00000000
> 2013-05-12T23:54:30.012+02:00 trinity kernel: 41090aac 00000001 00000000 =
4027fc78 0805f98f 4014caac 41090aac 40278000
> 2013-05-12T23:54:30.012+02:00 trinity kernel: 4014c600 4027fca8 0836071c =
4014c600 41090600 00000001 0a554200 4027fcb8
> 2013-05-12T23:54:30.012+02:00 trinity kernel: 18f581ac 40278000 4014c600 =
4014c600 400ba71c 4027fcbc 083607b5 4027fcbc 4027fc64:  [<0805f98f>] __swit=
ch_to+0x5f/0x100
> 2013-05-12T23:54:30.012+02:00 trinity kernel: 4027fc7c:  [<0836071c>] __s=
chedule+0x32c/0x370
> 2013-05-12T23:54:30.012+02:00 trinity kernel: 4027fcac:  [<083607b5>] sch=
edule+0x55/0x60
> 2013-05-12T23:54:30.012+02:00 trinity kernel: 4027fcc0:  [<083612b5>] __d=
own_read+0x95/0xb0
> 2013-05-12T23:54:30.012+02:00 trinity kernel: 4027fcf4:  [<0835ff51>] dow=
n_read+0x11/0x20
> 2013-05-12T23:54:30.017+02:00 trinity kernel: 4027fd00:  [<080f20f5>] pro=
cess_vm_rw_core.isra.5+0x1f5/0x5c0
> 2013-05-12T23:54:30.017+02:00 trinity kernel: 4027fdd8:  [<080f258d>] pro=
cess_vm_rw+0xcd/0x110
> 2013-05-12T23:54:30.017+02:00 trinity kernel: 4027fe94:  [<080f2640>] SyS=
_process_vm_writev+0x30/0x40
> 2013-05-12T23:54:30.017+02:00 trinity kernel: 4027feac:  [<08062ac2>] han=
dle_syscall+0x82/0xb0
> 2013-05-12T23:54:30.017+02:00 trinity kernel: 4027fef4:  [<0807519d>] use=
rspace+0x46d/0x590
> 2013-05-12T23:54:30.017+02:00 trinity kernel: 4027ffec:  [<0805f7fc>] for=
k_handler+0x6c/0x70
> 2013-05-12T23:54:30.017+02:00 trinity kernel: 4027fffc:  [<00000000>] 0x0
> 2013-05-12T23:54:30.017+02:00 trinity kernel:
> 2013-05-12T23:54:30.017+02:00 trinity kernel: INFO: task trinity-child0:1=
081 blocked for more than 120 seconds.
> 2013-05-12T23:54:30.017+02:00 trinity kernel: "echo 0 > /proc/sys/kernel/=
hung_task_timeout_secs" disables this message.
> 2013-05-12T23:54:30.022+02:00 trinity kernel: trinity-child0  D 40001282 =
    0  1081   1025 0x00000002
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 41090aac 00000001 00000000 =
402f79e4 0805f98f 4014e2ac 41090aac 402f0000
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 4014de00 402f7a14 0836071c =
4014de00 41090600 00000001 080fad7d 41350390
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 000000bb 402f0000 400ba70c =
400ba708 4014de00 402f7a28 083607b5 402f7a28 402f79d0:  [<0805f98f>] __swit=
ch_to+0x5f/0x100
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 402f79e8:  [<0836071c>] __s=
chedule+0x32c/0x370
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 402f7a18:  [<083607b5>] sch=
edule+0x55/0x60
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 402f7a2c:  [<08361337>] __d=
own_write_nested+0x67/0xb0
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 402f7a60:  [<08361399>] __d=
own_write+0x19/0x1b
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 402f7a70:  [<0835ff71>] dow=
n_write+0x11/0x13
> 2013-05-12T23:54:30.022+02:00 trinity kernel: 402f7a7c:  [<0814cc9a>] do_=
coredump+0x16a/0x1090
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7b48:  [<0808c943>] get=
_signal_to_deliver+0x553/0x580
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7b74:  [<08060adc>] ker=
n_do_signal+0x28c/0x370
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7c4c:  [<08060bdd>] do_=
signal+0x1d/0x20
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7c58:  [<08061ed8>] fat=
al_sigsegv+0x28/0x30
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7c6c:  [<080749fb>] wai=
t_stub_done+0xeb/0x100
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7c98:  [<08073edf>] run=
_syscall_stub+0x16f/0x2c0
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7ccc:  [<080744ef>] unm=
ap+0xff/0x110
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7d14:  [<080610c4>] do_=
ops+0xa4/0x150
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7d54:  [<0806168e>] fix=
_range_common+0x46e/0x4b0
> 2013-05-12T23:54:30.026+02:00 trinity kernel: 402f7dd4:  [<080619ee>] flu=
sh_tlb_mm_range+0x2e/0x30
> 2013-05-12T23:54:30.030+02:00 trinity kernel: 402f7dec:  [<080e8cab>] unm=
ap_region+0xcb/0xe0
> 2013-05-12T23:54:30.030+02:00 trinity kernel: 402f7e28:  [<080ea951>] do_=
munmap+0x231/0x2a0
> 2013-05-12T23:54:30.030+02:00 trinity kernel: 402f7e60:  [<080ecf53>] SyS=
_mremap+0x263/0x480
> 2013-05-12T23:54:30.030+02:00 trinity kernel: 402f7eac:  [<08062ac2>] han=
dle_syscall+0x82/0xb0
> 2013-05-12T23:54:30.030+02:00 trinity kernel: 402f7ef4:  [<0807519d>] use=
rspace+0x46d/0x590
> 2013-05-12T23:54:30.030+02:00 trinity kernel: 402f7fec:  [<0805f7fc>] for=
k_handler+0x6c/0x70
> 2013-05-12T23:54:30.030+02:00 trinity kernel: 402f7ffc:  [<00000000>] 0x0
> 2013-05-12T23:54:30.030+02:00 trinity kernel:
> 2013-05-12T23:56:30.026+02:00 trinity kernel: INFO: task trinity-child1:1=
079 blocked for more than 120 seconds.
> 2013-05-12T23:56:30.026+02:00 trinity kernel: "echo 0 > /proc/sys/kernel/=
hung_task_timeout_secs" disables this message.
> 2013-05-12T23:56:30.026+02:00 trinity kernel: trinity-child1  D 40001282 =
    0  1079   1025 0x00000000
> 2013-05-12T23:56:30.026+02:00 trinity kernel: 41090aac 00000001 00000000 =
4027fc78 0805f98f 4014caac 41090aac 40278000
> 2013-05-12T23:56:30.026+02:00 trinity kernel: 4014c600 4027fca8 0836071c =
4014c600 41090600 00000001 0a554200 4027fcb8
> 2013-05-12T23:56:30.026+02:00 trinity kernel: 18f581ac 40278000 4014c600 =
4014c600 400ba71c 4027fcbc 083607b5 4027fcbc 4027fc64:  [<0805f98f>] __swit=
ch_to+0x5f/0x100
> 2013-05-12T23:56:30.026+02:00 trinity kernel: 4027fc7c:  [<0836071c>] __s=
chedule+0x32c/0x370
> 2013-05-12T23:56:30.026+02:00 trinity kernel: 4027fcac:  [<083607b5>] sch=
edule+0x55/0x60
> 2013-05-12T23:56:30.026+02:00 trinity kernel: 4027fcc0:  [<083612b5>] __d=
own_read+0x95/0xb0
> 2013-05-12T23:56:30.026+02:00 trinity kernel: 4027fcf4:  [<0835ff51>] dow=
n_read+0x11/0x20
> 2013-05-12T23:56:30.030+02:00 trinity kernel: 4027fd00:  [<080f20f5>] pro=
cess_vm_rw_core.isra.5+0x1f5/0x5c0
> 2013-05-12T23:56:30.030+02:00 trinity kernel: 4027fdd8:  [<080f258d>] pro=
cess_vm_rw+0xcd/0x110
> 2013-05-12T23:56:30.030+02:00 trinity kernel: 4027fe94:  [<080f2640>] SyS=
_process_vm_writev+0x30/0x40
> 2013-05-12T23:56:30.030+02:00 trinity kernel: 4027feac:  [<08062ac2>] han=
dle_syscall+0x82/0xb0
> 2013-05-12T23:56:30.030+02:00 trinity kernel: 4027fef4:  [<0807519d>] use=
rspace+0x46d/0x590
> 2013-05-12T23:56:30.030+02:00 trinity kernel: 4027ffec:  [<0805f7fc>] for=
k_handler+0x6c/0x70
> 2013-05-12T23:56:30.030+02:00 trinity kernel: 4027fffc:  [<00000000>] 0x0
> 2013-05-12T23:56:30.030+02:00 trinity kernel:
> 2013-05-12T23:56:30.030+02:00 trinity kernel: INFO: task trinity-child0:1=
081 blocked for more than 120 seconds.
> 2013-05-12T23:56:30.030+02:00 trinity kernel: "echo 0 > /proc/sys/kernel/=
hung_task_timeout_secs" disables this message.
> 2013-05-12T23:56:30.034+02:00 trinity kernel: trinity-child0  D 40001282 =
    0  1081   1025 0x00000002
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 41090aac 00000001 00000000 =
402f79e4 0805f98f 4014e2ac 41090aac 402f0000
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 4014de00 402f7a14 0836071c =
4014de00 41090600 00000001 080fad7d 41350390
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 000000bb 402f0000 400ba70c =
400ba708 4014de00 402f7a28 083607b5 402f7a28 402f79d0:  [<0805f98f>] __swit=
ch_to+0x5f/0x100
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 402f79e8:  [<0836071c>] __s=
chedule+0x32c/0x370
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 402f7a18:  [<083607b5>] sch=
edule+0x55/0x60
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 402f7a2c:  [<08361337>] __d=
own_write_nested+0x67/0xb0
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 402f7a60:  [<08361399>] __d=
own_write+0x19/0x1b
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 402f7a70:  [<0835ff71>] dow=
n_write+0x11/0x13
> 2013-05-12T23:56:30.034+02:00 trinity kernel: 402f7a7c:  [<0814cc9a>] do_=
coredump+0x16a/0x1090
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7b48:  [<0808c943>] get=
_signal_to_deliver+0x553/0x580
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7b74:  [<08060adc>] ker=
n_do_signal+0x28c/0x370
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7c4c:  [<08060bdd>] do_=
signal+0x1d/0x20
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7c58:  [<08061ed8>] fat=
al_sigsegv+0x28/0x30
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7c6c:  [<080749fb>] wai=
t_stub_done+0xeb/0x100
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7c98:  [<08073edf>] run=
_syscall_stub+0x16f/0x2c0
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7ccc:  [<080744ef>] unm=
ap+0xff/0x110
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7d14:  [<080610c4>] do_=
ops+0xa4/0x150
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7d54:  [<0806168e>] fix=
_range_common+0x46e/0x4b0
> 2013-05-12T23:56:30.041+02:00 trinity kernel: 402f7dd4:  [<080619ee>] flu=
sh_tlb_mm_range+0x2e/0x30
> 2013-05-12T23:56:30.048+02:00 trinity kernel: 402f7dec:  [<080e8cab>] unm=
ap_region+0xcb/0xe0
> 2013-05-12T23:56:30.048+02:00 trinity kernel: 402f7e28:  [<080ea951>] do_=
munmap+0x231/0x2a0
> 2013-05-12T23:56:30.048+02:00 trinity kernel: 402f7e60:  [<080ecf53>] SyS=
_mremap+0x263/0x480
> 2013-05-12T23:56:30.048+02:00 trinity kernel: 402f7eac:  [<08062ac2>] han=
dle_syscall+0x82/0xb0
> 2013-05-12T23:56:30.048+02:00 trinity kernel: 402f7ef4:  [<0807519d>] use=
rspace+0x46d/0x590
> 2013-05-12T23:56:30.048+02:00 trinity kernel: 402f7fec:  [<0805f7fc>] for=
k_handler+0x6c/0x70
> 2013-05-12T23:56:30.048+02:00 trinity kernel: 402f7ffc:  [<00000000>] 0x0
> 2013-05-12T23:56:30.048+02:00 trinity kernel:
>
>
> I restarted the trinity.sh test script again and it gave after few minute=
s :
>
>
> 2013-05-13T00:01:36.009+02:00 trinity kernel: Stub registers -
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   0 - 100000
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   1 - 2000
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   2 - 0
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   3 - 0
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   4 - 0
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   5 - 0
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   6 - 0
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   7 - 7b
> 2013-05-13T00:01:36.009+02:00 trinity kernel:   8 - 7b
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   9 - 0
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   10 - 33
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   11 - ffffffff
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   12 - 1000c3
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   13 - 73
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   14 - 10206
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   15 - 101028
> 2013-05-13T00:01:36.013+02:00 trinity kernel:   16 - 7b
> 2013-05-13T00:01:36.013+02:00 trinity kernel: wait_stub_done : failed to =
wait for SIGTRAP, pid =3D 23566, n =3D 23566, errno =3D 0, status =3D 0xb7f
>
> and then repeated "INFO: task trinity-child0:1093 blocked for more than 1=
20 seconds."
>
> --
> MfG/Sincerely
> Toralf F=F6rster
> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3



--
Thanks,
//richard

---------------------------------------------------------------------------=
---
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and =

their applications. This 200-page book is written by three acclaimed =

leaders in the field. The early access version is available now. =

Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


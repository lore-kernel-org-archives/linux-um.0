Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9R1z-0002U4-AU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 09:28:47 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1C9R1w-0003kJ-68 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 09:28:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 3ED8A40B7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Sep 2004 18:28:32 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09806-42
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Sep 2004 18:28:28 +0200 (CEST)
Received: from [10.0.2.5] (port-212-202-42-108.dynamic.qsc.de [212.202.42.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 0D07119CF
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Sep 2004 18:28:27 +0200 (CEST)
Message-ID: <414F0532.503@exse.net>
From: =?ISO-8859-1?Q?Sebastian_B=F6hm?= <seb@exse.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080708000601080202030604"
Subject: [uml-devel] crash of a host
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
Date: Mon, 20 Sep 2004 18:28:34 +0200
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080708000601080202030604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

had a crash of a host which was running one uml instance:

Host is a linux 2.6.8 with "host-skas3-2.6.7-v2.patch".
Guest is a  "2.4.26-20040615UML-1um" (downloaded that kernel from 
umlazi, is a 2.4.24-1 patched 2.4.26)

/sebastian
-----------------------------------------
Sep 20 17:10:07 smuga kernel: c011f1eb
Sep 20 17:10:07 smuga kernel: Modules linked in: tun ipv6 8250 
serial_core 3c59x rtc reiserfs isofs ext2 ext3 jbd mbcache ide_
generic aec62xx trm290 alim15x3 hpt34x hpt366 ide_disk cmd64x piix 
rz1000 slc90e66 cs5530 opti621 ns87415 cy82c693 amd74xx sis
5513 via82cxxx serverworks ide_core unix
Sep 20 17:10:07 smuga kernel: CPU:    0
Sep 20 17:10:07 smuga kernel: EIP:    0060:[__dequeue_signal+139/416]    
Not tainted
Sep 20 17:10:07 smuga kernel: EFLAGS: 00010002   (2.6.8)
Sep 20 17:10:07 smuga kernel: EIP is at __dequeue_signal+0x8b/0x1a0
Sep 20 17:10:07 smuga kernel: eax: 00189d6c   ebx: 00000003   ecx: 
00000003   edx: 00189d6c
Sep 20 17:10:07 smuga kernel: esi: 00000000   edi: e7b36b2e   ebp: 
00000002   esp: da333eac
Sep 20 17:10:07 smuga kernel: ds: 007b   es: 007b   ss: 0068
Sep 20 17:10:07 smuga kernel: Process linux_virtual06 (pid: 14168, 
threadinfo=da332000 task=f79dc070)
Sep 20 17:10:07 smuga kernel: Stack: e7b36b2e f79dc594 8027b8c0 00000000 
00000000 da333f28 f79dc594 f79dc070
Sep 20 17:10:07 smuga kernel:        c011f388 e7b36b2e f79dc594 da333f28 
da332000 f79dc594 da332000 ffffe000
Sep 20 17:10:07 smuga kernel:        c012091c f79dc070 f79dc594 da333f28 
da332000 f79dc594 da333fc4 f79dc594
Sep 20 17:10:07 smuga kernel: Call Trace:
Sep 20 17:10:07 smuga kernel:  [dequeue_signal+136/144] 
dequeue_signal+0x88/0x90
Sep 20 17:10:07 smuga kernel:  [get_signal_to_deliver+92/736] 
get_signal_to_deliver+0x5c/0x2e0
Sep 20 17:10:07 smuga kernel:  [do_signal+149/288] do_signal+0x95/0x120
Sep 20 17:10:07 smuga kernel:  [schedule_timeout+109/192] 
schedule_timeout+0x6d/0xc0
Sep 20 17:10:07 smuga kernel:  [process_timeout+0/16] 
process_timeout+0x0/0x10
Sep 20 17:10:07 smuga kernel:  [sys_nanosleep+222/368] 
sys_nanosleep+0xde/0x170
Sep 20 17:10:07 smuga kernel:  [do_notify_resume+53/56] 
do_notify_resume+0x35/0x38
Sep 20 17:10:07 smuga kernel:  [work_notifysig+19/21] 
work_notifysig+0x13/0x15
Sep 20 17:10:07 smuga kernel: Code: 8b 00 0f 18 00 90 39 fa 75 eb 85 f6 
0f 84 86 00 00 00 8b 06
Sep 20 17:10:07 smuga kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000010
Sep 20 17:10:07 smuga kernel: c011edcb
Sep 20 17:10:07 smuga kernel: Modules linked in: tun ipv6 8250 
serial_core 3c59x rtc reiserfs isofs ext2 ext3 jbd mbcache ide_
generic aec62xx trm290 alim15x3 hpt34x hpt366 ide_disk cmd64x piix 
rz1000 slc90e66 cs5530 opti621 ns87415 cy82c693 amd74xx sis
5513 via82cxxx serverworks ide_core unix
Sep 20 17:10:07 smuga kernel: CPU:    0
Sep 20 17:10:07 smuga kernel: EIP:    0060:[next_signal+27/80]    Not 
tainted
Sep 20 17:10:07 smuga kernel: EFLAGS: 00010046   (2.6.8)
Sep 20 17:10:07 smuga kernel: EIP is at next_signal+0x1b/0x50
Sep 20 17:10:07 smuga kernel: eax: ffffffff   ebx: 00000010   ecx: 
00000000   edx: 00000008
Sep 20 17:10:07 smuga kernel: esi: f7961bb4   edi: 00000008   ebp: 
f7961690   esp: e33fdea0
Sep 20 17:10:07 smuga kernel: ds: 007b   es: 007b   ss: 0068
Sep 20 17:10:07 smuga kernel: Process screen (pid: 14167, 
threadinfo=e33fc000 task=f7961690)
Sep 20 17:10:07 smuga kernel: Stack: 00000000 e33fdf28 c011f17b 00000008 
f7961bb4 c01a1acb 00000246 00000000
Sep 20 17:10:07 smuga kernel:        e33fdf28 f7961bb4 f7961690 c011f388 
00000008 f7961bb4 e33fdf28 e33fc000
Sep 20 17:10:07 smuga kernel:        f7961bb4 e33fc000 ffffe000 c012091c 
f7961690 f7961bb4 e33fdf28 e33fc000
Sep 20 17:10:07 smuga kernel: Call Trace:
Sep 20 17:10:07 smuga kernel:  [__dequeue_signal+27/416] 
__dequeue_signal+0x1b/0x1a0
Sep 20 17:10:07 smuga kernel:  [pty_write_room+43/48] 
pty_write_room+0x2b/0x30
Sep 20 17:10:07 smuga kernel:  [dequeue_signal+136/144] 
dequeue_signal+0x88/0x90
Sep 20 17:10:07 smuga kernel:  [get_signal_to_deliver+92/736] 
get_signal_to_deliver+0x5c/0x2e0
Sep 20 17:10:07 smuga kernel:  [do_signal+149/288] do_signal+0x95/0x120
Sep 20 17:10:07 smuga kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep 20 17:10:07 smuga kernel:  [sys_select+564/1216] sys_select+0x234/0x4c0
Sep 20 17:10:07 smuga kernel:  [do_notify_resume+53/56] 
do_notify_resume+0x35/0x38
Sep 20 17:10:07 smuga kernel:  [work_notifysig+19/21] 
work_notifysig+0x13/0x15
Sep 20 17:10:07 smuga kernel: Code: 23 42 08 74 17 b9 01 00 00 00 0f bc 
c0 01 c1 8b 1c 24 8b 74
Sep 20 17:10:07 smuga kernel:  <1>Unable to handle kernel paging request 
at virtual address 6aa4c29d
Sep 20 17:10:07 smuga kernel: c011edcb
Sep 20 17:10:07 smuga kernel: Modules linked in: tun ipv6 8250 
serial_core 3c59x rtc reiserfs isofs ext2 ext3 jbd mbcache ide_
generic aec62xx trm290 alim15x3 hpt34x hpt366 ide_disk cmd64x piix 
rz1000 slc90e66 cs5530 opti621 ns87415 cy82c693 amd74xx sis
5513 via82cxxx serverworks ide_core unix
Sep 20 17:10:07 smuga kernel: CPU:    0
Sep 20 17:10:07 smuga kernel: EIP:    0060:[next_signal+27/80]    Not 
tainted
Sep 20 17:10:07 smuga kernel: EFLAGS: 00010046   (2.6.8)
Sep 20 17:10:07 smuga kernel: EIP is at next_signal+0x1b/0x50
Sep 20 17:10:07 smuga kernel: eax: ffffffff   ebx: 6aa4c29d   ecx: 
00000000   edx: 6aa4c295
Sep 20 17:10:07 smuga kernel: esi: c17f1b94   edi: 6aa4c295   ebp: 
c17f1670   esp: c17f3ea0
Sep 20 17:10:07 smuga kernel: ds: 007b   es: 007b   ss: 0068
Sep 20 17:10:07 smuga kernel: Process init (pid: 1, threadinfo=c17f2000 
task=c17f1670)
Sep 20 17:10:07 smuga kernel: Stack: 00000000 c17f3f28 c011f17b 6aa4c295 
c17f1b94 6986aa7a 00000246 00000000
Sep 20 17:10:07 smuga kernel:        c17f3f28 c17f1b94 c17f1670 c011f388 
6aa4c295 c17f1b94 c17f3f28 c17f2000
Sep 20 17:10:07 smuga kernel:        c17f1b94 c17f2000 ffffe000 c012091c 
c17f1670 c17f1b94 c17f3f28 c17f2000
Sep 20 17:10:07 smuga kernel: Call Trace:
Sep 20 17:10:07 smuga kernel:  [__dequeue_signal+27/416] 
__dequeue_signal+0x1b/0x1a0
Sep 20 17:10:07 smuga kernel:  [dequeue_signal+136/144] 
dequeue_signal+0x88/0x90
Sep 20 17:10:07 smuga kernel:  [get_signal_to_deliver+92/736] 
get_signal_to_deliver+0x5c/0x2e0
Sep 20 17:10:07 smuga kernel:  [do_signal+149/288] do_signal+0x95/0x120
Sep 20 17:10:07 smuga kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep 20 17:10:07 smuga kernel:  [sys_select+564/1216] sys_select+0x234/0x4c0
Sep 20 17:10:07 smuga kernel:  [do_notify_resume+53/56] 
do_notify_resume+0x35/0x38
Sep 20 17:10:07 smuga kernel:  [work_notifysig+19/21] 
work_notifysig+0x13/0x15
Sep 20 17:10:07 smuga kernel: Code: 23 42 08 74 17 b9 01 00 00 00 0f bc 
c0 01 c1 8b 1c 24 8b 74
Sep 20 17:10:07 smuga kernel:  <0>Kernel panic: Attempted to kill init!
Sep 20 18:00:06 smuga syslogd 1.4.1#15: restart.


--------------080708000601080202030604
Content-Type: text/x-vcard; charset=utf-8;
 name="seb.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="seb.vcf"

begin:vcard
fn;quoted-printable:Sebastian B=C3=B6hm
n;quoted-printable:B=C3=B6hm;Sebastian
email;internet:seb@exse.net
tel;work:0351-4758645
tel;fax:0351-4758645
tel;home:0351-6526999
tel;cell:0173-3807351
note;quoted-printable:get my key:=0D=0A=
	"gpg --keyserver www.keyserver.net --recv-keys EA996E36"
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------080708000601080202030604--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

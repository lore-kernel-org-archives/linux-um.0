Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWWhh-0004jB-AN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 01:11:17 -0800
Received: from [80.71.3.50] (helo=titan.server-plant.co.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWWhf-0000Kb-UT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 01:11:17 -0800
Message-ID: <32863.217.46.152.98.1101201072.squirrel@217.46.152.98>
From: "Leigh Brown" <leigh@solinno.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] Kernel BUG in host
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
Date: Tue, 23 Nov 2004 09:11:12 -0000 (GMT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hello,

The host is running Debian Sarge 2.6.8.1 kernel patched with
host-skas3-2.6.7-v7.patch.  The guest is running Debian Sarge
2.4.26-um3.  I'm seeing this kernel bug in the host after one
or two days running:

kernel BUG at mm/mmap.c:337!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: tun ipv6 eepro100 mii bridge rtc ext3 jbd mbcache
ide_generic via82cxxx pdc202xx_old ide_disk ide_core raid1 md unix
CPU:    1
EIP:    0060:[<c0151048>]    Not tainted
EFLAGS: 00010287   (2.6.8-1-686-smp-mwil)
EIP is at __insert_vm_struct+0x48/0x90
eax: 40276000   ebx: f7bff6a0   ecx: f6ee681c   edx: f6ee6804
esi: c1fed414   edi: 00000000   ebp: c1d98bc4   esp: f6e45e60
ds: 007b   es: 007b   ss: 0068
Process linux (pid: 1108, threadinfo=f6e44000 task=c1ddebf0)
Stack: f7bff6a0 00278000 f6e45e74 f6e45e78 f6e45e7c 00000000 f6ee6828
f6ee681c
       f6f2e804 f78cee94 c0151273 f7bff6a0 c1fed414 00000001 c015a771
c1d98bc4
       00000000 00000000 c1f81560 c1d98be4 00000000 f7bff6a0 00006b44
00278000
Call Trace:
 [<c0151273>] vma_adjust+0x1e3/0x3f0
 [<c015a771>] free_pages_and_swap_cache+0x71/0xa0
 [<c015263d>] split_vma+0xcd/0x120
 [<c015283d>] do_munmap+0x1ad/0x1d0
 [<c01b93c2>] copy_from_user+0x42/0x70
 [<c015d4ef>] write_proc_mm+0x15f/0x180
 [<c015fe2d>] vfs_write+0xed/0x160
 [<c015ff71>] sys_write+0x51/0x80
 [<c01061fb>] syscall_call+0x7/0xb
Code: 0f 0b 51 01 e9 07 2b c0 89 74 24 04 8b 44 24 1c 89 1c 24 89
 <6>note: linux[1108] exited with preempt_count 1

Any suggestions would be gratefully received.  I'm happy to try
kernel patches or get more information from the system, if it helps.

Cheers,

Leigh.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

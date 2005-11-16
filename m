Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcQeI-0008Nl-2G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 09:00:42 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcQeG-0006yf-JN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 09:00:42 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAGIYRP3018495
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Nov 2005 13:34:27 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161100.31053.rob@landley.net>
Subject: [uml-devel] Getting the x86-64 rollup patch to work on my x86 laptop.
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
Date: Wed, 16 Nov 2005 11:00:30 -0600
To: user-mode-linux-devel@lists.sourceforge.net

So I took the rollup patch I posted earlier (which made things work on 
x86-64), and tried to compile it on my x86 Ubuntu "Horny Hedgehog" laptop.  I 
had to revert the /lib64 change, of course.  (I need to come up with a good 
fix for that.) 

I also needed to change one more thing: replacing <asm/signal.h> with 
<signal.h> in skas-i386/stub_segv.c.  (I.E. the same kind of fix I had to 
make for skas-x86_64/stub_segv.c.)

That got it to build.  Here's the panic and the dissassembly:

Initialized stdio console driver
Console initialized on /dev/tty0
Failed to open 'root_fs', errno = 2
VFS: Mounted root (hostfs filesystem).
Stub registers -
        0 - 0
        1 - 0
        2 - 0
        3 - 0
        4 - 0
        5 - 0
        6 - 0
        7 - 7b
        8 - 7b
        9 - 0
        10 - 33
        11 - ffffffff
        12 - 40000c20
        13 - 73
        14 - 210246
        15 - bf55ec10
        16 - 7b
Kernel panic - not syncing: get_skas_faultinfo : failed to wait for 
SIGUSR1/SIGTRAP, pid = 13213, n = 13213, errno = 0, status = 0xb7f


EIP: 0073:[<40000c20>] CPU: 0 Not tainted ESP: 007b:bf55ec10 EFLAGS: 00210246
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
088a7bac:  [<08080b5d>] notifier_call_chain+0x2d/0x50
088a7bc8:  [<080714a1>] panic+0x71/0x110
088a7be0:  [<0805e910>] wait_stub_done+0x100/0x190
088a7c60:  [<0805ea1a>] get_skas_faultinfo+0x7a/0xa0
088a7c70:  [<0806a081>] save_registers+0x41/0x80
088a7c78:  [<08060602>] user_signal+0x62/0x70
088a7c8c:  [<0805f0f0>] userspace+0x180/0x220
088a7cd8:  [<08055f50>] init+0x0/0x170
088a7ce4:  [<0805fc12>] new_thread_handler+0xf2/0x130

081130b0 <stub_segv_handler>:
 81130b0:       8b 44 24 5c             mov    0x5c(%esp),%eax
 81130b4:       8d 54 24 08             lea    0x8(%esp),%edx
 81130b8:       a3 04 f0 ff bf          mov    %eax,0xbffff004
 81130bd:       8b 44 24 3c             mov    0x3c(%esp),%eax
 81130c1:       a3 00 f0 ff bf          mov    %eax,0xbffff000
 81130c6:       8b 44 24 38             mov    0x38(%esp),%eax
 81130ca:       a3 08 f0 ff bf          mov    %eax,0xbffff008
 81130cf:       89 d0                   mov    %edx,%eax
 81130d1:       89 c4                   mov    %eax,%esp
 81130d3:       b8 77 00 00 00          mov    $0x77,%eax
 81130d8:       cd 80                   int    $0x80
 81130da:       c3                      ret

08113000 <stub_clone_handler>:
 8113000:       83 ec 14                sub    $0x14,%esp
 8113003:       ba 78 00 00 00          mov    $0x78,%edx
 8113008:       b9 fc f7 ff bf          mov    $0xbffff7fc,%ecx
 811300d:       89 5c 24 04             mov    %ebx,0x4(%esp)
 8113011:       89 d0                   mov    %edx,%eax
 8113013:       bb 11 84 00 00          mov    $0x8411,%ebx
 8113018:       89 6c 24 10             mov    %ebp,0x10(%esp)
 811301c:       bd 00 f0 ff bf          mov    $0xbffff000,%ebp
 8113021:       89 74 24 08             mov    %esi,0x8(%esp)
 8113025:       89 7c 24 0c             mov    %edi,0xc(%esp)
 8113029:       cd 80                   int    $0x80
 811302b:       85 c0                   test   %eax,%eax
 811302d:       89 c7                   mov    %eax,%edi
 811302f:       75 5c                   jne    811308d 
<stub_clone_handler+0x8d>
 8113031:       b8 1a 00 00 00          mov    $0x1a,%eax
 8113036:       89 fb                   mov    %edi,%ebx
 8113038:       89 f9                   mov    %edi,%ecx
 811303a:       89 fa                   mov    %edi,%edx
 811303c:       89 fe                   mov    %edi,%esi
 811303e:       cd 80                   int    $0x80
 8113040:       85 c0                   test   %eax,%eax
 8113042:       89 c7                   mov    %eax,%edi
 8113044:       75 47                   jne    811308d 
<stub_clone_handler+0x8d>
 8113046:       be 68 00 00 00          mov    $0x68,%esi
 811304b:       bb 01 00 00 00          mov    $0x1,%ebx
 8113050:       b9 08 f0 ff bf          mov    $0xbffff008,%ecx
 8113055:       89 f0                   mov    %esi,%eax
 8113057:       89 fa                   mov    %edi,%edx
 8113059:       cd 80                   int    $0x80
 811305b:       85 c0                   test   %eax,%eax
 811305d:       89 c7                   mov    %eax,%edi
 811305f:       75 2c                   jne    811308d 
<stub_clone_handler+0x8d>
 8113061:       8b 1d 00 f0 ff bf       mov    0xbffff000,%ebx
 8113067:       b9 00 10 00 00          mov    $0x1000,%ecx
 811306c:       ba 03 00 00 00          mov    $0x3,%edx
 8113071:       be 11 00 00 00          mov    $0x11,%esi
 8113076:       8b 3d 04 f0 ff bf       mov    0xbffff004,%edi
 811307c:       89 d8                   mov    %ebx,%eax
 811307e:       89 eb                   mov    %ebp,%ebx
 8113080:       55                      push   %ebp
 8113081:       89 c5                   mov    %eax,%ebp
 8113083:       b8 c0 00 00 00          mov    $0xc0,%eax
 8113088:       cd 80                   int    $0x80
 811308a:       5d                      pop    %ebp
 811308b:       89 c7                   mov    %eax,%edi
 811308d:       89 7d 18                mov    %edi,0x18(%ebp)
 8113090:       cc                      int3
 8113091:       8b 5c 24 04             mov    0x4(%esp),%ebx
 8113095:       8b 74 24 08             mov    0x8(%esp),%esi
 8113099:       8b 7c 24 0c             mov    0xc(%esp),%edi
 811309d:       8b 6c 24 10             mov    0x10(%esp),%ebp
 81130a1:       83 c4 14                add    $0x14,%esp
 81130a4:       c3                      ret
 81130a5:       90                      nop
 81130a6:       90                      nop
 81130a7:       90                      nop
 81130a8:       90                      nop
 81130a9:       90                      nop
 81130aa:       90                      nop
 81130ab:       90                      nop
 81130ac:       90                      nop
 81130ad:       90                      nop
 81130ae:       90                      nop
 81130af:       90                      nop

This make any sense to you?  (the original 2.6.15-rc1 builds for me just fine 
on x86, but I'd like a codebase that builds on both x86-64 and x86.  Yes, I'm 
picky...)

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

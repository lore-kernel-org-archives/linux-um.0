Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWI6t-0001B3-TE
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 08:31:47 -0800
Received: from userbb201.dsl.pipex.com ([62.190.241.201] helo=irishsea.home.craig-wood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AWI6t-0002mv-3c
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 08:31:47 -0800
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Message-ID: <20031216163134.GA30608@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] skas3 + 2.4.21 oops
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Dec 2003 16:31:34 +0000
To: user-mode-linux-devel@lists.sourceforge.net

We are running the skas3 patch (host-skas3.patch from the uml website)
on top of a debian 2.4.21 kernel tree with fairsched.  We got these
oopses recently.  After the second the server was basically unusable -
any attempt to use tools like ps to access the process table just
never returned.

We have swapped out the harddisks to a different computer to try to
fix this problem with no luck.  I guess it must be some usage pattern
of the clients that are causing it.  The clients are running UML
linux-2.4.20-6.

Both of the oopses have write_proc_mm() in the backtrace...

Any ideas?

------------------------------------------------------------

ksymoops 2.4.5 on i686 2.4.21-ms1-p4smp.  Options used
     -V (default)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.21-ms1-p4smp/ (default)
     -m /boot/System.map-2.4.21-ms1-p4smp (default)

Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/md/raid1.o for module raid1 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/md/md.o for module md has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/fs/jbd/jbd.o for module jbd has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/net/unix/unix.o for module unix has changed since load
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01f3995
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01f3995>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f6175d98   ecx: f6175d98   edx: 00000000
esi: f6b78a84   edi: f6b78a84   ebp: 00000001   esp: dc025f0c
ds: 0018   es: 0018   ss: 0018
Process linux (pid: 5129, stackpage=dc025000)
Stack: 00000000 f5904918 c01f3bc4 00000000 f6175d98 f6b78a84 f5904900 c8f33e0c 
       f6b78a84 f5904900 c012b084 f5904918 f6b78a84 0000001c f6b78a9c f6b78a80 
       0000001c 412b8000 00000000 f68ca800 c8f33e00 c013969a f6b78a80 412b7000 
Call Trace:    [<c01f3bc4>] [<c012b084>] [<c013969a>] [<c013b917>] [<c0108a23>]
Code: 83 7a 04 00 75 1b c7 42 04 01 00 00 00 c7 43 04 00 00 00 00 


>>EIP; c01f3995 <__rb_erase_color+21/184>   <=====

>>ebx; f6175d98 <_end+35e67764/384fe9cc>
>>ecx; f6175d98 <_end+35e67764/384fe9cc>
>>esi; f6b78a84 <_end+3686a450/384fe9cc>
>>edi; f6b78a84 <_end+3686a450/384fe9cc>
>>esp; dc025f0c <_end+1bd178d8/384fe9cc>

Trace; c01f3bc4 <rb_erase+cc/d8>
Trace; c012b084 <do_munmap+10c/254>
Trace; c013969a <write_proc_mm+da/150>
Trace; c013b917 <sys_write+8f/100>
Trace; c0108a23 <system_call+33/38>

Code;  c01f3995 <__rb_erase_color+21/184>
00000000 <_EIP>:
Code;  c01f3995 <__rb_erase_color+21/184>   <=====
   0:   83 7a 04 00               cmpl   $0x0,0x4(%edx)   <=====
Code;  c01f3999 <__rb_erase_color+25/184>
   4:   75 1b                     jne    21 <_EIP+0x21> c01f39b6 <__rb_erase_color+42/184>
Code;  c01f399b <__rb_erase_color+27/184>
   6:   c7 42 04 01 00 00 00      movl   $0x1,0x4(%edx)
Code;  c01f39a2 <__rb_erase_color+2e/184>
   d:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)


8 warnings issued.  Results may not be reliable.

------------------------------------------------------------
ksymoops 2.4.5 on i686 2.4.21-ms1-p4smp.  Options used
     -V (default)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.21-ms1-p4smp/ (default)
     -m /boot/System.map-2.4.21-ms1-p4smp (default)

Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/md/raid1.o for module raid1 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/drivers/md/md.o for module md has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/fs/jbd/jbd.o for module jbd has changed since load
Warning (expand_objects): object /lib/modules/2.4.21-ms1-p4smp/kernel/net/unix/unix.o for module unix has changed since load
 kernel BUG at mmap.c:735!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012aca8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: f402ff5c   ebx: f6175d80   ecx: d263df98   edx: d263df80
esi: 08213000   edi: d263df98   ebp: ea893680   esp: f402ff20
ds: 0018   es: 0018   ss: 0018
Process linux (pid: 5056, stackpage=f402f000)
Stack: 0000001c 00001000 ea893680 0000001c c012afd4 ea893680 08213000 f402ff5c 
       0000001c ea89369c ea893680 0000001c c013965d 00000000 f6f63a80 d263df80 
       c013969a ea893680 08213000 00001000 00000000 f6f63a80 ffffffea 0000001c 
Call Trace:    [<c012afd4>] [<c013965d>] [<c013969a>] [<c013b917>] [<c0108a23>]
Code: 0f 0b df 02 21 4a 20 c0 89 d8 eb 0c 8b 44 24 1c c7 00 00 00 


>>EIP; c012aca8 <find_vma_prev+90/b0>   <=====

>>eax; f402ff5c <_end+33d21928/384fe9cc>
>>ebx; f6175d80 <_end+35e6774c/384fe9cc>
>>ecx; d263df98 <_end+1232f964/384fe9cc>
>>edx; d263df80 <_end+1232f94c/384fe9cc>
>>esi; 08213000 Before first symbol
>>edi; d263df98 <_end+1232f964/384fe9cc>
>>ebp; ea893680 <_end+2a58504c/384fe9cc>
>>esp; f402ff20 <_end+33d218ec/384fe9cc>

Trace; c012afd4 <do_munmap+5c/254>
Trace; c013965d <write_proc_mm+9d/150>
Trace; c013969a <write_proc_mm+da/150>
Trace; c013b917 <sys_write+8f/100>
Trace; c0108a23 <system_call+33/38>

Code;  c012aca8 <find_vma_prev+90/b0>
00000000 <_EIP>:
Code;  c012aca8 <find_vma_prev+90/b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012acaa <find_vma_prev+92/b0>
   2:   df 02                     fild   (%edx)
Code;  c012acac <find_vma_prev+94/b0>
   4:   21 4a 20                  and    %ecx,0x20(%edx)
Code;  c012acaf <find_vma_prev+97/b0>
   7:   c0 89 d8 eb 0c 8b 44      rorb   $0x44,0x8b0cebd8(%ecx)
Code;  c012acb6 <find_vma_prev+9e/b0>
   e:   24 1c                     and    $0x1c,%al
Code;  c012acb8 <find_vma_prev+a0/b0>
  10:   c7 00 00 00 00 00         movl   $0x0,(%eax)


8 warnings issued.  Results may not be reliable.
------------------------------------------------------------

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

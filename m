Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AN2BO-0004wN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 19:42:10 -0800
Received: from [216.156.129.65] (helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AN2BN-0005bl-Pz
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 19:42:09 -0800
Received: from hawk (mothership.theshore.net [68.52.199.4])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id hAL3gFWh008815
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 22:42:15 -0500
Message-ID: <001401c3afe1$5a5b6f70$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <877k1w85vh.fsf@amaterasu.srvr.nix> <3FBBD9CA.2010303@vgertech.com> <3FBCA6DA.7020407@vgertech.com>  <87r8033vyo.fsf@amaterasu.srvr.nix>  <200311210228.hAL2Sv4L004167@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Host Oops with 2.4.22-6um on 2.6.0-test9-bk24
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 20 Nov 2003 21:41:29 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

For what it's worth...

Testing with 2.6.0-test9-bk24 with the skas3 2.6 patch that was posted a while
ago, I'm able to get the following oops on the host with a 2.4.22-6um kernel.
Interestingly, it only happens on a few of the virtual machines on the host, but
it happens every time with the ones that do it.

Reading Oops report from the terminal
Oops: 0002 [#2]
Oops: 0002 [#2]
CPU:    2
EIP:    0060:[<c01112ff>]    Not tainted
EFLAGS: 00010202
EIP is at write_ldt+0x1a4/0x240
eax: 00000000   ebx: 000f0000   ecx: 40cff202   edx: 00000001
CPU:    2
EIP:    0060:[<c01112ff>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: 000f0000   ecx: 40cff202   edx: 00000001
esi: 70a0ffff   edi: f57e1928   ebp: f57e1800   esp: f580df2c
esi: 70a0ffff   edi: f57e1928   ebp: f57e1800   esp: f580df2c
ds: 007b   es: 007b   ss: 0068
Process 2.4.22-linode12 (pid: 5279, threadinfo=f580c000 task=f584c080)
Stack: f654bba4 00000001 00000001 eda4607e 00000000 00000000 400270a0 000fffff
ds: 007b   es: 007b   ss: 0068
Stack: f654bba4 00000001 00000001 eda4607e 00000000 00000000 400270a0 000fffff
       00000051 a5b801e0 f65626b0 f580dfa0 f65626b0 c01113f3 f65626b0 a5b801e0
       00000051 a5b801e0 f65626b0 f580dfa0 f65626b0 c01113f3 f65626b0 a5b801e0
       00000010 00000001 fffffffb 00000000 c011033f f65626b0 00000001 a5b801e0
Call Trace:
       00000010 00000001 fffffffb 00000000 c011033f f65626b0 00000001 a5b801e0
Call Trace:
 [<c01113f3>] modify_ldt+0x58/0x88
 [<c011033f>] sys_ptrace+0x7d7/0x840
 [<c012e6d7>] sys_rt_sigprocmask+0xb4/0x180
 [<c01113f3>] modify_ldt+0x58/0x88
 [<c011033f>] sys_ptrace+0x7d7/0x840
 [<c012e6d7>] sys_rt_sigprocmask+0xb4/0x180
 [<c010ad9f>] syscall_call+0x7/0xb

 [<c010ad9f>] syscall_call+0x7/0xb
Code: 89 30 89 48 04 31 f6 89 f9 f0 ff 85 28 01 00 00 0f 8e 70 01
Code: 89 30 89 48 04 31 f6 89 f9 f0 ff 85 28 01 00 00 0f 8e 70 01


>>EIP; c01112ff <save_i387_fxsave+3f/140>   <=====

Trace; c01113f3 <save_i387_fxsave+133/140>
Trace; c011033f <sys_ipc+25f/260>
Trace; c012e6d7 <vmtruncate_list+27/70>
Trace; c010ad9f <handle_IRQ_event+f/b0>

Code;  c01112ff <save_i387_fxsave+3f/140>
00000000 <_EIP>:
Code;  c01112ff <save_i387_fxsave+3f/140>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c0111301 <save_i387_fxsave+41/140>
   2:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0111304 <save_i387_fxsave+44/140>
   5:   31 f6                     xor    %esi,%esi
Code;  c0111306 <save_i387_fxsave+46/140>
   7:   89 f9                     mov    %edi,%ecx
Code;  c0111308 <save_i387_fxsave+48/140>
   9:   f0 ff 85 28 01 00 00      lock incl 0x128(%ebp)
Code;  c011130f <save_i387_fxsave+4f/140>
  10:   0f 8e 70 01 00 00         jle    186 <_EIP+0x186>

-Chris




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

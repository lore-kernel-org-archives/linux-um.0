Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6jE2-0005cN-9B for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 21:50:18 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D6gVi-0000bq-OB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 18:56:27 -0800
Received: from [192.168.0.4] (office.rimuhosting.co.nz [222.152.52.159] (may
	be forged)) (authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id j232r8Wa001054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Mar 2005 02:53:12 GMT
Message-ID: <42267C13.1060703@rimuhosting.com>
From: Peter <p.repliesignored@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.11 + uml.sf.net patches panic
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
Date: Thu, 03 Mar 2005 15:53:07 +1300
To: user-mode-linux-devel@lists.sourceforge.net

Hi.  I'm getting a kernel panic on the 2.6.11 code from 
user-mode-linux.sf.net.

Details: host=2.6.8.1+skas3v8.  guest = 2.6.11 plus the 2.6.11-rc3-mm2 
tarball from user-mode-linux.sf.net minus x11-fb, cross-build (in order 
to get past a compile error).

The panic happens when starting up a Java process (specifically starting 
up tomcat).

The problem does not occur with a vanilla 2.6.11 guest.

I'm happy to carry on using vanilla 2.6.11.  But hopefully the stack 
trace below triggers some insight into a problem with one of the latest 
uml.sf.net patches.

Regards, Peter

Starting Tomcat: Kernel panic - not syncing: Kernel mode fault at addr 
0x98c1003f, ip 0x4013a3e4

EIP: 0073:[<4013a3e4>] CPU: 0 Not tainted ESP: 007b:4bc77eec EFLAGS: 
00000202
     Not tainted
EAX: ffffffda EBX: 00000001 ECX: 4bc77f14 EDX: 00000010
ESI: 000fffff EDI: 00000010 EBP: 4bc77fec DS: 007b ES: 007b
Call Trace:
1014b678:  [<0807ab26>] printk+0x12/0x14
1014b688:  [<08087826>] notifier_call_chain+0x22/0x40
1014b6b8:  [<0807a282>] panic+0x56/0x104
1014b6c8:  [<08063cff>] segv+0x7f/0x270
1014b6d8:  [<08063e5a>] segv+0x1da/0x270
1014b740:  [<08064070>] segv_handler+0x0/0xa8
1014b748:  [<0807235e>] change_signals+0x42/0x6c
1014b7b8:  [<08064114>] segv_handler+0xa4/0xa8
1014b7f0:  [<08064070>] segv_handler+0x0/0xa8
1014b7f8:  [<080668c1>] sig_handler_common_skas+0x8d/0xdc
1014b808:  [<080668ba>] sig_handler_common_skas+0x86/0xdc
1014b828:  [<0807212a>] sig_handler+0x12/0x14
1014b888:  [<08074d0e>] write_ldt+0x1a6/0x2d8
1014b8f0:  [<080617cb>] um_virt_to_phys+0x4b/0x84
1014b8f4:  [<080f3000>] journal_switch_revoke_table+0x50/0x60
1014b910:  [<080669aa>] maybe_map+0x26/0x84
1014b92c:  [<080f41e1>] journal_update_superblock+0x1d/0x9c
1014b940:  [<08066a5e>] do_op+0x56/0x60
1014b960:  [<08066ad3>] do_buffer_op+0x6b/0x134
1014b970:  [<08066bf0>] copy_chunk_from_user+0x0/0x2c
1014b990:  [<08066bf0>] copy_chunk_from_user+0x0/0x2c
1014b9b0:  [<0807390d>] setjmp_wrapper+0x4d/0x54


[root@fc3 ~]# /etc/init.d/tomcat start
Starting Tomcat: Kernel panic - not syncing: Kernel mode fault at addr 
0x98c1003f, ip 0x4013a3e4

EIP: 0073:[<4013a3e4>] CPU: 0 Not tainted ESP: 007b:4bc77eec EFLAGS: 
00000202
     Not tainted
EAX: ffffffda EBX: 00000001 ECX: 4bc77f14 EDX: 00000010
ESI: 000fffff EDI: 00000010 EBP: 4bc77fec DS: 007b ES: 007b
Call Trace:
1028f678:  [<0807ab26>] printk+0x12/0x14
1028f688:  [<08087826>] notifier_call_chain+0x22/0x40
1028f6b8:  [<0807a282>] panic+0x56/0x104
1028f6c8:  [<08063cff>] segv+0x7f/0x270
1028f6d8:  [<08063e5a>] segv+0x1da/0x270
1028f740:  [<08064070>] segv_handler+0x0/0xa8
1028f748:  [<0807235e>] change_signals+0x42/0x6c
1028f7b8:  [<08064114>] segv_handler+0xa4/0xa8
1028f7f0:  [<08064070>] segv_handler+0x0/0xa8
1028f7f8:  [<080668c1>] sig_handler_common_skas+0x8d/0xdc
1028f808:  [<080668ba>] sig_handler_common_skas+0x86/0xdc
1028f828:  [<0807212a>] sig_handler+0x12/0x14
1028f888:  [<08074d0e>] write_ldt+0x1a6/0x2d8
1028f8f0:  [<080617cb>] um_virt_to_phys+0x4b/0x84
1028f8f4:  [<08234000>] ip6_mc_del_src+0xd4/0x19c
1028f910:  [<080669aa>] maybe_map+0x26/0x84
1028f92c:  [<082351e1>] igmp6_mcf_seq_show+0x189/0x1c4
1028f940:  [<08066a5e>] do_op+0x56/0x60
1028f960:  [<08066ad3>] do_buffer_op+0x6b/0x134
1028f970:  [<08066bf0>] copy_chunk_from_user+0x0/0x2c
1028f990:  [<08066bf0>] copy_chunk_from_user+0x0/0x2c
1028f9b0:  [<0807390d>] setjmp_wrapper+0x4d/0x54



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

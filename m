Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ELIio-0000Jr-Hz	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 04:06:34 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ELIin-00019N-Bv
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 04:06:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Error running UML
References: <229e70f205093003511a49c171@mail.gmail.com>
In-Reply-To: <229e70f205093003511a49c171@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509301306.08001.blaisorblade@yahoo.it>
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
Date: Fri, 30 Sep 2005 13:06:07 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Etay Meiri <etay.meiri@gmail.com>

On Friday 30 September 2005 12:51, Etay Meiri wrote:
> Hi,
>
> I downloaded a root file system from:
> http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.bz2
> and followed the instructions in
> http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.note
> in order to extract it. I am able to mount it as a loop device without
> problems.
> I applied the patch from
> http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.13-bs2/u
>ml-2.6.13-bs2.patch.bz2 to the 2.6.13 vanilla kernel and built a uml kernel
> with ext3 support not as a module.
> Now when I run it I get the following error:

> [cl@amber uml]$ ./vmlinux mem=160M ubd0=root_fs.2005062201 ubd1=swap
> root=/dev/ubd/0 con=pty con0=fd:0,fd:1
root=/dev/ubd/0 is wrong for two reasons:
*) you don't need to specify root=, UML automatically sets it to point to ubd0

*) /dev/ubd/0 is the DevFS syntax, and since 2.6.13 DevFS is no more 
supported.

*) I'm not even sure if root=/dev/ubd0 would work - Uml, to be sure, uses 
major and minor (root=98:0).

Thanks for attaching the logs, but look below:
> [42949373.560000] VFS: Cannot open root device "ubd/0" or
> unknown-block(0,0) [42949373.560000] Please append a correct "root=" boot
> option
> [42949373.560000] Kernel panic - not syncing: VFS: Unable to mount root fs
> on unknown-block(0,0)
> [42949373.560000]

The trace below is always output in case of panic, but in this case it's not a 
kernel bug, so don't get confused by it.
> [42949373.560000] EIP: 0073:[<a0382721>] CPU: 0 Not tainted ESP:
> 007b:b7f7df9c EFLAGS: 00200246
> [42949373.560000] Not tainted
> [42949373.560000] EAX: 00000000 EBX: 00000a1f ECX: 00000013 EDX: 00000a1f
> [42949373.560000] ESI: 00000a1e EDI: 00000011 EBP: b7f7dfb8 DS: 007b ES:
> 007b
> [42949373.560000] aae97ac0: [<a006304d>] show_regs+0x309/0x378
> [42949373.560000] aae97af0: [<a002d1c3>] panic_exit+0x43/0x8c
> [42949373.560000] aae97b20: [<a0097206>] notifier_call_chain+0x2e/0x88
> [42949373.560000] aae97b50: [<a006d7df>] panic+0x9f/0x1f8
> [42949373.560000] aae97b80: [<a000231a>] mount_block_root+0x116/0x1cc
> [42949373.560000] aae97bd0: [<a00025ee>] mount_root+0x7e/0x94
> [42949373.560000] aae97bf0: [<a000266d>] prepare_namespace+0x69/0x224
> [42949373.560000] aae97c00: [<a001c3c7>] init+0x1d7/0x220
> [42949373.560000] aae97c20: [<a00227c5>] run_kernel_thread+0x59/0x74
> [42949373.560000] aae97ce0: [<a003538e>] new_thread_handler+0xd2/0x138
> [42949373.560000] aae97d20: [<b7f7f420>] 0xb7f7f420
> [42949373.560000]
> [42949373.560000]

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

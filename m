Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cmrss-0000wx-ND for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jan 2005 03:02:22 -0800
Received: from webhosting.rdsbv.ro ([213.157.185.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cmrsq-0001ef-Kr
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jan 2005 03:02:22 -0800
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Subject: Re: [uml-devel] 2.6.10 command line longer than 512 characters
In-Reply-To: <Pine.LNX.4.58.0501071154410.22595@cube.iu.hio.no>
Message-ID: <Pine.LNX.4.61.0501071259370.5729@webhosting.rdsbv.ro>
References: <Pine.LNX.4.58.0501071105351.22595@cube.iu.hio.no>
	<Pine.LNX.4.61.0501071224310.5729@webhosting.rdsbv.ro>
	<Pine.LNX.4.58.0501071154410.22595@cube.iu.hio.no>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1646943047-1758957568-1105095620=:5729"
Content-ID: <Pine.LNX.4.61.0501071302070.5729@webhosting.rdsbv.ro>
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
Date: Fri, 7 Jan 2005 13:02:09 +0200 (EET)
To: Kyrre M Begnum <Kyrre.Begnum@iu.hio.no>
Cc: user-mode-linux-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1646943047-1758957568-1105095620=:5729
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; FORMAT=flowed
Content-ID: <Pine.LNX.4.61.0501071302071.5729@webhosting.rdsbv.ro>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by webhosting.rdsbv.ro id
	j07B2AAW024107

>> You have a patch at:
>> http://kernel.umbrella.ro/kpatches/uml-extend-cmd-line-limits.patch
>
> Thank you very much. Is this patch coing to find its way into mainstram
> UML at some point or do I have to look for it in the future too?

I forwarded it to Jeff and it "saw" the linux-kernel mailing list but no=20
reponse from kernel folks.

>
>>
>>>
>>> I have noticed that when I supply a command line longer than 513
>>> characters (or was it 512?) the kernel crashes. Output supplied at th=
e end
>>> of mail. This does not seem to be a problem on the old 2.4.24
>>> guest kernels. Is there a way I can change this, perhaps during kerne=
l
>>> configuration?
>>>
>>>
>>> Notice the strange symbols at the end of the printed kernel kommand l=
ine:
>>> (The ^J appeard after pasting into the email)
>>>
>>> Linux version 2.6.10 (kyrre@legolas) (gcc version 3.3.5 (Debian
>>> 1:3.3.5-5)) #1 SMP Thu Jan 6 12:07:34 CET 2005
>>> Built 1 zonelists
>>> Kernel command line: con=3Dpty con1=3Dfd:0,fd:2 mem=3D32M
>>> ubd0=3D/home/kyrre/.mln_user_mode_build/357/debian.cow,/home/kyrre/ml=
ntest/templates/Debian-3.0r0-V0.6.ext2
>>> ubd1=3D/home/kyrre/mlntest/projects/simple-network/images/blowfish
>>> ubd2=3D/home/kyrre/mlntest/projects/simple-network/images/catfish
>>> ubd3=3D/home/kyrre/mlntest/projects/simple-network/images/starfish
>>> project=3D/home/kyrre/mlntest/projects files=3D/home/kyrre/mlntest/fi=
les
>>> mln=3D/home/kyrre/.mln_user_mode_build/357 mln_command=3D"-L legolas =
build -C
>>> -f /tmp/mln/simple-network.mln -h blow=C0=FC=8A
>>> PID hash table entries: 256 (order: 8, 4096 bytes)
>>> Kernel panic - not syncing: Segfault with no mm
>>> <6>Stopping all CPUs...done
>>>
>>> EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
>>>    Not tainted
>>> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>>> ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
>>> Call Trace:
>>> [<a004ebfd>] notifier_call_chain+0x2d/0x50
>>> [<a0205866>] bust_spinlocks+0x46/0x50
>>> [<a003cc86>] panic+0x76/0x120
>>> [<a001e91c>] segv+0x1cc/0x230
>>> [<a02db334>] sigemptyset+0x24/0x40
>>> [<a001c085>] change_signals+0x65/0x90
>>> [<a001ecff>] segv_handler+0x16f/0x220
>>> [<a002519f>] sig_handler_common_skas+0x8f/0xc0
>>> [<a0024a50>] start_kernel_proc+0x0/0x40
>>> [<a001ee04>] sig_handler+0x34/0x40
>>> [<a02db208>] __restore+0x0/0x8
>>> [<a0024a50>] start_kernel_proc+0x0/0x40
>>> [<a02096b7>] vsnprintf+0x37/0x4d0
>>> [<a02db208>] __restore+0x0/0x8
>>> [<a001dec0>] boot_timer_handler+0x0/0x40
>>> [<a02db208>] __restore+0x0/0x8
>>> [<a02db208>] __restore+0x0/0x8
>>> [<a001dec0>] boot_timer_handler+0x0/0x40
>>> [<a02db208>] __restore+0x0/0x8
>>> [<a02db334>] sigemptyset+0x24/0x40
>>> [<a001c085>] change_signals+0x65/0x90
>>> [<a02db334>] sigemptyset+0x24/0x40
>>> [<a001c085>] change_signals+0x65/0x90
>>> [<a02db334>] sigemptyset+0x24/0x40
>>> [<a001c22d>] set_signals+0x7d/0x130
>>> [<a001c193>] get_signals+0x33/0x50
>>> [<a03200be>] _spin_unlock_irqrestore+0xe/0x20
>>> [<a003dae9>] release_console_sem+0x79/0xc0
>>> [<a0024a50>] start_kernel_proc+0x0/0x40
>>> [<a003cc45>] panic+0x35/0x120
>>> [<a00027cd>] start_kernel+0x1ad/0x1b0
>>> [<a0002160>] unknown_bootoption+0x0/0x200
>>> [<a0024a7f>] start_kernel_proc+0x2f/0x40
>>> [<a0019028>] run_kernel_thread+0x78/0x80
>>> [<a0024a50>] start_kernel_proc+0x0/0x40
>>> [<a0018ff0>] run_kernel_thread+0x40/0x80
>>> [<a0024a50>] start_kernel_proc+0x0/0x40
>>> [<a0024715>] new_thread_handler+0x75/0xb0
>>> [<a0024a50>] start_kernel_proc+0x0/0x40
>>> [<a02db208>] __restore+0x0/0x8
>>> [<a02db2a1>] __kill+0x11/0x20
>>>
>>>
>>> Regrds.
>>>
>>> ---------------------
>>> Kyrre M Begnum
>>> Rom 1.755 7.etg
>>> Tfl: 22453276
>>>
>>>
>>> -------------------------------------------------------
>>> The SF.Net email is sponsored by: Beat the post-holiday blues
>>> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
>>> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
>>> _______________________________________________
>>> User-mode-linux-devel mailing list
>>> User-mode-linux-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>>
>>
>> ---
>> Catalin(ux aka Dino) BOIE
>> catab at deuroconsult.ro
>> http://kernel.umbrella.ro/
>
> ---------------------
> Kyrre M Begnum
> Rom 1.755 7.etg
> Tfl: 22453276
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
---1646943047-1758957568-1105095620=:5729--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

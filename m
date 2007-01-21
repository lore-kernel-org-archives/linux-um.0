Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H8cNB-0002jg-NW for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jan 2007 05:04:37 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H8cNB-0000cH-1r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jan 2007 05:04:37 -0800
Message-ID: <45B364DC.8040405@nagafix.co.uk>
Date: Sun, 21 Jan 2007 13:04:28 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <200701171715.35504.blaisorblade@yahoo.it>		<45AE684D.7070802@theshore.net>
	<45AE67C0.5080003@nagafix.co.uk>		<45AE7DFC.9050704@nagafix.co.uk>
	<45B0A4B7.7050702@nagafix.co.uk>		<1169222858.11134.52.camel@athena.fprintf.net>		<45B0EE71.5040908@nagafix.co.uk>	<1169224702.11134.71.camel@athena.fprintf.net>	<45B0F512.6020308@nagafix.co.uk>
	<45B10106.6060107@nagafix.co.uk>
	<45B12269.8040203@nagafix.co.uk> <45B32F92.80409@panasas.com>
In-Reply-To: <45B32F92.80409@panasas.com>
Subject: Re: [uml-devel] buggy UML AMD64?
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

>> On fully up to date Fedora Core 6 x86_64, the kernel does display 
>> something before crashing:
>> # uname -a
>> Linux localhost.localdomain 2.6.18-1.2869.fc6 #1 SMP Wed Dec 20 14:51:34 
>> EST 2006 x86_64 x86_64 x86_64 GNU/Linux
>> # ./kernel32-2.6.19.2
>> Checking that ptrace can change system call numbers...OK
>> Checking syscall emulation patch for ptrace...missing
>> Checking for tmpfs mount on /dev/shm...OK
>> Checking PROT_EXEC mmap in /dev/shm/...OK
>> Checking for the skas3 patch in the host:
>>    - /proc/mm...not found
>>    - PTRACE_FAULTINFO...not found
>>    - PTRACE_LDT...not found
>> UML running in SKAS0 mode
>>
>> [root@localhost home]#
>>
>> This is 100% repeatable. Plain Fedora.
>> Many users will have a similar setup and will just give up on UML.
>> So I as I said before, UML is currently unusable for most people out 
>> there running fairly recent systems.
> I have a 2.6.19, vanila kernel on top of redhat4, host.
There is one major difference in this case, redhat4 uses glibc 2.3 
whereas fc6 (and gentoo-current) use glibc 2.4
A lot of the problems that I am reporting started when glibc was 
upgraded (sorry I forgot to mention that)


> And any kernel between 2.6.17 - 2.6.20-rc5 x86_64 for guests.
> For my iSCSI tests they all run well.
> At the very beginning, I had bad crashes and I solved it with plain gdb.
> The point for us to use UML, from the begging, was to use gdb on our own kernel development.
> At the end it was very easy to find that I have miss-configured the uml kernel, when that was fixed every thing
> ran well.
> 
> for me I just do
> #gdb um/vmlinux (was compiled with -O um)
> gdb>run ubd0=/var/opt/FedoraCore5-AMD64-root_fs eth0=tuntap,,,192.168.0.117
> after first trap in gdb
> gdb>handle SIGUSR1 pass nostop noprint
> from than on its strait gdb, tell me if you need a script for loading symbols of kernel modules.
That would be great, it could go on the wiki too.

Thanks
Antoine

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

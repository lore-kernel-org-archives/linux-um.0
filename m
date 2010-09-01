Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bharrosh@panasas.com>) id 1OqlZA-0000Jz-Hw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Sep 2010 11:33:20 +0000
Received: from daytona.panasas.com ([67.152.220.89]
	helo=daytona.int.panasas.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqlZ7-00055e-BV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Sep 2010 11:33:20 +0000
Message-ID: <4C7E3715.2060803@panasas.com>
Date: Wed, 01 Sep 2010 14:20:53 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4C7C2DE4.3090203@iki.fi>
In-Reply-To: <4C7C2DE4.3090203@iki.fi>
Subject: Re: [uml-devel] UML development, anyone?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 08/31/2010 01:17 AM, Sakari Ailus wrote:
> Hello all,
> 
> I'm a long-time UML user and lately I've become a bit worried on the 
> state of the UML. This list, as well as the -user one, is very quiet 
> these days. Is there someone still actively developing the UML? I have 
> to say I really like it! Running Linux on Linux reliably and 
> efficiently, just what I need! :-)
> 
> I'm currently running three UML virtual machines on an server using 
> Athlon XP-M. The host is running 2.6.31 and the guests are 2.6.27.
> 
> I cannot upgrade neither host nor guests due to these problems:
> 
> - SKAS 3 patches available up to 2.6.31 only. Merging this to current 
> kernel might not be a problem, just some work, but:
> 
> - Severe data corruption on guest on recent guest kernel versions. I'm 
> using a few hard disk partitions directly for UML guests. Something 
> after 2.6.27 guest breaks this quite badly. Even for small data sets 
> like 100 MiB, copying a file to a different location on guest and then 
> running md5sum on both often produces a different result.
> 
> Do I have any options than to switch to Qemu and suffer the performance 
> penalty from emulation (kqemu is obsolete, too) or to switch to newer 
> hardware that supports kvm? Qemu performance is somewhat less than 10 % 
> of the native (or UML) performance.
> 
> I also found something called lguest but haven't given it a try yet. 
> Looks the most interesting but that doesn't seem to have much list 
> activity either. So it works perfectly for almost everyone or has few 
> users... ;)
> 
> How are others coping in the current situation? Or is it just me who has 
> these troubles...?
> 

I hear you ...

I'm using UML for years, as my developing platform for new Kernel code.
You can imagine how it shortens the development cycle. For guests I must
use the absolute newest Kernel all the time. So ...

- Please send a detailed bug report about that data corruption so someone
  can reproduce it. I'm not sure what block device you are using but it has
  a bug. If you have a good version 2.6.27 and a bad version 2.6.28. It should
  be easy to "git bisect" to the exact patch that broke the system, and should
  be easy to fix. (Tell me if you need help, it's easy really)

- I probably don't have your problem because in my UMLs /home is an NFS
  mount to the office /home server. And any other data intensive work
  is done over iscsi mounts. Look into iscsi Qemu mangament tools , they
  should work well for UML as well. (Note you'll need to kconfig scsi and
  iscsi in your guest compile, they are off by default)
  (The general rule is any UML specific drivers tend to rot faster then
   any generic driver like iscsi or nfs)

- SKAS 3: haaa SKAS3, that one is abandoned. It will need a maintainer to
  get it alive again. How much better is it? do you have some numbers.
  (I never used it, the all point was to keep the desktop (host) with a
  distro Kernel, nvidia and all that)

> Best regards,
> 

Cheers
Boaz

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


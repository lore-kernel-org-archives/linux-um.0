Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sakari.ailus@iki.fi>) id 1Ouh5P-000323-Tv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2010 07:34:51 +0000
Received: from smtp-68.nebula.fi ([83.145.220.68])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ouh5N-0005Nw-1w for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2010 07:34:51 +0000
Message-ID: <4C8C8291.2040303@iki.fi>
Date: Sun, 12 Sep 2010 10:34:41 +0300
From: Sakari Ailus <sakari.ailus@iki.fi>
MIME-Version: 1.0
References: <4C7C2DE4.3090203@iki.fi> <4C7E3715.2060803@panasas.com>
In-Reply-To: <4C7E3715.2060803@panasas.com>
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Boaz,

Boaz Harrosh wrote:
> On 08/31/2010 01:17 AM, Sakari Ailus wrote:
>> Hello all,
>>
>> I'm a long-time UML user and lately I've become a bit worried on the
>> state of the UML. This list, as well as the -user one, is very quiet
>> these days. Is there someone still actively developing the UML? I have
>> to say I really like it! Running Linux on Linux reliably and
>> efficiently, just what I need! :-)
>>
>> I'm currently running three UML virtual machines on an server using
>> Athlon XP-M. The host is running 2.6.31 and the guests are 2.6.27.
>>
>> I cannot upgrade neither host nor guests due to these problems:
>>
>> - SKAS 3 patches available up to 2.6.31 only. Merging this to current
>> kernel might not be a problem, just some work, but:
>>
>> - Severe data corruption on guest on recent guest kernel versions. I'm
>> using a few hard disk partitions directly for UML guests. Something
>> after 2.6.27 guest breaks this quite badly. Even for small data sets
>> like 100 MiB, copying a file to a different location on guest and then
>> running md5sum on both often produces a different result.
>>
>> Do I have any options than to switch to Qemu and suffer the performance
>> penalty from emulation (kqemu is obsolete, too) or to switch to newer
>> hardware that supports kvm? Qemu performance is somewhat less than 10 %
>> of the native (or UML) performance.
>>
>> I also found something called lguest but haven't given it a try yet.
>> Looks the most interesting but that doesn't seem to have much list
>> activity either. So it works perfectly for almost everyone or has few
>> users... ;)
>>
>> How are others coping in the current situation? Or is it just me who has
>> these troubles...?
>>
>
> I hear you ...
>
> I'm using UML for years, as my developing platform for new Kernel code.
> You can imagine how it shortens the development cycle. For guests I must
> use the absolute newest Kernel all the time. So ...
>
> - Please send a detailed bug report about that data corruption so someone
>    can reproduce it. I'm not sure what block device you are using but it has
>    a bug. If you have a good version 2.6.27 and a bad version 2.6.28. It should
>    be easy to "git bisect" to the exact patch that broke the system, and should
>    be easy to fix. (Tell me if you need help, it's easy really)

I did write about this back then but it seems no-one else had the same 
problem. It's one thing to find it and the other to fix it. My wild 
guess is that it's not a change to that actual driver that broke it.

> - I probably don't have your problem because in my UMLs /home is an NFS
>    mount to the office /home server. And any other data intensive work
>    is done over iscsi mounts. Look into iscsi Qemu mangament tools , they
>    should work well for UML as well. (Note you'll need to kconfig scsi and
>    iscsi in your guest compile, they are off by default)
>    (The general rule is any UML specific drivers tend to rot faster then
>     any generic driver like iscsi or nfs)

Using NFS root would indeed be another option.

> - SKAS 3: haaa SKAS3, that one is abandoned. It will need a maintainer to
>    get it alive again. How much better is it? do you have some numbers.
>    (I never used it, the all point was to keep the desktop (host) with a
>    distro Kernel, nvidia and all that)

SKAS4 was supposed to replace it and I think I even used it for a while 
but the current SKAS4 patch is even older than SKAS3. SKAS 4, as far as 
I understand, would be a long-term solution since the /dev/mm approach 
of SKAS 3 wasn't accepted by Linus.

<URL:http://user-mode-linux.sourceforge.net/old/skas.html>

You do need that to get decent performance with UML and at some point 
some years ago perhaps, I couldn't get it even working without.

Regards,

-- 
Sakari Ailus
sakari.ailus@iki.fi

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


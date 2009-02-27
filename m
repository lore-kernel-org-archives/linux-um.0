Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <brocka@sterlingcgi.com>) id 1Ld8K0-0007Z3-Hz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 19:24:32 +0000
Received: from mail.scgiservices.com ([70.102.159.64])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ld8Jr-0000sj-Cp
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2009 19:24:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id B39F834044
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2009 11:24:20 -0800 (PST)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail.scgiservices.com [127.0.0.1]) (amavisd-new,
	port 10026) with ESMTP id a-BbfMF1eCPS
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2009 11:24:20 -0800 (PST)
Received: from sterlingcgi.com (unknown [70.102.159.65])
	by mail.scgiservices.com (Postfix) with ESMTP id 1D49D3403F
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2009 11:24:20 -0800 (PST)
Message-ID: <20090227112419.10563b4113h5iadc@mail.scgroup.org>
Date: Fri, 27 Feb 2009 11:24:19 -0800
From: brocka@sterlingcgi.com
References: <000301c998e8$2ae364f0$80aa2ed0$@com>
In-Reply-To: <000301c998e8$2ae364f0$80aa2ed0$@com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [uml-devel] page_mapcount(page) went negative
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
To: user-mode-linux-devel@lists.sourceforge.net

This is definitely repeatable. Unfortunately I don't have a lot of  
visibility into what is actually happening in the instance (or  
triggering the crash), but it does appear to be memory related.

The instance originally had 64M of memory (almost 628M of swap in two  
files) and crashed with 5 minutes of boot (starting last night for  
some reason, after running for almost 2 months without issue). We  
increased the time between crashes to every 30 minutes by increasing  
the physical memory to 96M. It now has 128M of physical memory and  
crashes approximately 90 minutes after boot. I'm waiting for the next  
crash.

The configuration for the guest kernel can be found here:

http://www.coherenthosting.com/prj/uml/miscellaneous/config-uml_2.6.28.7-00-32bit

The cpuinfo of the host machine can be found here:

http://www.coherenthosting.com/prj/uml/miscellaneous/2.6.28.7-host-cpuinfo

For reference I am placing a copy of the crash output from when this  
instance was still running the kernel version 2.6.20.6 here:

http://www.coherenthosting.com/prj/uml/miscellaneous/2.6.20.6-crash-log.txt

Any help is appreciated!

Tony


Quoting "Anthony Brock" <brocka@sterlingcgi.com>:
> One of my customer UML instances started crashing last night. It was
> originally running under a very old version of the kernel, so I upgraded to
> 2.6.28.7. However, we are still encountering the crashes. I've verified that
> the customer has not exhausted their disk space, but the error seems to
> indicate something related to memory:
>
> Eeek! page_mapcount(page) went negative! (-1)
>   page pfn = 1261
>   page->flags = 0
>   page->count = 2
>   page->mapping = 00000000
>   vma->vm_ops = 0x0
> Kernel panic - not syncing: Kernel mode signal 4
>
> EIP: 0073:[<40388868>] CPU: 0 Not tainted ESP: 007b:bfa7f060 EFLAGS:
> 00000246
>     Not tainted
> EAX: ffffffda EBX: 00000007 ECX: 080a3190 EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: bfa7fff8 DS: 007b ES: 007b
> 081fdbb4:  [<0806a327>] show_regs+0xc4/0xc9
> 081fdbe0:  [<08059a16>] panic_exit+0x25/0x3b
> 081fdbf4:  [<0808411b>] notifier_call_chain+0x27/0x4c
> 081fdc1c:  [<0808416e>] atomic_notifier_call_chain+0x15/0x17
> 081fdc2c:  [<081984b1>] panic+0x4c/0xd2
> 081fdc48:  [<080593cf>] relay_signal+0x31/0x6c
> 081fdc68:  [<080650a2>] sig_handler_common+0x61/0x70
> 081fdce0:  [<080651ca>] sig_handler+0x31/0x3d
> 081fdcec:  [<08065363>] handle_signal+0x4f/0x7d
> 081fdd0c:  [<08066a0b>] hard_handler+0xf/0x14
> 081fdd1c:  [<ffffe420>] _etext+0xf7e64328/0x0
>
> It appears to be very repeatable at the moment as the crashes are occurring
> within a few minutes of boot. I noticed a similar bug report in the archives
> for kernel version 2.6.24. Is this a known issue? If so, is there a
> work-around? What additional information should I supply?
>
> I can supply the text from the earlier kernel version if that might help.
> Any help is appreciated!
>
> Tony

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


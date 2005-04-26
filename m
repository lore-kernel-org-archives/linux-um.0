Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQOHo-00029Y-3E for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 04:31:28 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DQOHm-00062n-JS for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 04:31:28 -0700
Message-ID: <426E2688.1050203@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<200504080322.50532.blaisorblade@yahoo.it>
	<42562EC4.7040903@fujitsu-siemens.com>
	<200504171937.05846.blaisorblade@yahoo.it>
In-Reply-To: <200504171937.05846.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 26 Apr 2005 13:31:20 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> Other issues follow, which refer to copied code going out-of-date wrt. my 
> local tree (which I have snapshotted some time ago, after I started writing 
> this mail). This is the problem with copying code - and you're starting 
> experiencing it!
> 
> * important changes for TLS support, clone(), and so on.
I'm going to implement TLS support in UML/s390. I could do this in
arch/um/sys-s390/syscalls.c/sys_clone() without any need to change generic
UML code.
But I guess, for i386 there will be a need for arch-specific code in copy_thread(),
maybe something like arch_copy_thread().
If so, s390 TLS support should be inserted using in the same manner.
Do you already have some code for this, that I could base on?

		Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

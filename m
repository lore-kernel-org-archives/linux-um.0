Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJGAn-00012f-8a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:26:45 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DJGAm-0006AG-HN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:26:45 -0700
Message-ID: <425437F0.70804@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
	<42543129.4040300@fujitsu-siemens.com>
	<200504062117.45623.blaisorblade@yahoo.it>
In-Reply-To: <200504062117.45623.blaisorblade@yahoo.it>
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
Date: Wed, 06 Apr 2005 21:26:40 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Wednesday 06 April 2005 20:57, Bodo Stroesser wrote:
> 
>>Jeff Dike wrote:
>>
>>>On Wed, Apr 06, 2005 at 03:27:50PM +0200, Bodo Stroesser wrote:
>>>
>>>>Here are the patches (tarball attached), that I've applied to
>>>>UML 2.6.11 + incrementals, before adding s390-files.
>>>>These patches are tested a bit on x86, but not on x86_64.
>>>
>>>I merged these, except for the restartnointr one because I don't have
>>>ERESTARTNOINTR in my /usr/include, inside a #ifdef KERNEL or not.
>>>
>>>    Jeff
>>
>>That's bad. Do you have any suggestions how to solve this?
> 
> Add it to the compilation-generated header files (the output of mk_constants, 
> mk_thread and such), so we catch it from the definition given by ourselves 
> and expose to the whole of UML.
Yeah, tx, that would be possible.
But the reason for using /usr/include/linux/errno.h was to have the host's
definition, not the one from guest.
Currently they are the same for 2.4 and 2.6, but worst case that might change in
future versions. Only debugger could note this, as ERESTART_XXXX is unvisible
to user programs.
So, when implementing your idea, maybe I should add a further test, that
our ERESTARTNOINTR *does* trigger a syscall restart on the host.

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

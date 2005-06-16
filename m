Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DizHe-0004aQ-V3	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:40:10 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DizHd-00009z-BY	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:40:10 -0700
Message-ID: <42B1C787.6010402@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<200506162009.35357.blaisorblade@yahoo.it>
	<42B1C572.5070705@fujitsu-siemens.com>
	<200506162041.27013.blaisorblade@yahoo.it>
In-Reply-To: <200506162041.27013.blaisorblade@yahoo.it>
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
Date: Thu, 16 Jun 2005 20:40:07 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Thursday 16 June 2005 20:31, Bodo Stroesser wrote:
> 
>>Blaisorblade wrote:
>>
>>>arch_switch already exists (wasn't used for SKAS). About improving it and
>>>making it more "general-purpose" (I've written this for the TLS code
>>>needs), could you have a look to the attached patches? do_fork-* is
>>>another thing (a cleanup discussed some time ago with Jeff) but may be
>>>needed to apply the second.
>>
>>Wouldn't it be better to have separate arch_switch_tt and arch_switch_skas?
>>I think, arch_switch has to do different things for tt and skas (and maybe
>>even for skas0 and skas3)
> 
> Let's not go creating too many layers. switch_to_* calls arch_switch, then it 
> can use CHOOSE_MODE if it needs (see the TLS patch I'm working on, it's in 
> the -devel tarball here:
Then swtich_to_tt should call arch_switch_tt and switch_to_skas should call
arch_switch_skas. This avoids a CHOOSE_MODE and a function call.
And also it makes tt a bit more removable, if Jeff decides to.

	Bodo
> 
> http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/
> 
> (pick the latest)
> ).


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

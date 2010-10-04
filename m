Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cdfrey@foursquare.net>) id 1P2qgK-000448-I1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2010 19:26:40 +0000
Received: from nic.netdirect.ca ([216.16.235.2] helo=rubicon.netdirect.ca)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P2qgJ-0007by-Eq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2010 19:26:40 +0000
Date: Mon, 4 Oct 2010 15:26:31 -0400
From: Chris Frey <cdfrey@foursquare.net>
Message-ID: <20101004192631.GA30065@foursquare.net>
References: <AANLkTimmwViVHMy-7S3N9Ps1Vj_n_TfJLvwzoupsFPnp@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimmwViVHMy-7S3N9Ps1Vj_n_TfJLvwzoupsFPnp@mail.gmail.com>
Subject: Re: [uml-devel] um: rcu_sched_state detected stall on CPU 0
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 02, 2010 at 12:03:04AM +0200, richard -rw- weinberger wrote:
> Hi,
> 
> I'm seeing often messages like this one on my UML:
> ...
> INFO: rcu_sched_state detected stall on CPU 0 (t=7348 jiffies)
> ...
> 
> The system often seems to be frozen.
> When I press a button it wakes up immediately and continues to run.
> 
> Any ideas?
> Config is attached.

I saw this too, but I thought it was because I was overloading my machine.
I only seem to see it when the guest is starved for CPU due to IO on the
host.

- Chris


------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


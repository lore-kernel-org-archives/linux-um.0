Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FmBjb-0002rK-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 08:38:47 -0700
Received: from arachne.taloncorporation.com ([208.176.116.10])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FmBjZ-0000af-4k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 08:38:47 -0700
Date: Fri, 2 Jun 2006 11:38:37 -0400 (EDT)
From: Steven James <pyro@linuxlabs.com>
In-Reply-To: <20060602151335.GA4708@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.63.0606021136440.26283@localhost.localdomain>
References: <20060526032424.GA8283@ccure.user-mode-linux.org>
	<200605261236.26814.ak@suse.de>
	<20060526141345.GA4152@ccure.user-mode-linux.org>
	<200606012107.34676.blaisorblade@yahoo.it>
	<20060602151335.GA4708@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [discuss] [RFC] [PATCH] Double syscall exit traces
	on x86_64
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
To: Jeff Dike <jdike@addtoit.com>
Cc: discuss@x86-64.org, user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>

On Fri, 2 Jun 2006, Jeff Dike wrote:

> On Thu, Jun 01, 2006 at 09:07:33PM +0200, Blaisorblade wrote:
>> Sorry for the question, but has this been sent to -stable (since it's a
>> -stable regression, it should be)? To 2.6.17 -git?
>
> It's in current git.
>
> I'm having a hard time telling when the bug was introduced.  The git web
> interface seems to be telling me that the double notification was around
> since last year, which I don't believe, since I've run much more
> recent x86_64 kernels.  If the bug existed before 2.6.16, then it's
> fine -stable fodder.

I know that the bug is NOT present in 2.6.15.7.

>
>> And have you tested it (somebody should have, but it's not sure)?
>
> Yes, it's been continuously and happily running UML since Andi sent me
> his patch.
>
> 				Jeff
>


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

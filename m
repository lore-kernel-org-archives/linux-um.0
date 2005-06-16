Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Diyhg-0002PX-4z	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:03:00 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Diyhf-0005vI-LQ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 11:03:00 -0700
Message-ID: <42B1BED0.4030709@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<42B1B8B9.7070006@fujitsu-siemens.com>
	<20050616174735.GB7532@ccure.user-mode-linux.org>
	<42B1BD11.7050806@fujitsu-siemens.com>
In-Reply-To: <42B1BD11.7050806@fujitsu-siemens.com>
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
Date: Thu, 16 Jun 2005 20:02:56 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Bodo Stroesser wrote:
> Jeff Dike wrote:
> 
>> I'll fix things accordingly.
>>
> Could you please make handling in switch_to subarch-specific,
> e.g. in arch_switch_to?
> s390 might have some special handling for fpregs and debug-regs
> in a single syscall.
> 
>     Bodo
Oh, I guess I forgot to add ptrace to the list of changes. If a
debugger in UML wants to read childs fpregs via ptrace while UML
runs SKAS0 and ptraced child doesn't share it's mm, fpregs need
to be read before they can be given to the debugger.

	Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

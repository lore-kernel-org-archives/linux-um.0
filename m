Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWvvP-0004fC-GF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 04:07:07 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWvvN-0001eb-Hp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 04:07:07 -0800
Message-ID: <41A4795E.5090004@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Problems in make
References: <41A23722.7060002@fujitsu-siemens.com>
	<200411222301.47216.blaisorblade_spam@yahoo.it>
	<41A354F1.7070907@fujitsu-siemens.com>
	<200411231904.51431.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411231904.51431.blaisorblade_spam@yahoo.it>
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
Date: Wed, 24 Nov 2004 13:06:54 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Tuesday 23 November 2004 16:19, Bodo Stroesser wrote:
> 
>>Blaisorblade wrote:
>>
>>>On Monday 22 November 2004 19:59, Bodo Stroesser wrote:
>>>
>>>>If arch/um/kernel/tt/include/mode-tt.h is changed, make doesn't compile
>>>>tracer.c, the resulting kernel is inconsistent and crashes!
>>>
>>>This is true for any dependency of files listed in USER_OBJS, which is
>>>broken. This problem is known and is pending fixing (and fixing requires
>>>designing a clean and Kbuild-supported replacement of USER_OBJS). I fixed
>>>it some time ago, around 2.6.1, but the fix was not integrated because it
>>>was too invasive.
>>>
>>>So: use always make clean ARCH=um before rebuilding (this even holds for
>>>dependencies on CONFIG_*).
>>>
>>>If that slows you down too much, then install ccache (I'm not explaining
>>>it here because there is nothing special on ccache with kernel
>>>compilation and because there is plenty of tutorials onto the net).
> 
> 
>>>Bye
> 
> 
>>As a quick solution to guarantee a correct result of the build, would it be
>>possible to remove all USER_OBJS, when starting to build?
> 
> This is not a so bad idea, however if I interrupt a build with Ctrl-C and 
> restart it without changes, it shouldn't clean all USER_OBJS.
Is this really necessary? What's the time for a complete build and what's the
time for building the USER_OBJS? Would not removing the USER_OBJS enable make
to build consistent kernels in all cases without being as inefficient as
make clean ARCH=um? Getting consistent kernels from make IMHO has the highest
priority.
Even when using ccache, after make clean the build takes some time.
> 
> It is not also a one-liner (can be dumbly implemented easily, but some 
> changes).
> 
> What about adding a target like "rebuildclean" (a better name is welcome)?
> 
> However, until I don't have the time to work on this, use the solution I 
> suggested above.
> 
> 
>>Or, if this isn't 
>>enough, even remove all objects in the arch/um subtree?
> 
> 
> We don't need to be this aggressive.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbgDY-0006WE-Sq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 06:21:28 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CbgDX-0006kY-RL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 06:21:28 -0800
Message-ID: <41B5BC5F.20001@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Patchset to implement PTRACE_SYSEMU_SINGLESTEP
References: <419517A4.7020700@fujitsu-siemens.com>
	<200412062133.05798.blaisorblade_spam@yahoo.it>
In-Reply-To: <200412062133.05798.blaisorblade_spam@yahoo.it>
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
Date: Tue, 07 Dec 2004 15:21:19 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Friday 12 November 2004 21:05, Bodo Stroesser wrote:
> 
>>Attached are several patches. Four of them (patch-2.6.*-skas-v7-*)
>>implement PTRACE_SYSEMU_SINGLESTEP in the host. They are based on
>>linux-2.6.7-vanilla + host-skas3-2.6.7-v7.patch (resp. the 2.6.9 versions).
>>The "-reorganize" patches are a rework of the current patch without
>>changing the functionality. The "add-SYSEMU_SINGLESTEP" then implement the
>>new features. Please note: the differences between 2.6.7 and 2.6.9 are
>>dependent on the different handling of syscall singlestepping in the two
>>versions.
> 
> 
>>To have UML using the new feature, there are two further patches named
>>patch-SYSEMU_SINGLESTEP-*. They are based on linux-2.6.9-vanilla +
>>all bb2-patches + patch-sysemu-tt + patch-fix-uml-hang-on-2.6.9-host.
>>To have all the patches complete, the latter two are attached also.
> 
> 
>>I tested on host 2.6.7 and host 2.6.9 with SKAS and TT mode. Currently I
>>don't know any problem with it.
> 
> I have a problem... in recent host kernels, isn't SINGLESTEP also trapping for 
> syscall instructions?
Yes. IIRC, this feature was included with i386 2.6.9. I'm sure 2.6.7 doesn't
have it, 2.6.9 has.
The difference between the host versions are the reason for the different
reorganize- and add- patches for 2.6.7 and 2.6.9.
But, please, tell me, what problem do you see? SYSEMU_SINGLESTEP is a new
function, that does SYSCALL_TRACE on syscalls and SINGLESTEP on all other
instructions. The function is added without changing the previous functions.
If available, the UML-kernel my use the new function, but users on UML
shouldn't see any changed behavior.
By the way: they also don't see the differences between host 2.6.7 and 2.6.9
regarding syscall-singlestepping.

> 
> Also, you say that SINGLESTEP_SYSEMU does automatic syscall overwriting with 
> -1 or emulates that - I suspect it being in the reorganize patches, but you 
> don't mention it in the changelogs here, only about the UML patches.
No. The overwrite is in the "add-" patches. The "reorganize-" patches are
intended to *only* reorganize SKAS3-V7 without changing any little bit of
its behavior. Everything else I would call an error.
But it would be easy to split the "add-" patches into an "overwrite-" and
an remaining "add-" patch.
I only wanted to make clear, that UML must not rely on overwriting done by
the host, unless it can detect the host to have a skas-sysemu-patch with
overwriting enabled. My idea was to take availability of SYSEMU_SINGLESTEP
as flag, that the host *will* do overwriting.

> 
> So, I'd personally accept only the -reorganize ones and hold on the rest - 
> which is probably achieved with mainline SINGLESTEP fixes in 2.6.9 (or which 
> could be discussed).
> 
> Sorry for being so late (I'd say "Call me a lamer" :-) ) in discussing this, 
> but I hadn't the time to study patches and realize this.
> 
>>Bodo
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

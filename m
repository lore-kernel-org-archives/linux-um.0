Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbPU8-0006hd-Fi for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 12:29:28 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CbPU7-0000jO-H9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 12:29:28 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Patchset to implement PTRACE_SYSEMU_SINGLESTEP
References: <419517A4.7020700@fujitsu-siemens.com>
In-Reply-To: <419517A4.7020700@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412062133.05798.blaisorblade_spam@yahoo.it>
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
Date: Mon, 6 Dec 2004 21:33:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Friday 12 November 2004 21:05, Bodo Stroesser wrote:
> Attached are several patches. Four of them (patch-2.6.*-skas-v7-*)
> implement PTRACE_SYSEMU_SINGLESTEP in the host. They are based on
> linux-2.6.7-vanilla + host-skas3-2.6.7-v7.patch (resp. the 2.6.9 versions).
> The "-reorganize" patches are a rework of the current patch without
> changing the functionality. The "add-SYSEMU_SINGLESTEP" then implement the
> new features. Please note: the differences between 2.6.7 and 2.6.9 are
> dependent on the different handling of syscall singlestepping in the two
> versions.

> To have UML using the new feature, there are two further patches named
> patch-SYSEMU_SINGLESTEP-*. They are based on linux-2.6.9-vanilla +
> all bb2-patches + patch-sysemu-tt + patch-fix-uml-hang-on-2.6.9-host.
> To have all the patches complete, the latter two are attached also.

> I tested on host 2.6.7 and host 2.6.9 with SKAS and TT mode. Currently I
> don't know any problem with it.
I have a problem... in recent host kernels, isn't SINGLESTEP also trapping for 
syscall instructions?

Also, you say that SINGLESTEP_SYSEMU does automatic syscall overwriting with 
-1 or emulates that - I suspect it being in the reorganize patches, but you 
don't mention it in the changelogs here, only about the UML patches.

So, I'd personally accept only the -reorganize ones and hold on the rest - 
which is probably achieved with mainline SINGLESTEP fixes in 2.6.9 (or which 
could be discussed).

Sorry for being so late (I'd say "Call me a lamer" :-) ) in discussing this, 
but I hadn't the time to study patches and realize this.
> Bodo

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKhCG-0001f8-5k for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 10:57:56 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CKhCE-0004OK-Oq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 10:57:56 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Bad handling of invalif systemcalls
References: <4177D503.2030409@fujitsu-siemens.com>
In-Reply-To: <4177D503.2030409@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410211932.11392.blaisorblade_spam@yahoo.it>
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
Date: Thu, 21 Oct 2004 19:32:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Thursday 21 October 2004 17:25, Bodo Stroesser wrote:
> If a process in UML does a systemcall with the systemcall number
> being less than 0, in TT-mode and SKAS-mode using SYSEMU, the
> process is killed by an SIGTRAP instead of simply returning -ENOSYS.
> In SKAS-mode without SYSEMU, UML even crashes, no matter if SYSEMU
> is unsupported by the host or switched off in UML:

>      Kernel panic - not syncing: handle_trap - failed to wait at end of
> syscall, errno = 4, status = 2943

> The reason is, that UML can't distinguish between a debugger trap
> and an systemcall interception. Currently, it checks the systemcall
> number. If it is less than 0, it assumes the event to be a debugger
> trap. It would be better to assume a debugger trap only, if the
> syscall number is -1 (which it is guaranteed to be in case of a
> debugger event), but even then UML wouldn't be safe. Syscalls with
> syscall number -1 still would be a problem!

> AFAICS, the only solution for this is using the PTRACE_O_TRACESYSGOOD
> option. This option seems to be specific for linux, but the problem
> maybe is specific for linux, too.

I have been thinking to using SYSGOOD, but without finding a good reason for 
that... so thanks for this.

The first remark (the only I have for now) is that you should replace "SIGTRAP 
+ 0x80" with "SIGTRAP | 0x80". It should not make a difference in this 
particular case, but it's a style issue, which exists because the second way 
is more robust for setting bits: think about (SIGTRAP & 0x80) == 0x80 and 
using the + 0x80: it clears the bit it should set and set another one.

Remark no. 2: could you, please, in next patches, try to add -p to diff flags 
to improve readability? That makes clear which function is being changed, so 
the patch becomes more readable.
> So, here attached are three patches. The first adds a check for
> availability and function of
>      ptrace(PTRACE_SETOPTIONS,,,PTRACE_O_TRACESYSGOOD) to the normal
> ptrace checks.
>
> The second implements the usage of the option in SKAS-mode.

> The third does the same for TT-mode.

> For the third patch I'm quite anxious, that there could go something
> wrong when using the debugger. I don't understand much about this.
> Maybe someone else could look into this?
I'll give a look when I have the needed time. However, could you explain what 
makes you worry in detail?
> Regards
> Bodo

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

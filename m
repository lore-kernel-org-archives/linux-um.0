Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXj5O-0003ep-Ta	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 10:08:58 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXj5N-0004r9-3L	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 10:08:58 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200501282010.50020.blaisorblade@yahoo.it>
	<3524bf1f05051607085609e111@mail.gmail.com>
In-Reply-To: <3524bf1f05051607085609e111@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505161908.08373.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 19:08:06 +0200
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 16 May 2005 16:08, Young Koh wrote:
> Hi,
>
> Could you explain what happens in SKAS mode, then? How a UML kenel in
> SKAS mode handles the UML system calls differently from one in TT
> mode? i tried to understand from the code, but i had hard time to
> understand.
The usage of PTRACE_SYSCALL is not very different in SKAS mode, the different 
thing is about the handling of child address spaces... however I'm going to 
publish some info on my site.

About the below, tracing in SKAS mode is simpler, because you don't switch 
tracing on and off. In TT mode, the tracing thread (which does not run kernel 
code, in fact in it current is invalid) ptraces the host threads, which run 
both the UML userspace code, and the UML kernelspace code (which runs in 
signal handlers).

In SKAS mode, instead, the UML scheduler switches back and forth between 
various "processes" (inside UML) which are all running inside userspace, and 
ptrace the various host threads (actually collapsed into one userspace 
thread, thanks to SKAS mode) which run only the real userspace code. So the 
ptraced context always executes userspace code and we never turn ptracing 
off.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

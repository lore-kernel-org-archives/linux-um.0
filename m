Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXpnE-0007dP-4U	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 17:18:40 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXpmj-0007yl-8u	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 17:18:39 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200505162324.37749.blaisorblade@yahoo.it>
	<3524bf1f0505161709476c4940@mail.gmail.com>
In-Reply-To: <3524bf1f0505161709476c4940@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505170217.23138.blaisorblade@yahoo.it>
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
Date: Tue, 17 May 2005 02:17:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Tuesday 17 May 2005 02:09, Young Koh wrote:
> Ok, now i'm getting close. Thanks a lot!!!
> but i have two more :)
>
> 1) in SKAS mode, the tracer (UML kernel) will execute a system call
> for the tracee (the user process). But what if the system call blocks?
> then, the tracer, the UML kernel, will be blocked, too, right? it
> means the whole UML system will be blocked?
Good question. However the tracee is one of the threads running inside UML, 
i.e. switch_to_skas switches between the different tracees. However, that's 
done only on timer interrupts, and possibly those interrupts are blocked by 
the syscall execution.

Indeed, I remember that when the UBD I/O is run by the UML kernel and not by a 
separate thread (this has been removed) the whole system becomes *really* 
slow, so probably the answer to your question is "Yes, but UML tries to avoid 
this".

> 2) in TT mode, what if the user process (tracee) installs its own
> signal handler for SIGUSR2?
The syscall is intercepted so it can't install signal handlers; the one it 
installs are handled inside the UML kernel.
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

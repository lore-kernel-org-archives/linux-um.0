Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRaoj-0003eJ-KX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:34:09 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRaoi-0005wL-KY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:34:09 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
References: <418AEC78.2010502@rimuhosting.com>
	<200411052042.22095.blaisorblade_spam@yahoo.it>
	<419028BF.3090308@rimuhosting.com>
In-Reply-To: <419028BF.3090308@rimuhosting.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411091935.03983.blaisorblade_spam@yahoo.it>
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
Date: Tue, 9 Nov 2004 19:35:03 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Peter <peter.repliesignored@rimuhosting.com>

On Tuesday 09 November 2004 03:17, Peter wrote:
> Hi.  Host is 2.6.9-skas3-v7.  Guest is linux.2.4.27-bs1.  I restarted a
> UML guest 24 times ok.  After that I got these two processes that won't
> die.

> xxxxd  30282  0.0  0.1 132344 3988 ?       D    01:21   0:00
> /home/umlusers/xxxxd.net/linux umid=leventd.net con=null con0=fd:
> xxxxd  30284  0.0  0.1 132344 3988 ?       T    01:21   0:00  \_
> /home/umlusers/xxxxd.net/linux umid=xxxxd.net con=null con0

I.e. 24 restarts and only two dead processes, right? It means that the fix 
"normally" works. But those two processes are hanged for another host kernel 
bug, and this time a very bad one!

The first process is in "D" state.

If it stays that way, it will never die - and it also means you have had a 
kernel Oops or something like that - search /var/log/messages on the host and 
you'll find some text about that, which you should post (search "Oops" and 
you should find it). Btw, this is a host kernel bug, so you should probably 
also report it to LKML (post it here also, to get some more answers).

Also, could you post "ps -ef" output about this processes, if they are still 
alive? If not, the Oops text should be enough.

> I've sent them kill signals from 1 thru 64 (including, of course,
> SIGCONT) and neither process is interested in quitting.

> I can't strace to the second process (attach: ptrace(PTRACE_ATTACH,
> ...): Operation not permitted)

> There is nothing happening on the strace of the first process.

I guess that "strace" should even hang on the first process, since it has 
freezed this bad way.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

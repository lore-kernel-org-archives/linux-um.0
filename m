Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRLZo-0005Zo-R0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Nov 2004 18:17:44 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CRLZo-0003nt-6f
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Nov 2004 18:17:44 -0800
Message-ID: <419028BF.3090308@rimuhosting.com>
From: Peter <peter.repliesignored@rimuhosting.com>
MIME-Version: 1.0
References: <418AEC78.2010502@rimuhosting.com>
	<200411052042.22095.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411052042.22095.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
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
Date: Tue, 09 Nov 2004 15:17:35 +1300
To: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade_spam@yahoo.it>

Hi.  Host is 2.6.9-skas3-v7.  Guest is linux.2.4.27-bs1.  I restarted a 
UML guest 24 times ok.  After that I got these two processes that won't 
die.

xxxxd  30282  0.0  0.1 132344 3988 ?       D    01:21   0:00 
/home/umlusers/xxxxd.net/linux umid=leventd.net con=null con0=fd:
xxxxd  30284  0.0  0.1 132344 3988 ?       T    01:21   0:00  \_ 
/home/umlusers/xxxxd.net/linux umid=xxxxd.net con=null con0

I've sent them kill signals from 1 thru 64 (including, of course, 
SIGCONT) and neither process is interested in quitting.

I can't strace to the second process (attach: ptrace(PTRACE_ATTACH, 
...): Operation not permitted)

There is nothing happening on the strace of the first process.

Is there any more info I can provide that would be of use?

In the meantime, I'm taking this host kernel back to 2.6.8.1 to see if 
that is going to be any better.  I have another server that I can 'play' 
with 2.6.9 later on if we can make some progress on this problem.

Cheers, Peter


> From: Blaisorblade <blaisorblade_spam <at> yahoo.it>
> Subject: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
> Newsgroups: gmane.linux.kernel, gmane.linux.uml.devel, gmane.linux.uml.user
> Date: Thu, 04 Nov 2004 19:32:31 +0100
> 
> You can find all on http://www.user-mode-linux.org/~blaisorblade/.
> 
> The SKAS3/2.6-v7 was already released, but I probably forgot to announce it. 
> So I'm announcing it now.
> 
> Changes in SKAS:
> * echo 0 > /proc/sysemu on the guests works fine, finally!
> 
> Changes in both 2.6.9 and 2.4.27:
> they run fine on 2.6.9 host kernels, without hanging at the exit.
> 
> Changes in 2.6.9 only:
> included a large chunk of JDike tree (excluding all x86_64 related patches), 
> and all the latest security patches from Bodo Stroesser; also it includes the 
> -V7 skas patch in it.
> 
> Actually, however, to do this I had to include big, invasive patches from Jeff 
> Dike's tree. I've done it because it's needed and because Bodo Stroesser 
> worked with the incrementals very fine.
> 
> Changes in 2.4.27 only:
> 
> It's based on a fork from the official 2.4.24-1; the patches I've included 
> come almost totally from there, but I dropped all the hostfs rewrite. I also 
> included some incrementals, the one I thought safe.
> 
> Also, you can find on the page the instructions to avoid the "hwclock hang" in 
> TT mode. I found the faulty patch, but it needs a more worse bug, which 
> affects everyone running in TT mode on a 2.6 host, so it's included. You can 
> revert the patch if you want, and if you have to run it on a 2.4 host. I sent 
> a message about this about a week ago, but I got no answer.
> 
> Distribution:
> * the patch are also in split-out form, both web-browsable and tarballed.
> * md5sums are available (to test with "md5sum -c *.md5").
> 
> Any testing and report is welcome.
> 
> Bye
> -- 
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRo59-0005AF-Rb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 00:43:59 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRo59-00068n-2T for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 00:43:59 -0800
Message-ID: <35144.80.203.1.124.1100076236.squirrel@80.203.1.124>
In-Reply-To: <200411091935.03983.blaisorblade_spam@yahoo.it>
References: <418AEC78.2010502@rimuhosting.com>
	<200411052042.22095.blaisorblade_spam@yahoo.it>
	<419028BF.3090308@rimuhosting.com>
	<200411091935.03983.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Date: Wed, 10 Nov 2004 09:43:56 +0100 (CET)
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Peter <peter.repliesignored@rimuhosting.com>

> On Tuesday 09 November 2004 03:17, Peter wrote:
>> Hi.  Host is 2.6.9-skas3-v7.  Guest is linux.2.4.27-bs1.  I restarted a
>> UML guest 24 times ok.  After that I got these two processes that won't
>> die.
>
>> xxxxd  30282  0.0  0.1 132344 3988 ?       D    01:21   0:00
>> /home/umlusers/xxxxd.net/linux umid=leventd.net con=null con0=fd:
>> xxxxd  30284  0.0  0.1 132344 3988 ?       T    01:21   0:00  \_
>> /home/umlusers/xxxxd.net/linux umid=xxxxd.net con=null con0
>
> I.e. 24 restarts and only two dead processes, right? It means that the fix
> "normally" works. But those two processes are hanged for another host
> kernel
> bug, and this time a very bad one!
>
> The first process is in "D" state.
>
> If it stays that way, it will never die - and it also means you have had a
> kernel Oops or something like that - search /var/log/messages on the host
> and
> you'll find some text about that, which you should post (search "Oops" and
> you should find it). Btw, this is a host kernel bug, so you should
> probably
> also report it to LKML (post it here also, to get some more answers).

Network filesystems like nfs and samba is often a source for processes
getting stuck in "D" state and with time affecting other processes due to
deadlocks until the stuck processes times out where it is stuck (which
with nfs can be MANY hours by experience when strange things have happened
with the nfs-server)


Stian


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

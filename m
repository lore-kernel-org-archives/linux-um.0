Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GToou-0002in-4G for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 17:04:36 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GToos-0005x3-Fd
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 17:04:36 -0700
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
	by gwu.lbox.cz (Sendmail) with ESMTP id k9104TqY015044
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 02:04:29 +0200
Received: from nbnik.linuxbox.cz (nbnik.linuxbox.cz [10.76.66.65])
	(authenticated bits=0)
	by linuxbox.linuxbox.cz (Sendmail) with ESMTP id k9104MuO015309
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 02:04:23 +0200
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
In-Reply-To: <20060930235752.GA16968@ccure.user-mode-linux.org>
References: <451E9BAB.5030009@linuxbox.cz>
	<20060930214902.GA16457@ccure.user-mode-linux.org>
	<451EEB99.6030406@linuxbox.cz>
	<20060930235752.GA16968@ccure.user-mode-linux.org>
Date: Sun, 01 Oct 2006 03:04:22 +0300
Message-Id: <1159661062.2940.17.camel@nik-nb>
Mime-Version: 1.0
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64	guest, 
	problems with noprocmm
Reply-To: nikola.ciprich@linuxbox.cz
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net


> Where in the shutdown process is this?  There have been some previous
> reports of hangs during swapoff which I have been unable to reproduce.
> I spent part of a day last week pushing UMLs deeply into swap and
> shutting them down, always successfully.
it always hangs executing /sbin/halt
> 
> The SIGVTALRM is normal - that's just the timer.  That strace you sent
> looks like the idle loop, so as far as the kernel is concerned,
> everything is fine.
it's consuming all available host CPU time, it's certainly cycling as
fast as possible
> 
> > and regarding /proc/mm, shouldn't this mm64 file be used? or what's it 
> > used for?
> 
> /proc/mm64?  What would it do that /proc/mm doesn't?
well, I must admit I don't know what's difference between two at all, I
was just guessing. Is there some documentation about it? I wasn't able
to find nothing which would explain it...
> 
> 				Jeff
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

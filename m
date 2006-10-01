Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTosY-00032t-O0 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 17:08:22 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTosV-0006dC-1l
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 17:08:22 -0700
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
	by gwu.lbox.cz (Sendmail) with ESMTP id k9108DN0015331
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 02:08:14 +0200
Received: from nbnik.linuxbox.cz (nbnik.linuxbox.cz [10.76.66.65])
	(authenticated bits=0)
	by linuxbox.linuxbox.cz (Sendmail) with ESMTP id k9108CdX015484
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 02:08:12 +0200
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
In-Reply-To: <20060930235752.GA16968@ccure.user-mode-linux.org>
References: <451E9BAB.5030009@linuxbox.cz>
	<20060930214902.GA16457@ccure.user-mode-linux.org>
	<451EEB99.6030406@linuxbox.cz>
	<20060930235752.GA16968@ccure.user-mode-linux.org>
Date: Sun, 01 Oct 2006 03:08:11 +0300
Message-Id: <1159661291.2940.21.camel@nik-nb>
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

hmm, I've also noticed another strange thing (maybe bug?)
when I run this UML using noprocmm, arch is incorrectly reported as
i686, while if I run it using skas0, it's (correctly) reported as
x86_64...
n.
PS: You don't need to CC me, I'm reading this list


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

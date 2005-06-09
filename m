Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgTxq-0001f3-N2	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 13:49:22 -0700
Received: from smtp2.wanadoo.fr ([193.252.22.29])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgTxp-0001OY-6q	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 13:49:22 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0204.wanadoo.fr (SMTP Server) with ESMTP id 4F6F31C00233
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  9 Jun 2005 22:48:26 +0200 (CEST)
Received: from doggy.fute.lan (AMontsouris-151-1-13-139.w82-123.abo.wanadoo.fr
	[82.123.138.139])
	by mwinf0204.wanadoo.fr (SMTP Server) with ESMTP id 1C5101C0022D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  9 Jun 2005 22:48:26 +0200 (CEST)
Received: from snide by doggy.fute.lan with local (Exim 3.36 #1 (Debian))
	id 1DgTwv-0000aH-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 09 Jun 2005 22:48:25 +0200
From: Steve Schnepp <snide@free.fr>
Subject: Re: [uml-devel] CowLoop
Message-ID: <20050609204825.GA2217@fute.lan>
References: <007a01c5426c$ee241350$2000000a@schlepptopp>
	<20050416134809.GA3711@ccure.user-mode-linux.org>
	<000801c5429f$b58babb0$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000801c5429f$b58babb0$2000000a@schlepptopp>
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
Date: Thu, 9 Jun 2005 22:48:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 16, 2005 at 06:16:55PM +0200, roland wrote:
> Did anyone try it yet ?

As usual with open source, many people say they'll do many things. So one
time I said that i'll eventually finish a little project ULDD, which is
an userspace loop device (such as lufs [1], but for block devices).

But then, i didn't have much interest in UML anymore [ I changed job :) ], 
and I crossed FUSD [2] which seems much more advanced at the time...

At the time I put some ugly piece of code online [3]. It was my first
attempt to create a kernel block driver, but unfortunatly, I didn't have
the time to investigate to port the driver to 2.6 :-(

[1] http://lufs.sourceforge.net/lufs/
[2] http://www.circlemud.org/~jelson/software/fusd/
[3] http://snide.free.fr/uldd/

	Steve

-- 
GPG public key available from http://snide.free.fr/gpg/snide.free.fr.asc
   Or by email to "snide at free.fr" with "send key pub" as subject
   Fingerprint: 19D7 12ED 5A37 4F29 8FDA  19B0 6DFD 3A54 A753 EA6F 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

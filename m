Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRny1-0003O4-WD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 00:36:37 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CRny1-0005kv-4k for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 00:36:37 -0800
Message-ID: <34658.80.203.1.124.1100075791.squirrel@80.203.1.124>
In-Reply-To: <200411092012.05383.blaisorblade_spam@yahoo.it>
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
	<4190F385.1000802@fujitsu-siemens.com>
	<200411092012.05383.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
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
Date: Wed, 10 Nov 2004 09:36:31 +0100 (CET)
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Sven =?UTF-8?Q?K=EF=BF=BDhler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

> This fact (glibc caches getpid() results) was even known because already
> posted, and I guessed that this could happen only with TLS support.

That glibc caches getpid() has been a known issue before when people
wanted to benchmark uml syscall speeds inside vs outside of UML using a
simple libc-function. A clone() call can't easily invalidate caches around
in libs that are stored in statics. But it should be mentioned on
getpid()'s man/info page that the value might be cached.

Perhaps sende the glibc dudes an email with the problem, and either get
them to remove the cache or document it. Either way it will be a problem,
since people might use a version of glibc then that caches getpid.. only
work-around  is to use syscall() directly, or avoid using getpid() before
clone().


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

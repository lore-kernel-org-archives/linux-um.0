Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRw50-0007N8-Fk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 09:16:22 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CRw4z-0007ad-Lk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 09:16:22 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411092012.05383.blaisorblade_spam@yahoo.it>
	<34658.80.203.1.124.1100075791.squirrel@80.203.1.124>
In-Reply-To: <34658.80.203.1.124.1100075791.squirrel@80.203.1.124>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411101816.39361.blaisorblade_spam@yahoo.it>
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
Date: Wed, 10 Nov 2004 18:16:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: stian@nixia.no, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Sven =?utf-8?q?K=EF=BF=BDhler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

On Wednesday 10 November 2004 09:36, stian@nixia.no wrote:
> > This fact (glibc caches getpid() results) was even known because already
> > posted, and I guessed that this could happen only with TLS support.
>
> That glibc caches getpid() has been a known issue before when people
> wanted to benchmark uml syscall speeds inside vs outside of UML using a
> simple libc-function.
In fact, it has been also said against SYSEMU benchmarks. Actually, it was 
obvious it didn't apply: in fact, this only happens with TLS, which is always 
disabled inside UML.

> A clone() call can't easily invalidate caches around 
> in libs that are stored in statics. But it should be mentioned on
> getpid()'s man/info page that the value might be cached.

> Perhaps sende the glibc dudes an email with the problem, and either get
> them to remove the cache or document it. Either way it will be a problem,
> since people might use a version of glibc then that caches getpid.. only
> work-around  is to use syscall() directly, or avoid using getpid() before
> clone().
The first one is better, I'm going to use it.

Bye
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

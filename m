Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTkVz-00068x-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:19:43 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CTkVy-0008Tt-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:19:43 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<Pine.GSO.4.61.0411101005310.17015@waterleaf.sonytel.be>
	<Pine.LNX.4.61.0411102218520.3589@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0411102218520.3589@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411151817.15178.blaisorblade_spam@yahoo.it>
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
Date: Mon, 15 Nov 2004 18:17:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Geert Uytterhoeven <geert@linux-m68k.org>, stian@nixia.no, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Sven =?utf-8?q?K=EF=BF=BDhler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

On Wednesday 10 November 2004 22:19, Henrik Nordstrom wrote:
> On Wed, 10 Nov 2004, Geert Uytterhoeven wrote:
> > Why? getpid() is just an API call. No one guarantees it's actually a
> > syscall. And IMHO caching getpid() is allowed, since the returned value
> > won't change anyway.
The cache must be cleared on fork() (which is done) and on clone().

> And in case of pthreads SHOULD be different from the Linux process ID.
He was misunderstanding the thread - UML calls clone() without CLONE_THREAD, 
so that on this aspect it is fork()-like, so no thread group is created, just 
a child process. Which has a different PID. But glibc does not clean the 
thread-local-storage (or just the getpid() cached value in it) appropriately 
when using clone().
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUB67-00075Y-4b for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 13:42:47 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUB65-0002Ht-ED for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 13:42:47 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problem booting UML 2.4.26 compiled with gcc 3.3.4
References: <20041116211102.GA340@alchar.org>
In-Reply-To: <20041116211102.GA340@alchar.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411162244.29724.blaisorblade_spam@yahoo.it>
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
Date: Tue, 16 Nov 2004 22:44:29 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Kris Van Hees <aedil@alchar.org>

On Tuesday 16 November 2004 22:11, Kris Van Hees wrote:
> Has anyone else experienced trouble with running a UML kernel 2.4.26 that
> was compiled with GCC 3.3.4?  My instances ran perfectly fine (compiled)
> with GCC 2.94
2.95.4 I guess (I think GCC 2.94 does not exist, but you may be correct, so I 
just ask).
> but when I upgraded my GCC and recompiled everything, 
> suddenly they started giving me trouble, ranging from tracing thread
> crashes to kernel mode panics.
Which GCC 3.3.4 and which UML?

UML 2.4.26-3 should be safe from this, older ones may not.
Also, for instance, Gcc 3.3.2 from Mandrake 10.0 Official is not able to 
compile any UML 2.4 (no problem for UML/2.6), but like for Linux, even for 
GCC some vendor ship patched versions, and the problem will probably lie in 
the patch (since I've been using GCC 3.3.4 from Slackware to compile with 
success UML 2.4).

Please let me know your results.
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

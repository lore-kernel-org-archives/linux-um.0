Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTkW0-000692-Q4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:19:44 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CTkW0-0008U6-5F for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:19:44 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.4.27 guest bug reconfirmed Re bug report [ 745826 ]
	run cat /dev/urandom
References: <418E5CA1.90308@praguespringpeople.org>
	<419737C6.3060904@praguespringpeople.org>
In-Reply-To: <419737C6.3060904@praguespringpeople.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411151821.11779.blaisorblade_spam@yahoo.it>
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
Date: Mon, 15 Nov 2004 18:21:11 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Struan Bartlett <struan@praguespringpeople.org>

On Sunday 14 November 2004 11:47, Struan Bartlett wrote:
> I've now tested for this bug using a simplified methodology on the
> latest patched-versions of the host (2.4.27 and 2.6.8) and guest (2.4.27
> and 2.6.9).

> _New methodology_

> My Debian guest system raises two xterms at startup. On each I log in as
> root. On one, I enter:

> while true; do echo >/dev/null; done

> On the second, I enter:

> cat /dev/urandom

> The devastating symptom: within 5 seconds the guest kernel has paniced
> and exited with the message (below) "kernel BUG at sched.c:564!".
>
> _Findings_

> guest 2.6.9: patched with uml-2.6.9-bb2.patch.bz2 - I am pleased to say
> I have not so far been able to reproduce this bug on this configuration.

> guest 2.4.27: patched with uml-2.4.27-bs1.patch and
> uml-patch-2.4.24-1base.patch - no change; this bug is readily
> reproducible and so IS NOT FIXED, regardless of whether the guest is run
> on host 2.4.27 or 2.6.8

> _Conclusion_
>
> If such a simple pair of commands as this causes such devastating
> consequences, it seems the 2.4.27 kernel sched.c line 564 needs to be
> taken a look at - unless, that is, Jeff Dike's recent post about
> uml-patch-2.4.27-1 "a nasty scheduler race fixed" addresses this bug.
I may be wrong, but I think I should have picked that patch into 2.4.27-bs1.

> Jeff: where can I get your uml-patch-2.4.27-1 ?
It's at http://user-mode-linux.sourceforge.net/dl-ists.html

I'll take a look at your report - there is one patch applied on 2.6 that 
seemed unneeded on 2.4 until now - this may be reconsidered...
> Struan

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

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AUWWY-0004zO-U1
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Dec 2003 11:30:58 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AUWWY-0004XK-Du
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Dec 2003 11:30:58 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.4.23aa1
References: <1071161579.6647.83.camel@etrs-pc02.ets.enterasys.com>
In-Reply-To: <1071161579.6647.83.camel@etrs-pc02.ets.enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200312112034.47972.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 11 Dec 2003 20:34:47 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 17:52, gioved=EC 11 dicembre 2003, D. Bahi ha scritto:
> does anybody here use or know about Andrea Arcangeli's patchset
> that includes UML?
>
> i'm wondering how upto/outof date it is - and if it incorporates
> both the uml-patch and the host-skas patch set in one....
>
> http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.=
23
>aa1/
The other UML-related patches he includes could be interesting for Jeff to =

take into his tree... the names seem to mean that he fixed highmem support =

and a lot of other things... Jeff, what do you think of them?

> [ ] 51_uml-aa-14            27-Jul-2003 18:45     6k
> [ ] 51_uml-o1-5             07-Jun-2003 07:21    10k
> [ ] 52_alloc_pages-1        30-Mar-2002 12:21     1k
> [ ] 52_uml-sys-read-write-5 13-Feb-2003 20:20     1k
> [ ] 53_uml-cache-shift-1    05-Sep-2002 17:08     1k
> [ ] 54_uml-sa_interrupt-1   31-Aug-2001 18:00     1k

> [ ] 55_uml-highmem-1        16-Nov-2002 22:22     1k
> [ ] 56_uml-pte-highmem-7    09-Jun-2003 10:50     7k
[Note these 2 especially!]
> [ ] 57_uml-kernel-thread-1  29-May-2003 02:11     1k
Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

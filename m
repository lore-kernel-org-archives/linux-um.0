Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AU9ho-0000d9-Sv
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 11:09:04 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AU9ho-0008CV-7F
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 11:09:04 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Locking user-mode kernel RAM into host physical RAM
References: <200312081639.22888.matthew-list@bytemark.co.uk> <200312081901.hB8J1VAv028738@ccure.user-mode-linux.org>
In-Reply-To: <200312081901.hB8J1VAv028738@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312092000.45933.blaisorblade_spam@yahoo.it>
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
Date: Tue, 9 Dec 2003 20:00:45 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:01, luned=EC 8 dicembre 2003, Jeff Dike ha scritto:
> As far as I'm concerned, this is papering over the symptoms rather than
> fixing a real problem.
>
> If you're really not overselling memory, then the host should not be
> swapping. If it is, then that's the problem.
>
> > My experience with 2.4 as  a host kernel is that it will quite happily
> > swap out pages from running  applications to use as disc cache; this
> > is apparently alleviated with 2.6's  "swappiness" kernel parameter.
>
> This being the case, you should maybe be looking at 2.6 as your host.
>
> > I hope that it's obvious enough to warrant inclusion in the next
> > release of  the UML patch
>
> It's not.  Feel free to argue, but this is really the wrong thing to do,
> IMHO.
But anyway, if the "physical memory" of the guest is not guaranted to be=20
actually physical, then the UML's kernel VM will get fooled. What's more,=20
it's the guest's VM which must decide what has to be swapped.
The only swap that must be used is the UML's one. He must be fair to his=20
customer(i.e. no overselling), but done that the host can't swap anything=20
out.

> /dev/anon is a new host driver which implements the munmap semantics need=
ed
> by UML physical memory (pages are release to the host when they're no
> longer mapped, even if they're dirty).
It means that the guest VM will see that the available memory has shrinked =
and=20
that it will swap things out following the new memory limit? It seems to me=
 a=20
little bit difficult. This (if I understand correctly) requires core VM=20
changes(the stock VM isn't much tested with shrinking/increasing memory=20
sizes, if this is supported at all, for strange architectures).

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

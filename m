Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AcU4Q-00036H-86 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jan 2004 10:30:50 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AcU4P-0000aG-Mx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jan 2004 10:30:49 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [UML combo patch] uml-combo-2.6.0-A7
References: <Pine.LNX.4.58.0312171735540.8123@earth>
	<Pine.LNX.4.58.0312181304250.3617@earth>
	<20040101191630.GA23954@elte.hu>
In-Reply-To: <20040101191630.GA23954@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401021929.54997.blaisorblade_spam@yahoo.it>
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
Date: Fri, 2 Jan 2004 19:29:54 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:16, gioved=EC 1 gennaio 2004, Ingo Molnar ha scritto:
> here's a new combo all-in-one UML patch against the vanilla 2.6.0
> kernel:
>
>  	redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A7
>
> i've merged the various fixes collected by Paolo,

Thanks for paying attention to my changes.

> plus fixed a bug in
> the __do_mmap_pgoff() change that caused host kernel bootup hangs.

Yes, I did experience problems with my guest kernel (and today I tracked it=
=20
down to the E* patches), but I didn't know what it is... Aargh! A missing=20
return! Ok, I'm too foolish. Thanks for finding it! (But why the hell GCC=20
3.2.2 doesn't warn about it?)

Two questions:
1) I've added the G-03(this fixes the empty /proc/kallsyms issue), H-03 and=
=20
H-04(for Makefiles cleanups) patches. Would you try them?

2)Have you given a look to the mm/memory.c change (what I'd split into A-04=
)?=20
Do you think that change can be safe even for the host kernel?

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

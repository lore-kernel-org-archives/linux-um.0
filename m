Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj1j8-0007Gx-VF for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:39:54 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aj1j8-0008Hf-BK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:39:54 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.50449.blaisorblade_spam@yahoo.it>
	<87vfn7yikh.fsf@bytesex.org>
In-Reply-To: <87vfn7yikh.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401202042.17851.blaisorblade_spam@yahoo.it>
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
Date: Tue, 20 Jan 2004 20:42:17 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

Alle 18:06, luned=EC 19 gennaio 2004, Gerd Knorr ha scritto:
> BlaisorBlade <blaisorblade_spam@yahoo.it> writes:
> > Module support fix is trivial, and does not depend on anything
> > controversial, until you don't enable CONFIG_MODVERSIONS. So apply the
> > patch. I've also infos (and some code) about fixing the panic you get on
> > startup with it enabled.
>
> Uhm, no.  Applied and builds for me, but doesn't work, insmod
> complains about *plenty* of unknown symbols.

It works for me, maybe either you didn't apply some patch or a make clean=20
ARCH=3Dum is needed.

> G-02-LinkScriptCleanup.patch removes various ksymtab stuff from
> common.lds.S (which is in the RODATA #define these days), that one
> looks like it could be needed too to make modules work ...

Those repeated sections are harmless, only ugly; the big change is for=20
/proc/kallsyms. However, modules worked without that (it helps also for=20
modversions, but not completely: with that I get no panic but versions=20
mismatch, and I know why).

I've not been very careful in testing separate patches one-by-one. I've tes=
ted=20
the whole set minus the H-03 and H-04 one, but not together.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

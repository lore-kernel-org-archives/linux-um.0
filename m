Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNFmE-0000ty-KU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 May 2004 11:45:22 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BNFmE-0002B9-2s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 May 2004 11:45:22 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] patch for 2.6.6-rc1
References: <Pine.LNX.4.58.0404162157280.29213@boston.corp.fedex.com>
	<200404301545.10555.blaisorblade_spam@yahoo.it>
	<006f01c42fc1$d16b4bc0$2000000a@schlepptopp>
In-Reply-To: <006f01c42fc1$d16b4bc0$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405102046.15381.blaisorblade_spam@yahoo.it>
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
Date: Mon, 10 May 2004 20:46:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 23:18, sabato 1 maggio 2004, roland ha scritto:
> Hi Paolo/Jeff,
>
> >Please post the arch/um/kernel/config.c file the build produced, which
> > gave the error. The change to the "QUOTE" line is to be analyzed.
>
> i think the change to  $$config =~ s/\\n/\\\n"\\n"/g probably was a mistake
> (i`m not good in regexes, though). it seems, that all the quotes and \n`s
> are being stripped from that file and so it`s no correct "c-source"
> anymore, imho.
>
> before:
> ---snipp---
> static __initdata char *config = "#\n"
> "# Automatically generated make config: don`t edit\n"
> "#\n"
> "CONFIG_USERMODE=y\n"
> ---snipp---
>
> after applying patch.266rc1-1 and running make again, it is:
> ---snipp---
> static __initdata char *config = "#
> # Automatically generated make config: don`t edit
> #
> CONFIG_USERMODE=y
> ---snipp---
>
> i changed the line in the Makefile back to:
> $$config =~ s/\n/\\n"\n"/g
> which made things better again.
>
> the error i reported is gone, but now "make linux ARCH=um" fails with:
>
> -> see make.log
This is related with the changes by Jeff Chua -  maybe you did not apply them 
well...
> which doesn`t seem to be related to that change of the regex before.
> since this error looks "skas related" for me, i gave it a further try and
> disabled skas support in .config - after that, the compile for that
> "TT only"-UML runs fine for a while, but unfortunately it also fails in
> the end:
>
> -> see make_tt.log

Tried disabling gdb proxy/profiling? That is probably the source of the 
problem.

> so still no 2.6.6-rc1 or 2.6.6-rc2 (tried both)

> err - i have a problem in understanding:
> why PERL code ?
> the statement is in arch/um/kernel/Makefile - is that being parsed by a
> perl interpreter during "make" - or does make just use similar language ?
> sorry if this sounds dumb - but i`m no developer and i never wrote a
> makefile myself.

Look in the lines nearby and you'll see that "perl" is invoked, and that line 
of code is passed to it as the program to execute.



-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Advmz-0007gn-9B for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:18:49 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Advmy-0000Ai-OO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:18:48 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401061718.i06HILtd002620@ccure.user-mode-linux.org>
	<a0602040abc20a9f6862e@[192.168.1.10]>
In-Reply-To: <a0602040abc20a9f6862e@[192.168.1.10]>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401061918.31447.blaisorblade_spam@yahoo.it>
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
Date: Tue, 6 Jan 2004 19:18:31 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:11, marted=EC 6 gennaio 2004, Johannes Formann ha scritto:
> At 12:18 Uhr -0500 06.01.2004, Jeff Dike wrote:
> >No, gdb it, put a breakpoint on panic, get a stack trace when it hits the
> >breakpoint.
>
> I'd run it once without a breakpoint set (after compiling it with
> debug symbols):

you need to type this before starting:

(host gdb) handle SIGSEGV pass nostop noprint=20
(host gdb) handle SIGUSR1 pass nostop noprint

see http://user-mode-linux.sourceforge.net/debugging-skas.html for details.

And we *do* need the backtrace when it hits the breakpoint on panic, please.

Bye and thanks for your reports
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
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

Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fua99-0007Me-2M for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 12:19:51 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user17416)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fua97-0007Ds-Ea
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 12:19:51 -0700
References: <87sllyl2np.fsf@hades.wkstn.nix>
	<200606251638.31879.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
Date: Sun, 25 Jun 2006 20:19:32 +0100
In-Reply-To: <200606251638.31879.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Sun,
	25 Jun 2006 16:38:31 +0200")
Message-ID: <87mzc1hwl7.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] problems compiling 2.6.17 against glibc 2.4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, 25 Jun 2006, blaisorblade@yahoo.it announced authoritatively:
> On Wednesday 21 June 2006 21:38, Nix wrote:
[jmp_buf goes hidden]
>> This vile patch lets me compile but is almost certainly not good enough:
>> however, I don't know what *is* good enough: now that glibc is blocking
>> us from the layout of the jmp_buf, what's to stop them from changing it?
>> (Well, other than that it would break the ABI ;) )
> I made the same thought, but no, they have *already* changed it.
> Search for the message from Ulrich Drepper

It's not easy to find it given that little info :(

>                                            (and if you understand 
> the "security reasons" I'd be curious to hear them);

Well, there are obvious security problems with having pointers in
jmp_buf exposed: attackers who can exploit a buffer overflow and know
the location of a jmp_buf and its layout can force someone to longjmp()
to any location they like, regardless of -fstack-protector tricks. Even
FORTIFY_SOURCE won't protect against it if the buffer overrun didn't use
strcpy() or a similarly fortified call.

>                                                      also the below patch is 
> available in Jeff's tree from some time.

Aha, great minds kludge alike ;)

> I asked Jeff to #ifdef that code out for 2.6.17 release (since the below patch 
> was refused)... anyway Jeff found that we can take setjmp() implementation 
> from klibc and include it in UML.

Well, it wasn't ifdeffed out ;)

Using the uml setjmp() implementation seems like a good idea (or the uClibc one).

-- 
`NB: Anyone suggesting that we should say "Tibibytes" instead of
 Terabytes there will be hunted down and brutally slain.
 That is all.' --- Matthew Wilcox

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

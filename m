Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoVJt-0004OT-Ec for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 15:21:01 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CoVJp-0002jU-PI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 15:21:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<200501110135.55716.rob@landley.net>
	<11049.1105479264@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <11049.1105479264@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501120023.05580.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 00:23:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, Rob Landley <rob@landley.net>

On Tuesday 11 January 2005 22:34, Michael Richardson wrote:
> >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
>
>     Rob> Chapter 5 of current variants of LFS uses the host system to
>     Rob> create a toolchain you can chroot into and build the final
>     Rob> system with.  Then in chapter 6, you build the final system in
>
>   I think the use of chroot is a cop-out.
>
>     Rob> This requires root access (as does creating device nodes,
>     Rob> mounting /proc or loopback devices...  A rather large number of
>
>   I use "fakeroot" to do all of that for embedded work that I do...
What's this?


>   dd if=/dev/zero bs=1024k count=64 of=MYSWAP
Please add a "mkswap MYSWAP" here (or even inside the guest, 
mkswap /dev/ubd1).
>   ./linux ubd1=./MYSWAP
>
>     Rob> The tee output of four consecutive runs is attached.  All I did
>     Rob> each time was ctrl-c out of the hang, cursor up, change the

>     >> You could hit ^C from a hang?

>     Rob> /dev/console attaches to fd0 and fd1.  These are not ttys/ptys
>     Rob> but file descriptors, hence they controlling tty sends the kill

>   Well, usually, once the system is properly initialized, ^C does
> nothing. If you get a kernel panic/hang, I usually have to use kill from
> another window.
Yes, that's because it turns the console to raw mode (don't ask me why).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

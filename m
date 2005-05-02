Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSUFZ-0001VW-2z	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 23:17:49 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DSUFW-00026T-Ri
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 23:17:49 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] The source to that firmware-uml thing is now up...
References: <200504200606.06828.rob@landley.net>
	<200504281938.45043.rob@landley.net>
	<200505011306.39277.blaisorblade@yahoo.it>
In-Reply-To: <200505011306.39277.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200505020114.29408.rob@landley.net>
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
Date: Mon, 2 May 2005 01:14:29 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sunday 01 May 2005 07:06 am, Blaisorblade wrote:

> > (That said, if you do use -p to get get a setuid bash, there's several
> > other things you should do to make this marginally less dangerous.  And I
> > wouldn't trust myself to remember them all off the top of my head...)
>
> No, I'm not saying that a setuid bash won't work because of the bash
> special code.
>
> I'm saying that setuid script plain don't work (the kernel ignores the
> setuid bit). Except for perl, which has a special mechanism to make them
> work anyway.

I got this to work once, a few years back (under an early 2.4 kernel).  The 
setuid bit wasn't on the bash executable (that would be insane), it was on 
the script.

I don't remember the details (it was a few years ago now) but at one point it 
was possible.  I vaguely remember tracing through both bash and the kernel 
code to see what the heck it was actually doing, and I think there was 
something funky and non-obvious about permissions, or some such...

And if the perl executable isn't itself suid, then what special mechanism can 
the perl executable have to execute stuff as root if the kernel isn't passing 
it root access when you run the script?  This "special mechanism" would 
either have to be the suid bit on the perl executable (which my /usr/bin/perl 
hasn't got) or some mechanism for cracking root access as a normal user, 
doesn't it?

No, if I remember correctly bash was the problem, in the same holier than thou 
"we are the FSF, we know better than you because you are dumb and we must 
protect you from yourself" way that gcc's collect2 won't search the path for 
ld if the $PATH has "." in it (even at the end), which is the default path in 
UML by the way.  (That took a while to track down...)

> > That said, I wasn't thinking of using bash for the wrapper but either
> > python or C.  It's just easier to secure them...
>
> Ok, for C no problem. No idea if python supports a similar trick.

I got that to work once too.  I vaguely recall I had to specify -E, and 
possibly some other stuff...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
